class AddThumbNailToWebSites < ActiveRecord::Migration
  def change
    add_column :web_sites, :thumb_nail, :binary
  end
end
