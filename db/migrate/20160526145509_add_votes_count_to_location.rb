class AddVotesCountToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :votes_count, :integer
  end
end
