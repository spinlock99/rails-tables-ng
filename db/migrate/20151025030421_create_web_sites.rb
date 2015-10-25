class CreateWebSites < ActiveRecord::Migration
  def change
    create_table :web_sites do |t|
      t.string :name
      t.string :url
      t.integer :alexa_global_rank

      t.timestamps null: false
    end
  end
end
