#
# Define all web scraping rake tasks here.
#
namespace :scrape do
  desc 'Scrape top 100 websites from alexa.com and store in postgres.'
  task alexa: :environment do
    system 'bash', '-c', <<-'DOC'
      pushd /tmp 1> /dev/null
        wget --quiet http://s3.amazonaws.com/alexa-static/top-1m.csv.zip
        unzip top-1m.csv.zip 1> /dev/null
        rm top-1m.csv.zip
        gsed --in-place \
             --expression '101,$ d' \
             --expression '1{ s/\(.*\)/rank, url\n\1/ }' \
             top-1m.csv
      popd 1> /dev/null
    DOC
    SmarterCSV.process('/tmp/top-1m.csv', chunk_size: 10) do |chunk|
      chunk.each do |web_site|
        WebSiteWorker.perform_async(web_site[:rank], web_site[:url])
      end
    end
    system 'rm', '/tmp/top-1m.csv'
  end
end
