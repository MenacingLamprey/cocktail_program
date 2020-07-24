class Ingredient
	
	attr_reader :ingredient_name
	attr_accessor :amount
	attr_accessor :unit
	def initialize(ingredient_name, amount, unit, ingredients=[])
		@ingredient_name = ingredient_name
		@amount = amount
		@unit = unit
	end

	def convert_to_oz(amount=@amount, unit=@unit)
		if unit =="oz"
			return [amount, unit]
		elsif unit == "mL"
			return [(29.57 * amount), "oz"]
		end
	end


	def +(other)
		if unit == other.unit and ingredient_name == other.ingredient_name
			self.class.new(ingredient_name,@amount + other.amount,unit)
		else
			puts "error, cannot add ingredients of different types"
		end
	end

	def *(number)
		if number.is_a?(Numeric)
			self.class.new(ingredient_name,@amount*number,unit)
		else
			puts "error, cannot multiply ingredient by non-number"
		end
	end

end