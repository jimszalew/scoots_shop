class Cart
  attr_reader :contents

  def initialize(contents)
    @contents = contents || {}
  end

  def add_item(item)
    @contents[item.to_s] = (@contents[item.to_s] || 0) + 1
  end

  def total_price
    sum = @contents.keys.inject(0) do |sum, key|
      sum += (@contents[key] * Item.find(key).price)
    end
  end
end