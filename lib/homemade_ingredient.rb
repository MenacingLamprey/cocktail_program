include 'ingredient'

class HousemadeIngredient < Ingredeient
	attr_accessor :ingredients
	def initialize(ingredients)
		super(ingredients)
	end
end