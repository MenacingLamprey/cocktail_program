class Ingredient
	
	attr_reader :ingredient_name
	attr_accessor :amount
	attr_accessor :unit
	attr_accessor :ingredients
	attr_reader :method
	def initialize(ingredient_name, amount, unit,
					 method = "", ingredients=[])
		@ingredient_name = ingredient_name
		@amount = amount
		@unit = unit
		@method = method
		@ingredients = ingredients
	end

	def convert_to_oz(amount=@amount, unit=@unit)
		if unit =="oz"
			return [amount, unit]
		elsif unit == "mL"
			return [(amount/29.57), "oz"]
		elsif unit == "qt"
			return [amount*32.0, "oz"]
		elsif unit == "L"
			return [(1000.0*amount/29.57), "oz"]
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

	def string_number
		if amount.is_a?(String)
			number = amount.chars.count { |char| amount.count(char) > 1 }
			puts number
			unit = amount
			amount = number
		end
	end

end