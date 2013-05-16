require File.dirname(__FILE__) + '/../lib/spreadsheet_report'

SpreadsheetReport.new(ENV['G_USERNAME'], ENV['G_PASSWORD'], 
    ENV['SPREADSHEET']) do |sr|
  sr.worksheet("User Data", <<-EOF)
    SELECT DATE(created_at), COUNT(*)
    FROM users
    WHERE realm_id = 4
    GROUP BY DATE(users.created_at)
  EOF
end