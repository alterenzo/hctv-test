class OrderCostCalculator

  attr_reader :items

  EXPRESS_DELIVERY_TRESHOLD_FOR_DISCOUNT = 2
  DISCOUNT_PERCENT_ON_TOTAL_COST = 10
  DISCOUNT_ON_TOTAL_COST_TRESHOLD = 30
  DISCOUNTED_EXPRESS_DELIVERY = 15

  def initialize(items)
    @items = items
  end

  def final_cost
    express_deliveries_discount
    subtotal * ((100 - discount_percent_on_final_cost) / 100.0 )
  end

private

  def discount_percent_on_final_cost
    if subtotal > DISCOUNT_ON_TOTAL_COST_TRESHOLD
      DISCOUNT_PERCENT_ON_TOTAL_COST
    else
      0
    end
  end

  def express_deliveries_discount
    if express_deliveries_count >= EXPRESS_DELIVERY_TRESHOLD_FOR_DISCOUNT
      items.map! do |(broadcaster, delivery)|
        if delivery.name == :express
          delivery.name = :express_discounted
          delivery.price = DISCOUNTED_EXPRESS_DELIVERY
        end
        [broadcaster, delivery]
      end
    end
  end

  def express_deliveries_count
    return 0 if @items.empty?
    items.select { |(_,delivery)| delivery.name == :express }.length
  end

  def subtotal
    return 0 if @items.empty?
    @items.reduce(0) { |sum, (_,delivery)| sum += delivery.price }
  end

end
