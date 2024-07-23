class AddColumnWorkingDaysToTrain < ActiveRecord::Migration[7.1]
  def change
    add_column :trains, :working_days, :string, array: true, default: ["Mon", "Tue", "Wed", "Thr", "Fri", "Sat", "Sun"]
  end
end
