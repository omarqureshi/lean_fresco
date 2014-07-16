class Checkout
  attr_reader :items

  def initialize
    @items = []
  end

  def add_item(item)
    @items << item
  end

  def total
    items.map(&:get_price).inject(:+) - discount
  end

  def discount
    total_discount = 0
    total_discount += cherry_discount
    total_discount += bananas_discount
    total_discount += apples_discount
    total_discount += ((items.length / 5) * 200)
  end

  def cherry_discount
    cherry_count = items.select { |x| x.cherries? }.length
    (20 * (cherry_count / 2))
  end

  def bananas_discount
    bananas_count = items.select { |x| x.bananas? }.length
    Item::PRICES[:bananas] * (bananas_count / 2)
  end

  def apples_discount
    current_apple_discount = 0
    mele_count = items.select { |x| x.mele? }.length
    current_apple_discount += 50 * (mele_count / 2)
    pomme_count = items.select { |x| x.pomme? }.length
    current_apple_discount += 100 * (pomme_count / 3)
    any_apple_count = items.select { |x| x.kind_of_apple? }.length
    current_apple_discount += 100 * (any_apple_count / 4)
  end

end

class Item
  attr_reader :name

  PRICES = {
    :bananas => 150,
    :apples => 100,
    :cherries => 75
  }

  def initialize(x)
    @name = x
  end

  def kind_of_apple?
    ["Apples", "Mele", "Pommes"].include?(name)
  end

  def cherries?
    name == "Cherries"
  end

  def bananas?
    name == "Bananas"
  end

  def apples?
    name == "Apples"
  end

  def mele?
    name == "Mele"
  end

  def pomme?
    name == "Pommes"
  end

  def get_price
    if apples?
      PRICES[:apples]
    elsif mele?
      PRICES[:apples]
    elsif pomme?
      PRICES[:apples]
    elsif bananas?
      PRICES[:bananas]
    elsif cherries?
      PRICES[:cherries]
    else
      raise "Not an item"
    end
  end

end


has_csv_support = true

if has_csv_support
  c = Checkout.new
  while items = gets.chomp.split(",").map(&:strip)
    items.each do |item|
      c.add_item(Item.new(item))
    end
    puts c.total
  end
else
  c = Checkout.new
  while item = gets.chomp
    c.add_item(Item.new(item))
    puts c.total
  end
end
