class Cocktail

	attr_accessor :cocktail_name, :ingredients
	attr_accessor :description, :image, :mode
	attr_accessor :glassware, :garnish, :price
	def initialize(cocktail_name, ingredients, description, mode, 
					 glassware, garnish,price, image = nil)
		@cocktail_name = cocktail_name
		@ingredients = ingredients
		@description =description
		@image = image
		@mode = mode
		@glassware = glassware
		@garnish = garnish
		@price = price
	end
end