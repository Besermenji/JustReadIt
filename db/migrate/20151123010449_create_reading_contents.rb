class CreateReadingContents < ActiveRecord::Migration
  def change
    create_table :reading_contents do |t|
      t.belongs_to :user, index:true
      t.string :title
      t.text :content
      t.string :url		
      t.timestamps
    end
  end
end
