casper = require('casper').create()
url = casper.cli.get('url')
root_dir = casper.cli.get('root_dir')

casper.start("http://#{url}")
  .then(-> @capture("#{root_dir}/tmp/#{url}.jpg"))
  .then(-> @echo(@getTitle()))

casper.run()
