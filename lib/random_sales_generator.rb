require_relative 'cocktail'
require_relative 'menu_formatter'


class SalesGenerator

	attr_accessor :sales, :establishment
	def initialize(sales_in_dollars, establishment)
		@sales = sales_in_dollars
		@establishment = establishment
	end

	attr_accessor :names_and_prices
	def get_names_and_prices
		@names_and_prices = []
		menu_location = "%s/menus/%s_2020_specs.txt" % [establishment, establishment]
		cocktails = MenuFormatter.new(menu_location).make_menu

		cocktails.each do |cocktail|
			@names_and_prices.push([cocktail.cocktail_name,cocktail.price])
		end

		@names_and_prices
	end

	def weighting(weights)
		get_names_and_prices
		if weights.length != names_and_prices.length
			puts "weights/drinks length mismatch"
			return
		end
		names_and_prices.each_with_index do |drink, index|
			drink.push(weights[index])
		end
	end
	
	def generate_random_sales
		remaining_sales = sales
		drinks_sold = {}
		while remaining_sales > 0
			names_and_prices.each do |drink|
				num_of_drink = (rand(16)*drink[2]).round
				cost = num_of_drink*drink[1].to_i
				remaining_sales -= num_of_drink*cost
				if drinks_sold[drink[0]].nil?
					drinks_sold[drink[0]] = 0
				end
				drinks_sold[drink[0]] += num_of_drink
			end
		end
		drinks_sold
	end
end

generator = SalesGenerator.new(5000, "Killjoy")
generator.weighting([0.10,0.06,0.08,0.1,0.1, 0.08,0.07,
						0.06,0.04,0.04,0.04,0.04,0.05,0.06,0.04,0.04])

output_location = "Killjoy/sales_data/generated_data.txt"


random_sales = generator.generate_random_sales

File.open(output_location, 'w') do |file|
		file.puts random_sales
end

puts "success! check sales data"