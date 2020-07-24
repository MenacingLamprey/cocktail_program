require_relative 'cocktail'
require_relative 'ingredient'
require 'erb'

class MenuFormatter
	attr_accessor :unformatted_menu
	def initialize(unformatted_menu)
		@unformatted_menu = IO.new(IO.sysopen unformatted_menu)
	end

	def skip_line(n=1)
		(n-1).times {unformatted_menu.gets}
		unformatted_menu.gets
	end

	def line_empty?(line)
			line.nil? || line.length==2
	end

	def get_info(line)
		split_point = /-/ =~line
		[line[split_point+1..], skip_line]
	end

	def get_ingredients(line)
		ingredients = ""
		until line_empty?(line)
			ingredients+= line
			line = unformatted_menu.gets
		end
		[ingredients, skip_line]
	end

	def format_ingredients(ingredients)
		ingredients = ingredients.split("\r\n")
		formatted_ingredients = []

		ingredients.each do |ingredient|
			split_name = /-/ =~ingredient
			ingredient_name = ingredient[split_name+2..]
			amount_unit = ingredient[0...split_name-1]
			split_unit = / / =~amount_unit
			amount = amount_unit[0...split_unit]

			unless amount.to_f ==0
				amount = amount.to_f
			end 
			
			if amount % 1 == 0
				amount = amount.to_i
			end
			unless split_unit.nil?
				unit = amount_unit[split_unit+1..]
			end

			this_ingredient = Ingredient.new(ingredient_name,
											amount,unit)
			formatted_ingredients.push(this_ingredient)
		end
		formatted_ingredients
	end

	def get_cocktail(line)
		cocktail_name, line = get_info(line)
		line = skip_line
		price, line = get_info(line)
		line = skip_line
		ingredients, line  = get_ingredients(line)
		mode, line = get_info(line)
		glass, line = get_info(line)
		garnish , line = get_info(line)
		line = skip_line
		
		description, line = get_info(line)
		line = skip_line(2)

		[Cocktail.new(cocktail_name, format_ingredients(ingredients), description, mode, 
					 glass, garnish, price, image = nil), line]
	end

	def get_crafted_ingredient(line)
		ingredient_name, line = get_info(line)
		line = skip_line
		ingredients, line  = get_ingredients(line)
		ingredients = format_ingredients(ingredients)

		description, line = get_info(line)
		yeild, line = get_info(line)
		line = skip_line(2)

		amount_unit =  / / =~ yeild
		amount = yeild[0...amount_unit]
		unit = yeild[amount_unit+1..]


		ingredient.new(ingredient_name,amount,unit,ingredients)
	end

	def make_menu(line =unformatted_menu.gets)
		line = skip_line(3)
		drinks =[]
		until line.nil?
			next_cocktail,line = get_cocktail(line)
			drinks.push(next_cocktail)
		end
		drinks
	end
end