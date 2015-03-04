-- If you want to run this schema repeatedly you'll need to drop
-- the table before re-creating it. Note that you'll lose any
-- data if you drop and add a table:

-- DROP TABLE IF EXISTS groceries;

-- Define your schema here:

DROP TABLE  if exists groceries;

CREATE TABLE groceries (
  id serial PRIMARY KEY,
  item varchar(255)
);


INSERT INTO groceries (item)
      VALUES ( 'Bsprouts');

INSERT INTO groceries (item)
      VALUES ( 'chicken');

INSERT INTO groceries (item)
      VALUES ( 'steak');
