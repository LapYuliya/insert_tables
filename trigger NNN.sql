
------trigger----
CREATE OR REPLACE FUNCTION get_historical_price() RETURNS trigger AS
$$
BEGIN

UPDATE public."Order_product" SET unit_price = (select price from "Product" where id = "Order_product".id_product)
WHERE id_product = "Product".id;
RETURN NEW;
END;
$$ language plpgsql;


CREATE TRIGGER historical_price
AFTER INSERT 
ON public."Order_product"
FOR EACH ROW
EXECUTE PROCEDURE get_historical_price();