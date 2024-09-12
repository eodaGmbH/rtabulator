#!/bin/sh
branch=${1:-dev}
curl -O https://raw.githubusercontent.com/eodaGmbH/tabulator-bindings/${branch}/r-bindings/rtabulator.js
