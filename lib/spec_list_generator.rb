require_relative 'cocktail'
require_relative 'menu_formatter'
require 'erb'

establishment = ARGV[0]

cocktail_template = File.read establishment + "/cocktail_template.html.erb"
menu_location = establishment +"/menus/" + establishment +"_2020_specs.txt"
output_location = establishment +"/output/" + establishment +"_2020_specs.html"

cocktails = MenuFormatter.new(menu_location).make_menu

erb_template = ERB.new cocktail_template
spec =  erb_template.result(binding)

file_name = output_location
File.open(file_name, 'w') do |file|
		file.puts spec
end
puts "success!"
puts "check output!"