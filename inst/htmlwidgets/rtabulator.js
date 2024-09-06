(() => {
  // srcjs/index-r.js
  function tabulatorFactory(widgetElement, width, height) {
    let table = null;
    function renderValue(widgetData) {
      console.log(widgetData);
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
