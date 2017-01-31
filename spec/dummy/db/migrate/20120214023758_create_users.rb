class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users, id: :uuid do |t|

      t.timestamps
    end
  end
end
