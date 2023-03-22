require './tax_calculator'
require './csv_parser'
include CSVParser
begin
  filename = ARGV[0]  
  items = parse_file(file_name)
  calculator = TaxCalculator.new(items)
  calculator.print_statement
rescue 
end