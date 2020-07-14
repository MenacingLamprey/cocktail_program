require_relative 'cocktail'
require 'erb'

ingredients = {"Skeleteon Key Spirit" => "1.5 oz",
				 "Soda Water" => " 4 oz",
				 "Green Bitters" => " 4 drops"}
process = "In collins glass, pour Skeleteon Key Spirit,
			fill with ice and top with soda water
			and green bitters. Garnish with skeletonized
			leaf and serve with straw"

description = "Simmilar to a vodka soda, tears of [ingredient]
				and green bitters gives its a unique dry taste"



skeleton_key = Cocktail.new("Skeleton Key", ingredients,
								 process, description)

cocktail_template = File.read "cocktail_template.html"
erb_template = ERB.new cocktail_template
spec =  erb_template.result(binding)


file_name = "spec.html"
File.open(file_name, 'w') do |file|
		file.puts spec
end