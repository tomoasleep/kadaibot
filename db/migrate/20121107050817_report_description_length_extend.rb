class ReportDescriptionLengthExtend < ActiveRecord::Migration
  def up
    change_column :reports, :description, :text
  end

  def down
    change_column :reports, :description, :string
  end
end
