"use strict";
(() => {
  // built/utils.js
  function convertToDataFrame(data) {
    const res = {};
    if (data.length === 0) {
      return res;
    }
    const keys = Object.keys(data[0]);
    keys.forEach((key) => res[key] = data.map((item) => item[key]));
    return res;
  }

  // built/events.js
  function addEventListeners(table, el) {
    table.on("rowClick", function(e, row) {
      const inputName = `${el.id}_row_clicked`;
      console.log(inputName, row.getData());
      Shiny.onInputChange(inputName, row.getData());
    });
    table.on("rowClick", (e, row) => {
      const inputName = `${el.id}_rows_selected:rtabulator.data`;
      const data = table.getSelectedRows().map((row2) => row2.getData());
      console.log(inputName, data);
      Shiny.onInputChange(inputName, { data: convertToDataFrame(data) });
    });
    table.on("cellEdited", function(cell) {
      const inputName = `${el.id}_cell_edited`;
      console.log(inputName, cell.getData());
      Shiny.onInputChange(inputName, cell.getData());
    });
    table.on("dataFiltered", function(filters, rows) {
      const inputName = `${el.id}_data_filtered:rtabulator.data`;
      const data = rows.map((row) => row.getData());
      console.log(inputName, data);
      Shiny.onInputChange(inputName, { data: convertToDataFrame(data) });
    });
  }

  // built/widget.js
  function run_calls(tabulatorWidget, calls) {
    const table = tabulatorWidget.getTable();
    const elementId = tabulatorWidget.getElementId();
    const bindingLang = tabulatorWidget.getBindingLang();
    console.log("binding lang", bindingLang);
    calls.forEach(([method_name, options]) => {
      if (method_name === "getData") {
        const inputName = bindingLang === "r" ? `${elementId}_data:rtabulator.data` : `${elementId}_data`;
        console.log("custom call", inputName);
        Shiny.setInputValue(inputName, { data: convertToDataFrame(table.getData()) }, { priority: "event" });
        return;
      }
      if (method_name === "deleteSelectedRows") {
        console.log("custom call");
        const rows = table.getSelectedRows();
        rows.forEach((row) => {
          console.log(row.getIndex());
          table.deleteRow(row.getIndex());
        });
        return;
      }
      if (method_name === "getSheetData") {
        const inputName = bindingLang === "r" ? `${elementId}_sheet_data:rtabulator.sheet_data` : `${elementId}_sheet_data`;
        console.log("custom call", inputName);
        Shiny.setInputValue(inputName, { data: table.getSheetData() }, { priority: "event" });
        return;
      }
      console.log(method_name, options);
      table[method_name](...options);
    });
  }
  var TabulatorWidget = class {
    constructor(container, data, options, bindingOptions) {
      options.data = data;
      this._container = container;
      this._bindingOptions = bindingOptions;
      console.log("columns", options.columns);
      if (data !== null && options.columns == null) {
        options.autoColumns = true;
      }
      if (options.spreadsheet && options.spreadsheetData == null) {
        options.spreadsheetData = [];
      }
      this._table = new Tabulator(this._container, options);
      if (typeof Shiny === "object") {
        addEventListeners(this._table, this._container);
        this._addShinyMessageHandler();
      }
    }
    _addShinyMessageHandler() {
      const messageHandlerName = `tabulator-${this._container.id}`;
      Shiny.addCustomMessageHandler(messageHandlerName, (payload) => {
        console.log(payload);
        run_calls(this, payload.calls);
      });
    }
    getTable() {
      return this._table;
    }
    getElementId() {
      return this._container.id;
    }
    getBindingLang() {
      return this._bindingOptions.lang;
    }
  };

  // built/index-r.js
  function tabulatorFactory(widgetElement, width, height) {
    let table = null;
    function renderValue(payload) {
      console.log(payload);
      if (payload.stylesheetText) {
        document.head.insertAdjacentHTML("beforeend", `<style>${payload.stylesheetText}</style>`);
      }
      if (payload.options === null) {
        payload.options = {};
      }
      let data = null;
      if (payload.options.spreadsheet === true) {
        payload.options.spreadsheetData = payload.data;
      } else {
        data = HTMLWidgets.dataframeToD3(payload.data);
      }
      const widget = new TabulatorWidget(widgetElement, data, payload.options, payload.bindingOptions);
      table = widget.getTable();
    }
    function resize(width2, height2) {
    }
    return { renderValue, resize };
  }
  HTMLWidgets.widget({
    name: "rtabulator",
    type: "output",
    factory: tabulatorFactory
  });
})();
