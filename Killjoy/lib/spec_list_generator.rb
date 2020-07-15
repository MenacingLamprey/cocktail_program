require_relative 'cocktail'
require_relative 'menu_formatter'
require 'erb'

cocktails = MenuFormatter.new("menus/Summer_2020_specs.txt").make_menu

cocktail_template = File.read "cocktail_template.erb"

erb_template = ERB.new cocktail_template
spec =  erb_template.result(binding)

file_name = "output/spec.html"
File.open(file_name, 'w') do |file|
		file.puts spec
end