-- Создание таблиц для новой установки.
SET SESSION lakekeeper.compression_codec = 'ZSTD';

CREATE TABLE lakekeeper.silver.order_lines
WITH (format = 'PARQUET')
AS
SELECT
    l.orderkey,
    o.orderdate,
    o.shippriority,
    l.extendedprice * (1 - l.discount) AS line_revenue
FROM lakekeeper.bronze.customer AS c
JOIN lakekeeper.bronze.orders AS o ON c.custkey = o.custkey
JOIN lakekeeper.bronze.lineitem AS l ON l.orderkey = o.orderkey
WHERE c.mktsegment = 'BUILDING'
    AND o.orderdate < DATE '1995-03-15'
    AND l.shipdate > DATE '1995-03-15';

CREATE TABLE lakekeeper.gold.top_orders
WITH (format = 'PARQUET')
AS
SELECT
    orderkey,
    sum(line_revenue) AS revenue,
    orderdate,
    shippriority
FROM lakekeeper.silver.order_lines
GROUP BY orderkey, orderdate, shippriority
ORDER BY revenue DESC
LIMIT 10;
