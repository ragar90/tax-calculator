require './constants'
class BillingItem
    include Constants
    attr_accessor :quantity
    attr_accessor :name
    attr_accessor :unit_price
    attr_accessor :imported
    attr_accessor :excempt_from_tax

    def initialize(quantity, name, unit_price, imported)
        @quantity = quantity
        @name = name
        @unit_price = unit_price
        @imported = imported.downcase == "true"
        exceptions = EXCEMPTION_FROM_TAX.map{|k, v| v}.flatten
        @excempt_from_tax = name
        .split(" ")
        .map(&:downcase)
        .intersect?(exceptions)
    end

    def total_amount_before_taxes
        self.unit_price * self.quantity
    end

    def total
        self.total_amount_before_taxes
    end

    def imported_tax
        
    end
end