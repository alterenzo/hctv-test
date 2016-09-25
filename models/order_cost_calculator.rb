class OrderCostCalculator

  EXPRESS_DELIVERY_TRESHOLD_FOR_DISCOUNT = 2
  EXPRESS_DELIVERY_DISCOUNT_AMOUNT = 5
  DISCOUNT_PERCENT_ON_TOTAL_COST = 10
  DISCOUNT_ON_TOTAL_COST_TRESHOLD = 30

  def initialize(items)
    @items = items
  end

  def final_cost
    (subtotal - express_deliveries_discount) * ((100 - discount_percent_on_final_cost) / 100.0)
  end

  def express_deliveries_discount
    if express_deliveries_count >= EXPRESS_DELIVERY_TRESHOLD_FOR_DISCOUNT
      express_deliveries_count * EXPRESS_DELIVERY_DISCOUNT_AMOUNT
    else
      0
    end
  end

  def discount_percent_on_final_cost
    if discounted_subtotal > DISCOUNT_ON_TOTAL_COST_TRESHOLD
      DISCOUNT_PERCENT_ON_TOTAL_COST
    else
      0
    end
  end

private

  def express_deliveries_count
    return 0 if @items.empty?
    @items.select { |(_,delivery)| delivery.name == :express }.length
  end

  def discounted_subtotal
    return 0 if @items.empty?
    @items.reduce(0) { |sum, (_,delivery)| sum += delivery.price } - express_deliveries_discount
  end

  def subtotal
    return 0 if @items.empty?
    @items.reduce(0) { |sum, (_,delivery)| sum += delivery.price }
  end

end
