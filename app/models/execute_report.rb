class ExecuteReport

  attr_accessor :sql,:report
  def initialize(sql)
  	@sql = sql
    @report = execute_sql
  end

  # 解析sql
  def execute_sql
    cullent_attributes = FromDB.connection.execute(@sql)
  end

  # 生成EXCELL
  def to_xlsx(name,columns,search_conditions = nil)
      file = Spreadsheet::Workbook.new
 
      list = file.create_worksheet :name => name
       start_i = 0
      if search_conditions.present?
        list.row(0).concat search_conditions 
        start_i = 1
      end
      list.row(start_i).concat columns
   
      report.each_with_index { |report_date, i|
        list.row(i+1+start_i).concat report_date
      }

      list.row(report.size+5).concat search_conditions if search_conditions.present?

      xls_report = StringIO.new 
      file.write xls_report 
      xls_report.string 
  end

  # 传参生成EXCELL
  def self.to_xlsx(name,columns,report_data,search_conditions = nil)
      file = Spreadsheet::Workbook.new
 
      list = file.create_worksheet :name => name
      start_i = 0
      if search_conditions.present?
        list.row(0).concat search_conditions 
        start_i = 1
      end
      list.row(start_i).concat columns
      report_data.each_with_index { |report, i|
        list.row(i+1+start_i).concat report
      }
      xls_report = StringIO.new 
      file.write xls_report 
      xls_report.string 
  end

end    




