class CreatePoll < ActiveRecord::Migration[5.1]
  def change
    create_table :polls do |t|
      t.string :item
      t.integer :count
    end
  end
end
