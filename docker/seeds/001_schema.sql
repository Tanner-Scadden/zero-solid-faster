-- Enable trigram extension for text search
CREATE EXTENSION IF NOT EXISTS pg_trgm;

CREATE TABLE categories (
    id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    parent_id  UUID REFERENCES categories(id) ON DELETE SET NULL,
    name                VARCHAR(255) NOT NULL,
    slug                VARCHAR(255) UNIQUE NOT NULL,
    description         TEXT,
    created_at          TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at          TIMESTAMP NOT NULL DEFAULT NOW()
);

-- Categories indices
CREATE INDEX idx_categories_parent_id ON categories(parent_id);
CREATE INDEX idx_categories_slug ON categories(slug);
CREATE INDEX idx_categories_updated_at ON categories(updated_at);

CREATE TABLE users (
    id       UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    first_name    VARCHAR(100) NOT NULL,
    last_name     VARCHAR(100) NOT NULL,
    email         VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    created_at    TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at    TIMESTAMP NOT NULL DEFAULT NOW()
);

-- Users indices
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_name ON users(first_name, last_name);

CREATE TABLE products (
    id   UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    category_id  UUID REFERENCES categories(id) ON DELETE SET NULL,
    name         VARCHAR(255) NOT NULL,
    slug         VARCHAR(255) UNIQUE NOT NULL,
    sku          VARCHAR(100) UNIQUE NOT NULL,
    price        NUMERIC(12, 2) NOT NULL,
    image_url    VARCHAR(500),
    quantity     INT NOT NULL DEFAULT 0,
    description  TEXT,
    created_at   TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at   TIMESTAMP NOT NULL DEFAULT NOW()
);

-- Products indices
CREATE INDEX idx_products_category_id ON products(category_id);
CREATE INDEX idx_products_slug ON products(slug);
CREATE INDEX idx_products_sku ON products(sku);
CREATE INDEX idx_products_price ON products(price);
CREATE INDEX idx_products_quantity ON products(quantity);
CREATE INDEX idx_products_updated_at ON products(updated_at);
CREATE INDEX idx_products_name_trgm ON products USING gin(name gin_trgm_ops);
CREATE INDEX idx_products_description_trgm ON products USING gin(description gin_trgm_ops);

CREATE TABLE orders (
    id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id     UUID REFERENCES users(id),
    status      VARCHAR(50) NOT NULL,
    total       NUMERIC(12, 2) DEFAULT 0.00,
    created_at  TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMP NOT NULL DEFAULT NOW()
);

-- Orders indices
CREATE INDEX idx_orders_user_id ON orders(user_id);
CREATE INDEX idx_orders_status ON orders(status);
CREATE INDEX idx_orders_created_at ON orders(created_at);
CREATE INDEX idx_orders_user_status ON orders(user_id, status);

CREATE TABLE order_items (
    order_id   UUID NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
    product_id UUID NOT NULL REFERENCES products(id),
    quantity   INT NOT NULL DEFAULT 1,
    unit_price NUMERIC(12, 2) NOT NULL,
    PRIMARY KEY (order_id, product_id)
);

-- Order items indices
CREATE INDEX idx_order_items_product_id ON order_items(product_id); 