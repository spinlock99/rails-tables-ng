class WebSiteWorker
  include Sidekiq::Worker

  def perform(rank, url)
    puts "rank: #{rank}, url: #{url}"
  end
end
