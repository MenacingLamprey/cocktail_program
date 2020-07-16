require_relative 'cocktail'
require_relative 'menu_formatter'
require 'erb'

menu_location, output_location = ARGV

cocktails = MenuFormatter.new(menu_location).make_menu
cocktail_template = File.read "Gravy/cocktail_template.html.erb"

erb_template = ERB.new cocktail_template
spec =  erb_template.result(binding)

file_name = output_location
File.open(file_name, 'w') do |file|
		file.puts spec
end
puts "success!"
puts "check output!"