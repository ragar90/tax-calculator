require 'csv'
require './billing_item'
require './constants'
class TaxCalculator
	include Constants
	attr_accessor :file_name
	attr_accessor :items
	def initialize(items_file_name)
		@file_name = items_file_name
		@items = []
		read_file()
	end

	def read_file()
		if @file_name.empty?
			raise RuntimeError("Can not read empty file")
		end 
		CSV.foreach(@file_name, headers: true, header_converters: :symbol) do |row|
			row_h = row.to_h
			@items << BillingItem.new(row_h[:quantity].to_i, row_h[:name], row_h[:unit_price].to_f, row_h[:imported])
		end
	end

	def print_statement
		items.each do |item|
			item_total_bt = item.quantity * item.unit_price
			item_imported = round_tax((item.imported ? item_total_bt * IMPORTED_TAX_RATE : 0), ROUND_PRECISION)
			item_tax = round_tax((!item.excempt_from_tax ? item_total_bt * SALE_TAX_RATE : 0), ROUND_PRECISION)
			item_total = item_total_bt + item_tax + item_imported
		  puts "#{item.quantity} #{item.imported ? "imported " : ""}#{item.name}: #{formated_amount(item_total)}"
		end
		total_tax = round_tax((total_sale_tax + imported_tax), 0.05)
		total = total_before_tax + total_tax
		puts "Sales Tax: #{formated_amount(total_tax)}"
		puts "Total: #{formated_amount(total)}"
	end

	def total_before_tax
		@items
		.map{ |item| item.unit_price * item.quantity }
		.sum()
	end

	def total_sale_tax
		@items
		.select{|item| !item.excempt_from_tax}
		.map{ |item| item.unit_price * item.quantity * SALE_TAX_RATE }
		.sum()
	end

	def imported_tax
		@items
		.select{|item| item.imported}
		.map{ |item| item.unit_price * item.quantity * 0.05 }
		.sum()
	end

	def round_tax(tax, precision)
		(tax * 1/precision).ceil / (1/precision)
	end

	def formated_amount(value)
		sprintf('%05.2f', value)
	end
end