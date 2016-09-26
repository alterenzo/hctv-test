### HCTV Test

#### Instructions

1. Clone or download the repo
2. run ```$ bundle```
3. run tests with ```$ rspec ```

#### Description

Since there was already some code on the repo, that was only missing the requested functionality, I've assumed that I could use the codebase in 'example'

I've decided to implement the functionality creating a new model called: ```OrderCostCalculator``` that is injected at the creation of an Order.
The responsibility of computing the total cost is then moved to the new model.

OrderCostCalculator implements one method for every type of discount, and a final_cost method, that will take care of using those two methods to compute the discounted price.
