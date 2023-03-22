require './billing_item'
require './constants'
include Constants
RSpec.describe "Billing Item" do
  it "should retrieve proper taxes without rounding for a non imported item" do
    quantity = 1
    name = "music CD"
    price = 14.99
    imported = false
    expected_sale_tax = (quantity * price) * SALE_TAX_RATE
    expected_imported_tax = 0
    
    item = BillingItem.new(quantity, name, price, imported)
    expect(item.sale_tax).to eq(expected_sale_tax)
    expect(item.imported_tax).to eq(0)
  end

  it "should retrieve proper taxes for an imported item with sale tax exception" do
    quantity = 1
    name = "box of chocolates"
    price = 10.00
    imported = true
    expected_sale_tax = 0
    expected_imported_tax = (quantity * price) * IMPORTED_TAX_RATE
    
    item = BillingItem.new(quantity, name, price, imported)
    expected_tax = 10.00 * IMPORTED_TAX_RATE
    expect(item.sale_tax).to eq(expected_sale_tax)
    expect(item.imported_tax).to eq(expected_imported_tax)
  end

  it "should retrieve proper taxes for an imported item without sale tax exception" do
    quantity = 1
    name = "bottle of perfume"
    price = 47.50
    imported = true
    expected_sale_tax = (quantity * price) * SALE_TAX_RATE
    expected_imported_tax = (quantity * price) * IMPORTED_TAX_RATE

    item = BillingItem.new(quantity, name, price, imported)
    expect(item.sale_tax).to eq(expected_sale_tax)
    expect(item.imported_tax).to eq(expected_imported_tax)
  end

  it "should calculate right total amount before taxes" do 
    quantity = 5
    name = "bottle of perfume"
    price = 47.50
    imported = true
    expected_amount = quantity * price

    item = BillingItem.new(quantity, name, price, imported)
    expect(item.total_amount_before_taxes).to eq(expected_amount)
  end

  it "should calculate right total amount with taxes" do 
    quantity = 5
    name = "bottle of perfume"
    price = 47.50
    imported = true
    total_amount_before_taxes = quantity * price
    expected_sale_tax = total_amount_before_taxes * SALE_TAX_RATE
    expected_imported_tax = total_amount_before_taxes * IMPORTED_TAX_RATE
    expected_total_amount = total_amount_before_taxes + expected_sale_tax + expected_imported_tax
    
    item = BillingItem.new(quantity, name, price, imported)
    expect(item.total_amount_before_taxes).to eq(total_amount_before_taxes)
    expect(item.sale_tax).to eq(expected_sale_tax)
    expect(item.imported_tax).to eq(expected_imported_tax)
    expect(item.total).to eq(expected_total_amount)
  end


end