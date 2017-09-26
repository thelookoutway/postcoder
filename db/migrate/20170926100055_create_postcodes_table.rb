class CreatePostcodesTable < ActiveRecord::Migration[5.1]
  def change
    create_table :postcodes do |t|
      t.integer :postcode, index: :unique
      t.string :suburb
      t.string :state
      t.decimal :lat
      t.decimal :lng
      t.st_point :lonlat
    end

    add_index :postcodes, :lonlat, using: :gist
  end
end
