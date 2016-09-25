require './models/order_cost_calculator'

describe OrderCostCalculator do

  subject(:discount_calculator) { described_class.new }
  let(:express_delivery) { double :express_delivery, price: 20, name: :express }
  let(:standard_delivery) { double :standard_delivery, price: 10, name: :standard }
  let(:express_delivery_item) { [:broadcaster, express_delivery] }
  let(:standard_delivery_item) { [:broadcaster, standard_delivery] }


  describe '#express_deliveries_discount' do
    context "more than #{described_class::EXPRESS_DELIVERY_TRESHOLD_FOR_DISCOUNT} express deliveries" do
      it "discounts #{described_class::EXPRESS_DELIVERY_DISCOUNT_AMOUNT} for each express delivery" do
        items = Array.new(2, express_delivery_item)

        result = discount_calculator.express_deliveries_discount(items)

        expect(result).to eq 2 * described_class::EXPRESS_DELIVERY_DISCOUNT_AMOUNT
      end
    end

    context "less than #{described_class::EXPRESS_DELIVERY_TRESHOLD_FOR_DISCOUNT} express deliveries" do
      it "should be zero" do
        items = [standard_delivery_item, express_delivery_item]

        result = discount_calculator.express_deliveries_discount(items)

        expect(result).to eq 0
      end
    end

    describe '#discount_percent_on_final_cost' do
      context "subtotal is more than #{described_class::DISCOUNT_ON_TOTAL_COST_TRESHOLD}" do
        it "should be #{described_class::DISCOUNT_PERCENT_ON_TOTAL_COST}%" do
          items = Array.new(3, express_delivery_item)

          result = discount_calculator.discount_percent_on_final_cost(items)

          expect(result).to eq described_class::DISCOUNT_PERCENT_ON_TOTAL_COST
        end
      end

      context "subtotal is less or equal than #{described_class::DISCOUNT_ON_TOTAL_COST_TRESHOLD}" do
        it "should be 0%" do
          items = Array.new(2, express_delivery_item)

          result = discount_calculator.discount_percent_on_final_cost(items)

          expect(result).to eq 0
        end
      end
    end


  end



end
