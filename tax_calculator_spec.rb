require './tax_calculator'
require './csv_parser'

RSpec.describe "Tax Calculator" do
  include CSVParser
  it "should calculate proper sale tax" do
    items = parse_file("./test_inputs/input1.csv")
    calculator = TaxCalculator.new(items)
    expect(calculator.total_sale_tax.round(2)).to eq(1.50)
  end

  it "should calculate proper import tax" do
    items = parse_file("./test_inputs/input2.csv")
    calculator = TaxCalculator.new(items)
    expect(calculator.imported_tax).to eq(2.875)
  end

  it "should print statement" do
    items1 = parse_file("./test_inputs/input1.csv")
    items2 = parse_file("./test_inputs/input2.csv")
    items3 = parse_file("./test_inputs/input3.csv")
    calculator1 = TaxCalculator.new(items1)
    puts "\n\nStatement Input 1:\n\n"
    calculator1.print_statement
    puts "====================\n\n"
    calculator2 = TaxCalculator.new(items2)
    puts "Statement Input 2:\n\n"
    calculator2.print_statement
    puts "====================\n\n"
    calculator3 = TaxCalculator.new(items3)
    puts "Statement Input 3:\n\n"
    calculator3.print_statement
    puts "====================\n\n"
  end
end
