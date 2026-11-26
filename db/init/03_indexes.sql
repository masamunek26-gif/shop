-- Включаем расширение pg_trgm для быстрого поиска ILIKE '%...%'
CREATE EXTENSION IF NOT EXISTS pg_trgm;

-- 1. Составной индекс для списка товаров категории с сортировкой по цене DESC
CREATE INDEX IF NOT EXISTS idx_products_cat_price ON products (category_id, price DESC);

-- 2. Триграммный GIN-индекс для поиска по подстроке в названии
CREATE INDEX IF NOT EXISTS idx_products_name_trgm ON products USING gin (name gin_trgm_ops);

-- 3. Покрывающий индекс для топа продаваемых товаров за неделю (Index-Only Scan)
CREATE INDEX IF NOT EXISTS idx_orders_recent ON orders (created_at, product_id, quantity);
