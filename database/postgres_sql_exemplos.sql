DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS items;
CREATE TABLE items(
item_code integer
,item_name character(35)
,purchase_unit character(10)
,sale_unit character(10)
,purchase_price numeric(10,2)
,sale_price numeric(10,2)
,PRIMARY KEY (item_code)
,CONSTRAINT unq_itname UNIQUE(item_name));

COMMENT ON COLUMN items.item_code IS 'Pk dos itens';
COMMENT ON COLUMN items.item_name IS 'Nomes';
COMMENT ON COLUMN items.sale_unit IS 'Endereço da empresa';


DROP TABLE IF EXISTS vendors;
CREATE TABLE vendors(
vendor_code integer PRIMARY KEY
,vendor_name character(35)
,vendor_city character(15)
,vendor_country character(20));

COMMENT ON COLUMN vendors.vendor_code IS 'Pk vendors';
COMMENT ON COLUMN vendors.vendor_name IS 'Nomes';


DELETE FROM public.vendors;

INSERT INTO public.vendors(vendor_code, vendor_name, vendor_city, vendor_country)
VALUES (1, 'Joao A B', 'BR', 'BR');

INSERT INTO public.vendors(vendor_code, vendor_name, vendor_city, vendor_country)
VALUES (2, 'Joao A C', 'BR', 'BR');

INSERT INTO public.vendors(vendor_code, vendor_name, vendor_city, vendor_country)
VALUES (3, 'Joao A D', 'BR', 'BR');

INSERT INTO public.vendors(vendor_code, vendor_name, vendor_city, vendor_country)
VALUES (4, 'Joao A E', 'BR', 'BR');


INSERT INTO public.vendors(vendor_code, vendor_name, vendor_city, vendor_country)
VALUES (5, 'Joao B B', 'BR', 'BR');

INSERT INTO public.vendors(vendor_code, vendor_name, vendor_city, vendor_country)
VALUES (6, 'Joao B C', 'BR', 'BR');

INSERT INTO public.vendors(vendor_code, vendor_name, vendor_city, vendor_country)
VALUES (7, 'Joao B D', 'BR', 'BR');

INSERT INTO public.vendors(vendor_code, vendor_name, vendor_city, vendor_country)
VALUES (8, 'Joao B E', 'BR', 'BR');



DROP TABLE IF EXISTS orders;
CREATE TABLE orders(
ord_no integer PRIMARY KEY
,ord_date date
,item_code integer
,vendor_code integer
,item_grade character(1)
,ord_qty numeric
,ord_amount numeric
,FOREIGN KEY (item_code) REFERENCES items(item_code)
,FOREIGN KEY (vendor_code) REFERENCES vendors(vendor_code)
);

COMMENT ON COLUMN orders.ord_no IS 'Pk vendors';
COMMENT ON COLUMN orders.item_code IS 'FK dos itens';
COMMENT ON COLUMN orders.vendor_code IS 'FK vendor';
COMMENT ON COLUMN orders.ord_amount IS 'Montante e valor ação';




CREATE TABLE public.company
(
    id integer NOT NULL,
    name text COLLATE pg_catalog."default" NOT NULL,
    age integer NOT NULL,
    address character(50) COLLATE pg_catalog."default",
    salary real,
    CONSTRAINT company_pkey PRIMARY KEY (id)
);
COMMENT ON COLUMN company.name IS 'Name of company';
COMMENT ON COLUMN company.age IS 'Idade';
COMMENT ON COLUMN company.address IS 'Endereço da empresa';

CREATE TABLE public.department
(
    id integer NOT NULL,
    dept character(50) COLLATE pg_catalog."default" NOT NULL,
    emp_id integer NOT NULL,
    CONSTRAINT department_pkey PRIMARY KEY (id)
);

COMMENT ON COLUMN department.id IS 'PK do departamento';
COMMENT ON COLUMN department.emp_id IS 'FK que não existe';

CREATE TABLE public.sisgen
(
    id integer NOT NULL DEFAULT nextval('sisgen_id_seq'::regclass),
    nome text COLLATE pg_catalog."default" NOT NULL,
    qtd integer,
    CONSTRAINT sisgen_pkey PRIMARY KEY (id)
);

CREATE VIEW COMPANY_VIEW AS
SELECT ID, NAME, AGE
FROM  COMPANY;

