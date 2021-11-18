class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.text :reply
      t.belongs_to :event, foreign_key: true

      t.timestamps
    end
  end
end
