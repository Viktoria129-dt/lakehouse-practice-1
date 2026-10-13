-- Демонстрация изменяет данные. Выполнять по шагам.
-- ID снапшота относится к исходному эксперименту; на новой таблице заменить его.

-- Добавление колонки: изменение схемы Silver.

ALTER TABLE lakekeeper.silver.order_lines

ADD COLUMN note VARCHAR;

-- Просмотр доступных снапшотов.

SELECT committed_at, snapshot_id, operation

FROM lakekeeper.silver."order_lines$snapshots"

ORDER BY committed_at DESC;

-- Тестовое изменение данных.

UPDATE lakekeeper.silver.order_lines

SET note = 'test'

WHERE orderkey = 295360;

-- Time travel: чтение исходного состояния без изменения текущей таблицы.

SELECT orderkey, line_revenue

FROM lakekeeper.silver.order_lines

FOR VERSION AS OF 6737422232604808816

WHERE orderkey = 295360;

-- Восстановление данных из исходного снапшота в Trino 476.

ALTER TABLE lakekeeper.silver.order_lines

EXECUTE rollback_to_snapshot(6737422232604808816);

-- Проверка: у пяти позиций note снова NULL.

SELECT orderkey, line_revenue, note

FROM lakekeeper.silver.order_lines

WHERE orderkey = 295360;
