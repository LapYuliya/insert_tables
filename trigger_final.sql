ALTER TABLE "Product" ADD COLUMN price numeric ;


CREATE OR REPLACE FUNCTION get_historical_price() RETURNS trigger AS
$$
BEGIN
UPDATE public."Order_product" SET unit_price = OLD.price
WHERE id_product = NEW.id;
RETURN NEW;
END;
$$ language plpgsql;


CREATE TRIGGER historical_price
BEFORE UPDATE 
ON public."Product"
FOR EACH ROW
EXECUTE PROCEDURE get_historical_price();