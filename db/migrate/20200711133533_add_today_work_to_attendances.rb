class AddTodayWorkToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :today_work, :boolean
  end
end
