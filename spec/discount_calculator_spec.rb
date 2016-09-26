require './models/order_cost_calculator'
require './models/delivery'

describe OrderCostCalculator do

  let(:express_delivery) { double :express_delivery, name: :express, price: 20}
  let(:standard_delivery) { spy :standard_delivery, name: :standard, price: 10 }
  let(:express_delivery_item) { [:broadcaster, express_delivery] }
  let(:standard_delivery_item) { [:broadcaster, standard_delivery] }


  describe '#final_cost' do

    it 'changes the price of express deliveries if there are more than 1' do
      allow(express_delivery).to receive(:price=)
      allow(express_delivery).to receive(:name=)
      items = Array.new(2, express_delivery_item)
      discount_calculator = described_class.new(items)

      discount_calculator.final_cost

      expect(express_delivery).to have_received(:price=).twice

    end

    it 'does not change the price of express deliveries if just one express delivery' do
      allow(express_delivery).to receive(:price=)
      allow(express_delivery).to receive(:name=)

      items = Array.new(1, express_delivery_item)
      discount_calculator = described_class.new(items)

      discount_calculator.final_cost

      expect(express_delivery).not_to have_received(:price=)

    end


  end
end
