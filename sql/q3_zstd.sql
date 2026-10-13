-- Q3 по Bronze с ZSTD.
SELECT
    l.orderkey,
    sum(l.extendedprice * (1 - l.discount)) AS revenue,
    o.orderdate,
    o.shippriority
FROM lakekeeper.bronze.customer_zstd AS c
JOIN lakekeeper.bronze.orders_zstd AS o ON c.custkey = o.custkey
JOIN lakekeeper.bronze.lineitem_zstd AS l ON l.orderkey = o.orderkey
WHERE c.mktsegment = 'BUILDING'
    AND o.orderdate < DATE '1995-03-15'
    AND l.shipdate > DATE '1995-03-15'
GROUP BY l.orderkey, o.orderdate, o.shippriority
ORDER BY revenue DESC
LIMIT 10;
