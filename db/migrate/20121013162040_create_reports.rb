class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :name
      t.string :description
      t.string :link
      t.datetime :deadline

      t.timestamps
    end
  end
end
