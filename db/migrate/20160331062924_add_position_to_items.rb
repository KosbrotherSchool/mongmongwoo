class AddPositionToItems < ActiveRecord::Migration
  def change
    add_column :items, :position, :integer, default: 1
  end
end