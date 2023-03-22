require "./billing_item"
require 'csv'
module CSVParser 
  def parse_file(filename)
		if  filename == nil || filename&.empty? 
			raise "Can not read empty file"
		end

    items = []
    CSV.foreach(filename, headers: true, header_converters: :symbol) do |row|
			row_h = row.to_h
      imported =  row_h[:imported]&.downcase == "true"
			items << BillingItem.new(row_h[:quantity].to_i, row_h[:name], row_h[:unit_price].to_f, imported)
		end
    return items
  end
end
