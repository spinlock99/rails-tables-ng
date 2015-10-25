module API
  module V1
    class WebSites < Grape::API
      include API::V1::Defaults

      resource :web_sites do
        desc 'Return all web sites'
        get '', root: :web_sites do
          WebSite.all
        end

        desc 'Return a web site'
        params do
          requires :id, type: String, desc: 'Web site ID'
        end
        get ':id', root: 'web_site' do
          WebSite.where(id: permitted_params[:id]).first!
        end
      end
    end
  end
end
