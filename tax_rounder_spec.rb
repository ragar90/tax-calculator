require './constants'
require './tax_rounder'
include Constants
include TaxRounder

RSpec.describe "Tax Rounder" do
  it "should round to the nearest 0.05" do
    number_to_be_rounded = 1.67
    expect(round_tax(number_to_be_rounded, ROUND_PRECISION)).to eq(1.70)
    number_to_be_rounded = 1.678
    expect(round_tax(number_to_be_rounded, ROUND_PRECISION)).to eq(1.70)
    number_to_be_rounded = 1.83
    expect(round_tax(number_to_be_rounded, ROUND_PRECISION)).to eq(1.85)
    number_to_be_rounded = 1.8385647
    expect(round_tax(number_to_be_rounded, ROUND_PRECISION)).to eq(1.85)
  end
end