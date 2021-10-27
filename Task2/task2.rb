class Drinks
    def initialize(inventory)
        @inventory = inventory
    end

    def item_in_stock
        temp_arr = []
        @inventory.each do |n|
            unless n[:quantity_by_size].empty?
                temp_arr.push(n[:name])
            end
        end
        temp_arr.sort
    end

    def affordable
        temp_arr = []
        @inventory.each do |n|
            if n[:price] < 50
                temp_arr.push(n)
            end
        end
        temp_arr
    end

    def out_of_stock
        temp_arr = []
        @inventory.each do |n|
            if n[:quantity_by_size].empty?
                temp_arr.push(n)
            end
        end
        temp_arr
    end

    def how_much_left(name)
        name_amount = 0
        @inventory.each do |n|
            if n[:name] == name
                n[:quantity_by_size].each do |key, value|
                    name_amount += value
                end
            end
        end
        name_amount
    end

    def total_stock()
        total_amount = 0
        @inventory.each do |n|
            n[:quantity_by_size].each do |key, value|
                total_amount += value
            end
        end
        total_amount
    end

end

inventory = [
    {price: 125.00, name: "Cola", quantity_by_size: {l033: 3, l05: 7, l1: 8, l2: 4}},
    {price: 40.00, name: "Pepsi", quantity_by_size: {}},
    {price: 39.99, name: "Water", quantity_by_size: {l033: 1, l2: 4}},
    {price: 70.00, name: "Juice", quantity_by_size: {l033: 7, l05: 2}}
]

drinks = Drinks.new(inventory)
print "Drinks in stock: " , drinks.item_in_stock, "\n"
puts "Affordable drinks: ", drinks.affordable
puts "Drinks out of stock: ", drinks.out_of_stock
puts "How much Cola is left: ", drinks.how_much_left("Cola")
puts "Total amount of drinks: ", drinks.total_stock
