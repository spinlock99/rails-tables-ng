require 'open3'

class WebSiteWorker
  include Sidekiq::Worker

  def perform(rank, url)
    root_dir = Rails.root.to_s
    capture = "#{root_dir}/lib/assets/capture.coffee"

    name, error, status = Open3.capture3("casperjs #{capture} --url=#{url} --root_dir=#{root_dir}")
    if status.success?
      screen_shot = File.read("#{Rails.root}/tmp/#{url}.png")
      thumbnail, error, status = Open3.capture3('convert -thumbnail 80 png:- png:-', stdin_data: screen_shot, binmode: true)
      web_site = WebSite.find_or_create_by(alexa_global_rank: rank)
      web_site.update_attributes name: name,
                                 url: url,
                                 screen_shot: screen_shot,
                                 thumb_nail: thumbnail
    else
      raise "failed to capture #{url}.\nerror: #{error}."
    end
  end

  sidekiq_retries_exhausted do |error|
    # send email to admin, etc... to alert that job is dead.
  end
end
