-- Проверка числа строк Bronze.
SELECT 'customer' AS table_name, count(*) AS row_count FROM lakekeeper.bronze.customer
UNION ALL
SELECT 'orders', count(*) FROM lakekeeper.bronze.orders
UNION ALL
SELECT 'lineitem', count(*) FROM lakekeeper.bronze.lineitem
UNION ALL
SELECT 'customer_zstd', count(*) FROM lakekeeper.bronze.customer_zstd
UNION ALL
SELECT 'orders_zstd', count(*) FROM lakekeeper.bronze.orders_zstd
UNION ALL
SELECT 'lineitem_zstd', count(*) FROM lakekeeper.bronze.lineitem_zstd;

-- Проверка Silver и Gold.
SELECT count(*) AS row_count FROM lakekeeper.silver.order_lines;
SELECT count(*) AS row_count FROM lakekeeper.gold.top_orders;
SELECT * FROM lakekeeper.gold.top_orders ORDER BY revenue DESC;

-- Размеры файлов данных.
SELECT 'customer' AS table_name, 'GZIP' AS codec, sum(file_size_in_bytes) AS size_bytes
FROM lakekeeper.bronze."customer$files"
UNION ALL
SELECT 'orders', 'GZIP', sum(file_size_in_bytes)
FROM lakekeeper.bronze."orders$files"
UNION ALL
SELECT 'lineitem', 'GZIP', sum(file_size_in_bytes)
FROM lakekeeper.bronze."lineitem$files"
UNION ALL
SELECT 'customer_zstd', 'ZSTD', sum(file_size_in_bytes)
FROM lakekeeper.bronze."customer_zstd$files"
UNION ALL
SELECT 'orders_zstd', 'ZSTD', sum(file_size_in_bytes)
FROM lakekeeper.bronze."orders_zstd$files"
UNION ALL
SELECT 'lineitem_zstd', 'ZSTD', sum(file_size_in_bytes)
FROM lakekeeper.bronze."lineitem_zstd$files"
UNION ALL
SELECT 'silver.order_lines', 'ZSTD', sum(file_size_in_bytes)
FROM lakekeeper.silver."order_lines$files"
UNION ALL
SELECT 'gold.top_orders', 'ZSTD', sum(file_size_in_bytes)
FROM lakekeeper.gold."top_orders$files";
