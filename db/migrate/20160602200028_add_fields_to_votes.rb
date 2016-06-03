class AddFieldsToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :comment, :string
    add_column :votes, :day, :string
    add_column :votes, :time, :string
  end
end
