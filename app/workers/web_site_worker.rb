require 'open3'

class WebSiteWorker
  include Sidekiq::Worker

  def perform(rank, url)
    root_dir = Rails.root.to_s
    capture = "#{root_dir}/lib/assets/capture.coffee"

    name, status = Open3.capture2("casperjs #{capture} --url=#{url} --root_dir=#{root_dir}")
    puts "name: #{name}"
    puts "status: #{status}"
  end
end
