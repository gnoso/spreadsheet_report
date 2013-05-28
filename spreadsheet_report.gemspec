# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'spreadsheet_report/version'

Gem::Specification.new do |spec|
  spec.name          = "spreadsheet_report"
  spec.version       = SpreadsheetReport::VERSION
  spec.authors       = ["Alan Johnson", "Taylor Shuler"]
  spec.email         = ["alan@gnoso.com", "taylorshuler@aol.com"]
  spec.description   = %q{Spreadsheet_report is a simple tool for dumping SQL data into Google Spreadsheets.}
  spec.summary       = %q{A simple tool for dumping SQL data into Google Spreadsheets.}
  spec.homepage      = "https://github.com/gnoso/spreadsheet_report"
  spec.license       = "Apache License 2.0"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  
  spec.add_dependency "commondream-google-spreadsheet-ruby", ">= 0.0.4"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
