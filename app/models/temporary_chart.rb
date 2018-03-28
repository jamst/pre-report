class TemporaryChart < ApplicationRecord
  belongs_to :temporary_report	

  enum chart_type: {
    line: 0,   #折线图
    bar: 1   #柱状图
  }

  def get_report_sql(params)
    conditions = self.temporary_report.report_conditions 
    conditions.each do |c|
      eval %Q(	
        @#{c.report_key} = params[:search_params].present? && params[:search_params]["#{c.report_key}"].present? ? params[:search_params]["#{c.report_key}"] :  "" 
        @condition_#{c.report_key} = params[:search_params].present? && params[:search_params]["#{c.report_key}"].present? ? "#{c.report_condition}" : ""
      )
    end
    sql = eval %Q( %Q(#{self.chart_data}) ) 
    sql = (sql.downcase.include?("delete") || sql.downcase.include?("truncate")) ? "select 'SQL不允许有危险字断出现' " : sql
  end

  def child_charts
    TemporaryChart.where(parent_id:self.id)
  end

  def parent
    TemporaryChart.find(self.parent_id)
  end

  

end
