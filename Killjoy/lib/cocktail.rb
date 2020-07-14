class Cocktail

	attr_accessor :cocktail_name, :ingredients, :process
	attr_accessor :description, :image
	def initialize(cocktail_name, ingredients, process, description, image = nil)
		@cocktail_name = cocktail_name
		@ingredients = ingredients
		@process = process
		@description =description
		@image = image
	end
end