version=6.2.5
for base_theme in midnight modern simple site; do
  echo $base_theme
  curl -O https://unpkg.com/tabulator-tables@${version}/dist/css/tabulator_${base_theme}.min.css
done

for framework_theme in bootstrap3 bootstrap4 bootstrap5 bulma materialize semanticui; do
  echo $framework_theme
  curl -O https://unpkg.com/tabulator-tables@${version}/dist/css/tabulator_${framework_theme}.min.css
done
