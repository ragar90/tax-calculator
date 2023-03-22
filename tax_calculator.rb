require 'csv'
require './billing_item'
require './constants'
require './tax_rounder'
class TaxCalculator
	include Constants
	include TaxRounder
	attr_accessor :items
	def initialize(items)
		@items = items
	end

	def print_statement
		items.each do |item|
			item_tax = round_tax(item.total, ROUND_PRECISION)
			item_total = item.total
		  puts "#{item.quantity} #{item.imported ? "imported " : ""}#{item.name}: #{formated_amount(item_total)}"
		end
		total_tax = round_tax((total_sale_tax + imported_tax), 0.05)
		total = total_before_tax + total_tax
		puts "Sales Tax: #{formated_amount(total_tax)}"
		puts "Total: #{formated_amount(total)}"
	end

	def total_before_tax
		@items
		.map{ |item| item.total_amount_before_taxes }
		.sum()
	end

	def total_sale_tax
		@items
		.map{ |item| item.sale_tax }
		.sum()
	end

	def imported_tax
		@items
		.select{|item| item.imported}
		.map{ |item| item.imported_tax}
		.sum()
	end

	def formated_amount(value)
		sprintf('%05.2f', value)
	end
end