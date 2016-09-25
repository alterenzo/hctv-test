class DiscountCalculator

  EXPRESS_DELIVERY_TRESHOLD_FOR_DISCOUNT = 2
  EXPRESS_DELIVERY_DISCOUNT_AMOUNT = 5

  def express_deliveries_discount(items)
    if express_deliveries_count(items) >= EXPRESS_DELIVERY_TRESHOLD_FOR_DISCOUNT
      express_deliveries_count(items) * EXPRESS_DELIVERY_DISCOUNT_AMOUNT
    else
      0
    end
  end

private

  def express_deliveries_count(items)
    return 0 if items.empty?
    items.select { |(_,delivery)| delivery.name == :express }.length
  end


end
