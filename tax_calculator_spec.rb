require './tax_calculator'

RSpec.describe "Tax Calculator" do
  it "should read file and parse it" do
    calculator = TaxCalculator.new("./test_inputs/input1.csv")
    expect(calculator.items.size).to eq(3) 
    expect(calculator.items[0].quantity).to eq(2)
    expect(calculator.items[0].name).to eq("book")
    expect(calculator.items[0].unit_price).to eq(12.49)
    expect(calculator.items[0].imported).to eq(false)

    expect(calculator.items[1].quantity).to eq(1)
    expect(calculator.items[1].name).to eq("music CD")
    expect(calculator.items[1].unit_price).to eq(14.99)
    expect(calculator.items[1].imported).to eq(false)
    
    expect(calculator.items[2].quantity).to eq(1)
    expect(calculator.items[2].name).to eq("chocolate bar")
    expect(calculator.items[2].unit_price).to eq(0.85)
    expect(calculator.items[2].imported).to eq(false)
  end

  it "should calculate proper sale tax" do
    calculator = TaxCalculator.new("./test_inputs/input1.csv")
    expect(calculator.total_sale_tax.round(2)).to eq(1.50)
  end

  it "should calculate proper import tax" do
    calculator = TaxCalculator.new("./test_inputs/input2.csv")
  end

  it "should round to the nearest 0.05" do
    calculator = TaxCalculator.new("./test_inputs/input1.csv")
    rounded_value = calculator.round_tax(1.235, 0.05)
    expect(rounded_value).to eq(1.25)
  end

  it "should print statement" do
    calculator1 = TaxCalculator.new("./test_inputs/input1.csv")
    puts "Statement Input 1:\n\n"
    calculator1.print_statement
    puts "====================\n\n"
    calculator2 = TaxCalculator.new("./test_inputs/input2.csv")
    puts "Statement Input 2:\n\n"
    calculator2.print_statement
    puts "====================\n\n"
    calculator3 = TaxCalculator.new("./test_inputs/input3.csv")
    puts "Statement Input 3:\n\n"
    calculator3.print_statement
    puts "====================\n\n"
  end
end
