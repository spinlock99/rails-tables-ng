class AddScreenShotToWebSites < ActiveRecord::Migration
  def change
    add_column :web_sites, :screen_shot, :binary
  end
end
