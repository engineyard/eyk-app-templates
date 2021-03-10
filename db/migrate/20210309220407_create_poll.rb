class CreatePoll < ActiveRecord::Migration[5.1]
  def change
    create_table :polls do |t|
      t.string :name
      t.string :choice_one
      t.string :choice_two
      t.string :choice_three
      t.string :choice_four
    end
    create_table :answers do |t|
      t.integer :poll_id
      t.string :item
      t.integer :count
    end
  end
end
