class BillingItem
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
        @excempt_from_tax = name
        .split(" ")
        .map(&:downcase)
        .intersect?(["book", "chocolate", "chocolates", "pills"])
    end
end