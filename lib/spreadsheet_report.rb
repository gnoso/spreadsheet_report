require 'google_spreadsheet'

class SpreadsheetReport
  
  def initialize(username, password, spreadsheet_key, &block)
    @session = GoogleSpreadsheet.login(username, password)
    @spreadsheet = @session.spreadsheet_by_key(spreadsheet_key)
    
    yield(self)
  end
  
  def worksheet(name, query)
    worksheet = @spreadsheet.worksheets.find { |ws| ws.title == name }
    
    # create the worksheet if we didn't find it
    if worksheet != nil
      worksheet.delete
      worksheet = nil
    end

    # run the query
    result = ActiveRecord::Base.connection.select_all(query)
    
    # resize the worksheet
    rows = result.size + 1
    keys = []
    if result.size > 0
      keys = result[0].keys
    end
    cols = keys.size
    worksheet = @spreadsheet.add_worksheet(name, result.size + 1, keys.size)
    
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
      
      if current_row % 250 == 0
        worksheet.save
      end
    end
    
    worksheet.save
  end
end