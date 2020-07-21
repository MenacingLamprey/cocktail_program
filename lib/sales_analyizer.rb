require_relative 'cocktail'
require_relative 'menu_formatter'

class SalesAnalyzer

	attr_accessor :establishment
	def initialize(establishment)
		@establishment = establishment
	end

	def get_cocktails
		menu_location = "%s/menus/%s_2020_specs.txt" % [establishment, establishment]
		cocktails = MenuFormatter.new(menu_location).make_menu
		sales_location = "%s/sales_data/generated_data.txt" % establishment

		sales = eval(File.read(sales_location))
		sales.each do |drink, sale|
			puts drink
			puts sale
		end
	end
end

SalesAnalyzer.new("Killjoy").get_cocktails