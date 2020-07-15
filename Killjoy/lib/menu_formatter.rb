require_relative 'cocktail'
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

	def get_cocktail(line)

		def line_empty?(line)
			line.nil? || line.length==2
		end

		def get_name(line)
			[line[6..], skip_line(2)]
		end

		def get_ingredients(line)
			ingredients = ""
			until line_empty?(line)
				ingredients+= line
				line = unformatted_menu.gets
			end
			[ingredients, skip_line]
		end

		def get_mode(line)
			[line[7..], skip_line]
		end

		def get_glass(line)
			[line[8..], skip_line]
		end

		def get_garnish(line)
			[line[10..], skip_line(2)]
		end	

		def get_desciption(line)
			[line[19..], skip_line(3)]
		end

		def format_ingredients(ingredients)
			ingredients = ingredients.split("\r\n")
			formatted_ingredients = {}
			ingredients.each do |ingredient_pair|
				split_point = /-/ =~ingredient_pair
				amount = ingredient_pair[0...split_point-1]
				ingredient = ingredient_pair[split_point+2..]
				formatted_ingredients[ingredient]= amount
			end
			return formatted_ingredients
		end

		cocktail_name, line = get_name(line)
		ingredients, line  = get_ingredients(line)
		mode, line = get_mode(line)
		glass, line = get_glass(line)
		garnish , line = get_garnish(line)
		description, line = get_desciption(line)

		[Cocktail.new(cocktail_name, format_ingredients(ingredients), description, mode, 
					 glass, garnish, image = nil), line]
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