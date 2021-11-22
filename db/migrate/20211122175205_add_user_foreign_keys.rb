class AddUserForeignKeys < ActiveRecord::Migration[6.1]
  def change

    add_foreign_key :events, :users, on_delete: :cascade
    add_foreign_key :tasks, :events, on_delete: :cascade

  end
end
