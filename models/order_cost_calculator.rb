class OrderCostCalculator

  EXPRESS_DELIVERY_TRESHOLD_FOR_DISCOUNT = 2
  EXPRESS_DELIVERY_DISCOUNT_AMOUNT = 5
  DISCOUNT_PERCENT_ON_TOTAL_COST = 10
  DISCOUNT_ON_TOTAL_COST_TRESHOLD = 30

  def final_cost(items)

  end


  def express_deliveries_discount(items)
    if express_deliveries_count(items) >= EXPRESS_DELIVERY_TRESHOLD_FOR_DISCOUNT
      express_deliveries_count(items) * EXPRESS_DELIVERY_DISCOUNT_AMOUNT
    else
      0
    end
  end

  def discount_percent_on_final_cost(items)
    if subtotal(items) > DISCOUNT_ON_TOTAL_COST_TRESHOLD
      DISCOUNT_PERCENT_ON_TOTAL_COST
    else
      0
    end
  end

private

  def express_deliveries_count(items)
    return 0 if items.empty?
    items.select { |(_,delivery)| delivery.name == :express }.length
  end

  def subtotal(items)
    return 0 if items.empty?
    items.reduce(0) { |sum, (_,delivery)| sum += delivery.price } - express_deliveries_discount(items)
  end


end
