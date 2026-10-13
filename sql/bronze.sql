-- Для новой установки: выполнять в одной сессии Trino.
CREATE SCHEMA IF NOT EXISTS lakekeeper.bronze;
CREATE SCHEMA IF NOT EXISTS lakekeeper.silver;
CREATE SCHEMA IF NOT EXISTS lakekeeper.gold;

SET SESSION lakekeeper.compression_codec = 'GZIP';

CREATE TABLE lakekeeper.bronze.customer
WITH (format = 'PARQUET')
AS
SELECT custkey, mktsegment
FROM tpch.sf1.customer;

CREATE TABLE lakekeeper.bronze.orders
WITH (format = 'PARQUET')
AS
SELECT orderkey, custkey, orderdate, shippriority
FROM tpch.sf1.orders;

CREATE TABLE lakekeeper.bronze.lineitem
WITH (format = 'PARQUET')
AS
SELECT orderkey, extendedprice, discount, shipdate
FROM tpch.sf1.lineitem;

SET SESSION lakekeeper.compression_codec = 'ZSTD';

CREATE TABLE lakekeeper.bronze.customer_zstd
WITH (format = 'PARQUET')
AS
SELECT custkey, mktsegment
FROM tpch.sf1.customer;

CREATE TABLE lakekeeper.bronze.orders_zstd
WITH (format = 'PARQUET')
AS
SELECT orderkey, custkey, orderdate, shippriority
FROM tpch.sf1.orders;

CREATE TABLE lakekeeper.bronze.lineitem_zstd
WITH (format = 'PARQUET')
AS
SELECT orderkey, extendedprice, discount, shipdate
FROM tpch.sf1.lineitem;
