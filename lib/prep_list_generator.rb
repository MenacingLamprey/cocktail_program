require_relative 'ingredient'
require_relative 'cocktail'
require_relative 'menu_formatter'
require 'erb'

establishment = ARGV[0]

prep_template = File.read establishment + "/prep_list_template.html.erb"
menu_location = establishment +"/menus/" + "summer_2020_prep_list.txt"
output_location = establishment +"/output/" + establishment +"_2020_prep_list.html"

prep_list = MenuFormatter.new(menu_location).make_prep_list

erb_template = ERB.new prep_template
spec =  erb_template.result(binding)

file_name = output_location
File.open(file_name, 'w') do |file|
		file.puts spec
end
puts "success!"
puts "check output!"