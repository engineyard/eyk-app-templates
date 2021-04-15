class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.integer :article_id
      t.integer :author_id
      t.string :comment_text

      t.timestamps
    end
  end
end
