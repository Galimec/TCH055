--"4.1"
SELECT
    COUNT("A1"."PRODUCT_NAME") "TOTAL_I7"
FROM
    "EQUIPE113"."PRODUCTS" "A1";
--"4.2"    
SELECT COUNT(contacts)
FROM phone
WHERE (+xx);
--"4.3"
SELECT region_name
FROM regions
WHERE COUNT(region_id)IN(
                   SELECT region_id
                   FROM countries);
--"4.4"
SELECT product_id, product_name, unit_price
FROM products, order_items
WHERE unit_price > AVG(unit_price);
--"4.5"
SELECT employee_id,
FROM employees
WHERE quantity > (
      SELECT AVG(quantity)
      FROM order_items




