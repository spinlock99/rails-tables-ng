ActiveAdmin.register WebSite do
  permit_params :id, :name, :url, :alexa_global_rank, :thumb_nail, :screen_shot
  config.per_page = 25

  index do
    selectable_column
    column :name
    column :url
    column :alexa_global_rank
    column :thumb_nail do |web_site|
      image_tag "data:image/jpg;base64,#{Base64.encode64(web_site.thumb_nail)}" if web_site.thumb_nail
    end
    actions
  end

  show do
    attributes_table do
      row :url
      row :alexa_global_rank
      row :screen_shot do |web_site|
        image_tag "data:image/jpg;base64,#{Base64.encode64(web_site.screen_shot)}" if web_site.screen_shot
      end
    end
  end

  form do |f|
    inputs 'Details' do
      input :name
      input :url
    end
    actions
  end
end
