# Pin npm packages by running ./bin/importmap

pin "application"
# @import "bootstrap"と記載すると、gem内のbootstrap.min.jsが読み込まれる。
# preload；実際にJavaScriptが読み込まれるよりも前にライブラリを読み込む。→ 遅延を避ける事ができる。
pin "bootstrap", to: "bootstrap.min.js", preload: true
pin "popper", to: "popper.js", preload: true
pin "@rails/ujs", to: "https://ga.jspm.io/npm:@rails/ujs@7.1.3-4/app/assets/javascripts/rails-ujs.esm.js"