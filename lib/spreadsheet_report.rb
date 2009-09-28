require 'google_spreadsheet'

class SpreadsheetReport
  
  def initialize(username, password, spreadsheet_key, &block)
    @session = GoogleSpreadsheet.login(username, password)
    @spreadsheet = @session.spreadsheet_by_key(spreadsheet_key)
    
    yield(self)
  end
  
  # Writes a report to a worksheet. By default, if cols is left nil, the report
  # will base cols on the results of the query (but it's a hash, so no ordering
  # is guaranteed). If cols is given, only those columns are reported, and the
  # spreadsheet columns are populated in the order that they are given.
  def worksheet(name, query, cols = nil)
    worksheet = @spreadsheet.worksheets.find { |ws| ws.title == name }
    
    # create the worksheet if we didn't find it
    if worksheet != nil
      worksheet.delete
      worksheet = nil
    end

    # run the query
    result = ActiveRecord::Base.connection.select_all(query)

    # figure out the column names being used
    if cols.nil? && result.size > 0
      cols = result[0].keys      
    end
    
    # resize the worksheet
    worksheet = @spreadsheet.add_worksheet(name, result.size + 1, cols.size)
    
    # add the title cells
    cols.each_with_index do |key, index|
      worksheet[1, index + 1] = key
    end
    
    current_row = 2
    result.each do |row_data|
      cols.each_with_index do |key, index|
        worksheet[current_row, index + 1] = row_data[key]
      end
      current_row += 1
      
      if current_row % 250 == 0
        worksheet.save
      end
    end
    
    worksheet.save
    worksheet.synchronize
  end
end