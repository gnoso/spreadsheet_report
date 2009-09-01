Spreadsheet Report
==================

Spreadsheet Report is a simple tool for dumping SQL data into Google Spreadsheets.

Installation
------------

Spreadsheet Report depends on a fork of google-spreadsheet-ruby gem:

gem install commondream-google-spreadsheet-ruby

We're hosting spreadsheet_report's gem on Gemcutter, so you'll need to be set up with them. Find out more at http://gemcutter.org. Once you're set up with Gemcutter, install spreadsheet_report with:

gem install spreadsheet_report

Usage
-----

Sorry, I don't have any documentation at this point, but it'll be there soon. Here's the basic usage:

    require 'spreadsheet_report'
    
    SpreadsheetReport.new('username', 'password', 'spreadsheet_key') do |sr|
      sr.worksheet("User Data", <<-EOF)
        SELECT DATE(created_at), COUNT(*)
        FROM users
        GROUP BY DATE(users.created_at)
      EOF
    end

The SpreadsheetReport initializer takes a Google username and password, and the id of the spreadsheet. The key of a spreadsheet can be found in the key parameter of the url for the spreadsheet.

The worksheet method creates a new worksheet if a worksheet with the name given doesn't already exist, or uses the existing worksheet.

Spreadsheet Report assumes that you've got a working connection with ActiveRecord already set up. So, the easiest way to run a report is to create a source file with your report code in it, and then run it with the rails script/runner script.

License
-------
Copyright (c) 2009 Gnoso, Inc.

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