CREATE TABLE pg_equipment (
	equip_id serial PRIMARY KEY,
	type varchar (50) NOT NULL,
	color varchar (25) NOT NULL,
	location varchar(25) check (location in ('north', 'south', 'west', 'east', 'northeast', 'southeast', 'southwest', 'northwest')),
	install_date date
	);


CREATE TABLE films (
    code        char(5) CONSTRAINT firstkey PRIMARY KEY,
    title       varchar(40) NOT NULL,
    did         integer NOT NULL,
    date_prod   date,
    kind        varchar(10),
    len         interval hour to minute
);



-----------------
-----------------



SELECT c.table_schema,c.table_name,c.column_name,pgd.description
FROM pg_catalog.pg_statio_all_tables as st
  inner join pg_catalog.pg_description pgd on (pgd.objoid=st.relid)
  inner join information_schema.columns c on (pgd.objsubid=c.ordinal_position
    and  c.table_schema=st.schemaname and c.table_name=st.relname);



-- https://stackoverflow.com/questions/343138/retrieving-comments-from-a-postgresql-db
-- http://www.developerfiles.com/adding-and-retrieving-comments-on-postgresql-tables/
-- https://www.postgresql.org/docs/9.1/static/sql-comment.html


COMMENT ON COLUMN company.age IS 'Idade';
COMMENT ON COLUMN company.address IS 'Endereço da empresa';

select * from pg_catalog.pg_description pgd;

select * from pg_catalog.pg_statio_all_tables;

SELECT c.table_schema,c.table_name,c.column_name,pgd.description
FROM pg_catalog.pg_statio_all_tables as st
  inner join pg_catalog.pg_description pgd on (pgd.objoid=st.relid)
  inner join information_schema.columns c on (pgd.objsubid=c.ordinal_position
    and  c.table_schema=st.schemaname and c.table_name=st.relname);
	
	
	
SELECT st.schemaname as table_schema, st.relname as table_name, pgd.objsubid,pgd.description
FROM pg_catalog.pg_statio_all_tables as st
  inner join pg_catalog.pg_description pgd on (pgd.objoid=st.relid);
  
  
SELECT column_name as COLUMN_NAME
					,case c.IS_NULLABLE WHEN 'YES' THEN 'FALSE' ELSE 'TRUE' end as REQUIRED
					,c.IS_NULLABLE as REQUIRED2
					,data_type as DATA_TYPE
					,character_maximum_length CHAR_MAX
					,coalesce(numeric_precision, datetime_precision) as NUM_LENGTH
					,numeric_scale as NUM_SCALE
					,column_default COLUMN_DEFAULT
					,position('nextval(' in column_default)=1 as AUTOINCREMENT
					,c.TABLE_SCHEMA
					,c.table_name
					,c.TABLE_CATALOG			
					FROM information_schema.columns as c  ;
					
					
https://www.w3resource.com/PostgreSQL/foreign-key-constraint.php

DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS items;
CREATE TABLE items(
item_code integer
,item_name character(35)
,purchase_unit character(10)
,sale_unit character(10)
,purchase_price numeric(10,2)
,sale_price numeric(10,2)
,PRIMARY KEY (item_code)
,CONSTRAINT unq_itname UNIQUE(item_name));

COMMENT ON COLUMN items.item_code IS 'Pk dos itens';
COMMENT ON COLUMN items.item_name IS 'Nomes';
COMMENT ON COLUMN items.sale_unit IS 'Endereço da empresa';


DROP TABLE IF EXISTS vendors;
CREATE TABLE vendors(
vendor_code integer PRIMARY KEY
,vendor_name character(35)
,vendor_city character(15)
,vendor_country character(20));

COMMENT ON COLUMN vendors.vendor_code IS 'Pk vendors';
COMMENT ON COLUMN vendors.vendor_name IS 'Nomes';


DROP TABLE IF EXISTS orders;
CREATE TABLE orders(
ord_no integer PRIMARY KEY
,ord_date date
,item_code integer
,vendor_code integer
,item_grade character(1)
,ord_qty numeric
,ord_amount numeric
,FOREIGN KEY (item_code) REFERENCES items(item_code)
,FOREIGN KEY (vendor_code) REFERENCES vendors(vendor_code)
);

COMMENT ON COLUMN orders.ord_no IS 'Pk vendors';
COMMENT ON COLUMN orders.item_code IS 'FK dos itens';
COMMENT ON COLUMN orders.vendor_code IS 'FK vendor';
COMMENT ON COLUMN orders.ord_amount IS 'Montante e valor ação';