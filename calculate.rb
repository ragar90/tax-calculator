require './tax_calculator'

items_file_name = ARGV[0]

calculator = TaxCalculator.new(items_file_name)
calculator.print_statement

