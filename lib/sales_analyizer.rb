require_relative 'cocktail'
require_relative 'menu_formatter'

class SalesAnalyzer

	attr_accessor :establishment
	def initialize(establishment)
		@establishment = establishment
	end

	def get_drinks_sold
		sales_location = "%s/sales_data/generated_data.txt" % establishment
		sales = eval(File.read(sales_location))

		drinks_sold =[]
		sales.each do |drink, sale|
			drinks_sold.push([drink,sale])
		end

		drinks_sold
	end

	def get_ingredients_sold
		menu_location = "%s/menus/%s_2020_specs.txt" % [establishment, establishment]
		cocktails = MenuFormatter.new(menu_location).make_menu

		drinks_sold = get_drinks_sold


		all_ingredients_used = {}
		drinks_sold.each_with_index do |drink,index|
			cocktail = cocktails[i]
			ingredients = cocktail.ingredients
			num_sold = drink[1]

		end

	end


end

this_week = SalesAnalyzer.new("Killjoy")
this_week.drinks_sold
this_week.get_ingredients