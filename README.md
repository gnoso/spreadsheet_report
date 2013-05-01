# Spreadsheet Report

Spreadsheet Report is a simple tool for dumping SQL data into Google Spreadsheets.

## Installation

Spreadsheet Report depends on a fork of google-spreadsheet-ruby gem:

```shell
gem install commondream-google-spreadsheet-ruby
```

We're hosting spreadsheet_report's gem on Gemcutter, so you'll need to be set up with them. Find out more at http://gemcutter.org. Once you're set up with Gemcutter, install spreadsheet_report with:

```shell
gem install spreadsheet_report
```

## Usage

Sorry, I don't have any documentation at this point, but it'll be there soon. Here's the basic usage:

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

The SpreadsheetReport initializer takes a Google username and password, and the id of the spreadsheet. The key of a spreadsheet can be found in the key parameter of the url for the spreadsheet.

The worksheet method creates a new worksheet if a worksheet with the name given doesn't already exist, or uses the existing worksheet. If the optional columns
parameter is given to the worksheet method, only the columns with the names given are added to the spreadsheet, in the order that they are specified.

Spreadsheet Report assumes that you've got a working connection with ActiveRecord already set up. So, the easiest way to run a report is to create a source file with your report code in it, and then run it with the rails script/runner script.
