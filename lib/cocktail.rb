class Cocktail

	attr_accessor :cocktail_name, :ingredients
	attr_accessor :description, :image, :mode
	attr_accessor :glassware, :garnish
	def initialize(cocktail_name, ingredients, description, mode, 
					 glassware, garnish, image = nil)
		@cocktail_name = cocktail_name
		@ingredients = ingredients
		@description =description
		@image = image
		@mode = mode
		@glassware = glassware
		@garnish = garnish
	end
end