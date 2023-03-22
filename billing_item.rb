require './constants'
class BillingItem
    include Constants
    attr_accessor :quantity
    attr_accessor :name
    attr_accessor :unit_price
    attr_accessor :imported
    attr_accessor :excempt_from_tax

    alias_method :imported?, :imported
    alias_method :excempt_from_tax?, :excempt_from_tax

    def initialize(quantity, name, unit_price, imported)
        @quantity = quantity
        @name = name
        @unit_price = unit_price
        @imported = imported
        exceptions = EXCEMPTION_FROM_TAX.map{|k, v| v}.flatten
        @excempt_from_tax = name
        .split(" ")
        .map(&:downcase)
        .intersect?(exceptions)
    end

    def total_amount_before_taxes
        self.unit_price * self.quantity
    end

    def sale_tax
        !self.excempt_from_tax? ? total_amount_before_taxes * SALE_TAX_RATE : 0 
    end

    def imported_tax
        self.imported? ? total_amount_before_taxes * IMPORTED_TAX_RATE : 0 
    end

    def total
        self.total_amount_before_taxes + self.sale_tax + self.imported_tax
    end
end