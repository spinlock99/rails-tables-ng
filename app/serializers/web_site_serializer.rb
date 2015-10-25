class WebSiteSerializer < ActiveModel::Serializer
  attributes :id, :name, :url, :alexa_global_rank
end
