class AddInputTypeToReportConditions < ActiveRecord::Migration[5.0]
  def change
  	add_column :report_conditions, :input_type, :string, comment: "搜索框类型hidden/select/time/text/textear"
  	add_column :report_conditions, :input_source, :string, comment: "搜索框数据源"
  end
end
