require 'google_spreadsheet'
require 'ruby-debug'

class SpreadsheetReport
  
  def initialize(username, password, spreadsheet_key, &block)
    @session = GoogleSpreadsheet.login(username, password)
    @spreadsheet = @session.spreadsheet_by_key(spreadsheet_key)
    
    yield(self)
  end
  
  def worksheet(name, query)
    worksheet = @spreadsheet.worksheets.find { |ws| ws.title == name }
    
    # create the worksheet if we didn't find it
    if worksheet == nil
      worksheet = @spreadsheet.add_worksheet(name)
    end
    
    # run the query
    result = ActiveRecord::Base.connection.select_all(query)
    
    # clear the worksheet
    worksheet.max_rows = 1
    worksheet.max_cols = 1
    worksheet[1, 1] = "No data was returned for your report"
    worksheet.save
    
    # if the result size is 0, just return
    return if result.size == 0
    
    # resize the worksheet
    worksheet.max_rows = result.size + 1
    keys = result[0].keys
    worksheet.max_cols = keys.size
    
    # add the title cells
    keys.each_with_index do |key, index|
      worksheet[1, index + 1] = key
    end
    
    current_row = 2
    result.each do |row_data|
      keys.each_with_index do |key, index|
        worksheet[current_row, index + 1] = row_data[key]
      end
      current_row += 1
    end
    
    worksheet.save
  end
end