require './models/discount_calculator'

describe DiscountCalculator do

  subject(:discount_calculator) { described_class.new }
  let(:express_delivery) { double :express_delivery, price: 20, name: :express }
  let(:standard_delivery) { double :standard_delivery, price: 10, name: :standard }

  describe '#express_deliveries_discount' do
    context "more than #{described_class::EXPRESS_DELIVERY_TRESHOLD_FOR_DISCOUNT} express deliveries" do
      it "discounts #{described_class::EXPRESS_DELIVERY_DISCOUNT_AMOUNT} for each express delivery" do
        express_delivery_item = [:broadcaster, express_delivery]
        items = Array.new(2, express_delivery_item)

        expect(discount_calculator.express_deliveries_discount(items)).to eq 2 * described_class::EXPRESS_DELIVERY_DISCOUNT_AMOUNT
      end
    end

  end



end
