module Constants
    SALE_TAX_RATE = 0.10
    IMPORTED_TAX_RATE = 0.05
    ROUND_PRECISION = 0.05
    # Note: A better implementation would be to change the input CSVs to include a category to avoid intereation while calculating amounts
    EXCEMPTION_FROM_TAX = {
        books: ["books", "book"],
        food: ["chocolates", "chocolate"],
        medicine: ["pills"]
    }
end
