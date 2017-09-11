class AddParentIdToTemporaryCharts < ActiveRecord::Migration[5.0]
  def change
  	add_column :temporary_charts, :parent_id, :integer
  end
end
