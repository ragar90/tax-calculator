require './csv_parser'
require './billing_item'
include CSVParser
RSpec.describe "CSVParser" do
  it "should read a file and return the exact same of elements the csv has" do
    filename = "./test_inputs/input1.csv"
    items = parse_file(filename)
    expect(items.size).to eq(3) #The number 3 comes from the record in input1.csv
    items.each_with_index do |item, index|
      expect(item.class).to eq(BillingItem)
      case index
        when 0
          expect(item.quantity).to eq(2)
          expect(item.name).to eq("book")
          expect(item.unit_price).to eq(12.49)
          expect(item.imported).to eq(false)
        when 1
          expect(item.quantity).to eq(1)
          expect(item.name).to eq("music CD")
          expect(item.unit_price).to eq(14.99)
          expect(item.imported).to eq(false)
        when 2
          expect(item.quantity).to eq(1)
          expect(item.name).to eq("chocolate bar")
          expect(item.unit_price).to eq(0.85)
          expect(item.imported).to eq(false)
      end
    end
  end

  it "should raise a RuntimeError when not filename is provided" do
    expect{ parse_file("")}.to raise_error("Can not read empty file")
    expect{ parse_file(nil)}.to raise_error("Can not read empty file")
  end
end