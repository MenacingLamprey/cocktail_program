class Ingredient
	
	attr_reader :ingredient_name
	attr_reader :amount
	attr_reader :unit
	def initialize(ingredient_name, amount, unit)
		@ingredient_name = ingredient_name
		@amount = amount
		@unit = unit
	end

	def +(other)
		if unit == other.unit and ingredient_name == other.ingredient_name
			self.class.new(@amount + other.amount)
		else
			return "error, cannot add ingredients of different types"
		end
	end

end