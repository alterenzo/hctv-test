require './models/order_cost_calculator'
require './models/delivery'

describe OrderCostCalculator do

  let(:express_delivery) { double :express_delivery, price: 20, name: :express  }
  let(:standard_delivery) { double :standard_delivery, price: 10, name: :standard }
  let(:express_delivery_item) { [:broadcaster, express_delivery] }
  let(:standard_delivery_item) { [:broadcaster, standard_delivery] }


  describe '#final_cost' do
    it 'returns the final discounted cost of a list of 3 express deliveries' do
      items = Array.new(3, Delivery.new(:express, 20))
      discount_calculator = described_class.new(items)

      result = discount_calculator.final_cost

      expect(result).to eq 40.5
    end

    it 'reutrns the final discounted cost of a list of mixed deliveries' do
      items = Array.new(3, Delivery.new(:express, 20))
      items << Delivery.new(:standard, 10)
      discount_calculator = described_class.new(items)

      result = discount_calculator.final_cost

      expect(result).to eq 45
    end
  end
end
