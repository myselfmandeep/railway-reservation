class AddSeatIdAndRemoveBerthColumnFromTickets < ActiveRecord::Migration[7.1]
  def change
    # add_co
    add_reference :tickets, :seat, foreign_key: true
    remove_column :tickets, :berth, :string
  end
end
