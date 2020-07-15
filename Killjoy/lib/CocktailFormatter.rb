require_relative 'cocktail'
require 'erb'

class CocktailFormatter

	attr_accessor :unformated_menu
	def initialize(unformated_menu,template)
		@template = template
		@unformated_menu = IO.new(IO.sysopen unformated_menu)
	end

	def skip_line(n=1)
			(n-1).times {unformated_menu.gets}
			unformated_menu.gets
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
				line = unformated_menu.gets
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
		end

		cocktail_name, line = get_name(line)
		ingredients, line  = get_ingredients(line)
		mode, line = get_mode(line)
		glass, line = get_glass(line)
		garnish , line = get_garnish(line)
		description, line = get_desciption(line)

		format_ingredients(ingredients)

		[Cocktail.new(cocktail_name, ingredients, description, mode, 
					 glass, garnish, image = nil), line]
	end

	def make_menu(line =unformated_menu.gets)
		line = skip_line(3)
		drinks =[]
		until line.nil?
			puts line
			next_cocktail,line = get_cocktail(line)
			drinks.push(next_cocktail)
		end
		drinks
	end

end			

puts CocktailFormatter.new("menus/Summer_2020_specs.txt",nil).make_menu

=begin


end

skeleton_key = Cocktail.new("Skeleton Key", ingredients,
								 process, description)

cocktail_template = File.read "cocktail_template.erb"
erb_template = ERB.new cocktail_template
spec =  erb_template.result(binding)


file_name = "spec.html"
File.open(file_name, 'w') do |file|
		file.puts spec
end

=end