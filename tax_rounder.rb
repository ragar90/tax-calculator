module TaxRounder
  def round_tax(tax, precision)
		(tax * 1/precision).ceil.to_f / (1/precision)
	end
end
