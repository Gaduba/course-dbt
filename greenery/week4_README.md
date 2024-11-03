# Part 1. dbt Snapshots

## Which products had their inventory change from week 3 to week 4? 
SQL
```
SELECT * 
FROM dev_db.dbt_gloryaduba01gmailcom.products_snapshot
where product_id in(
select product_id
from dev_db.dbt_gloryaduba01gmailcom.products_snapshot
group by 1
having count(1) > 1
order by product_id desc
)
order by product_id, dbt_valid_from desc
```
### ANS: 
Pothos
Bamboo
Philodendron
String of pearls
Monstera
ZZ Plant

## Now that we have 3 weeks of snapshot data, can you use the inventory changes to determine which products had the most fluctuations in inventory? Did we have any items go out of stock in the last 3 weeks? 
### ANS : 
1. products with the most fluctuations - Philodendron, Bamboo, zz plant, monstera
2. products that went out of stock - pothos, string of pearl


# Part 2. Modeling challenge
## A. How are our users moving through the product funnel?, Which steps in the funnel have largest drop off points?

| Funnel Step    | Count of Sessions | Conversion Rate |
|----------------|-------------------|-----------------|
| Total Sessions | 578               | -               |
| Page Views     | 578               | 100%            |
| Add to carts   | 467               | 81%             |
| Checkouts      | 361               | 62%             |

### ANS: 

Most drop-offs occurred before the checkout stage, likely due to product price, delivery cost, or user experience issues. Some drop-offs also happened at the add-to-cart stage, potentially due to product costs or customers not finding the specific items they were looking for. It may be beneficial for Supply Team to conduct a market survey to identify additional in-demand products, in case Greenery is interested in expanding its inventory options.

## B. Use an exposure on your product analytics model to represent that this is being used in downstream BI tools. 
```
version: 2

exposures:

  - name: product_performance
    label: Jaffles by the Week
    type: report
    description: 
      

    depends_on:
      - ref('fct_product_performance')

    owner:
      name: Glory Aduba

```


### ps: Part 3 is answered at the point of submission