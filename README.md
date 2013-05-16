# Spreadsheet Report
Spreadsheet Report is a simple tool for dumping SQL data into Google Spreadsheets.

## Installation
Spreadsheet Report's gem is being hosted on Gemcutter, so you'll need to be set up with them. Find out more at http://gemcutter.org. Once you're set up with Gemcutter, install Spreadsheet Report by executing:

```shell
gem install spreadsheet_report
```

## Usage
Here is a basic usage:

```ruby
require 'spreadsheet_report'
    
    SpreadsheetReport.new('username', 'password', 'spreadsheet_key') do |sr|
      sr.worksheet("User Data", <<-EOF, ["date", "count"])
        SELECT DATE(created_at) as date, COUNT(*) as count
        FROM users
        GROUP BY DATE(users.created_at)
      EOF
    end
```
(An example template is included under lib/spreadsheet_report/templates)

### How it works
The Spreadsheet Report initializer takes a Google username and password, and the id of the spreadsheet. The key of a spreadsheet can be found in the key parameter of the url for the spreadsheet.

The worksheet method creates a new worksheet if a worksheet with the given name doesn't already exist, or uses the existing worksheet. If the optional columns
parameter is given to the worksheet method, only the columns with the given names are added to the spreadsheet, in the order that they are specified.

Spreadsheet Report assumes that you've got a working connection with ActiveRecord already set up. So, the easiest way to run a report is to create a source file with your report code in it, and then run it with the rails script/runner script.