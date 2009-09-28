PKG_VERSION = "0.0.6"

Gem::Specification.new do |s|
  
  s.name = 'spreadsheet_report'
  s.version = PKG_VERSION
  s.platform = Gem::Platform::RUBY
  s.summary = <<-DESC.strip.gsub(/\n\s+/, " ")
    Simple tool for running queries against ActiveRecord and putting them
    into a Google Spreadsheet.
  DESC

  s.files = ['lib/spreadsheet_report.rb']
  s.require_path = 'lib'
  s.has_rdoc = true

  s.author = "Gnoso, Inc."
  s.email = "alan@gnoso.com"
  s.homepage = "http://www.gnoso.com"
  
  s.add_dependency "commondream-google-spreadsheet-ruby", ">= 0.0.4"
end