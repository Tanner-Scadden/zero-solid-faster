-- Smartphones
DO $$ 
DECLARE
    smartphone_features TEXT[] := ARRAY[
        'Features an advanced camera system',
        'Powered by the latest processor',
        'Includes 5G connectivity',
        'Boasts an edge-to-edge display',
        'Equipped with wireless charging',
        'Features an under-display fingerprint sensor',
        'Includes a triple-lens camera setup',
        'Supports fast charging technology'
    ];
    smartphone_benefits TEXT[] := ARRAY[
        'Perfect for photography enthusiasts.',
        'Ideal for mobile gaming and multitasking.',
        'Ensures you stay connected at high speeds.',
        'Delivers an immersive viewing experience.',
        'Provides all-day battery life.',
        'Offers enhanced security features.',
        'Captures professional-quality photos and videos.',
        'Keeps you powered up throughout the day.'
    ];
    phone_variants RECORD;
    base_price NUMERIC;
    variant_price NUMERIC;
    storage_size TEXT;
BEGIN
    -- High-end smartphones
    FOR phone_variants IN (
        SELECT 
            brand,
            model,
            variant,
            CASE variant
                WHEN 'Pro Max' THEN 1299.99
                WHEN 'Pro' THEN 999.99
                WHEN 'Plus' THEN 899.99
                ELSE 799.99
            END as base_price,
            CASE 
                WHEN brand = 'Apple' THEN ARRAY['128GB', '256GB', '512GB', '1TB']
                ELSE ARRAY['128GB', '256GB', '512GB']
            END as storage_options
        FROM (
            VALUES 
                ('Apple', 'iPhone 15', ARRAY['Pro Max', 'Pro', 'Plus', 'Base']),
                ('Samsung', 'Galaxy S24', ARRAY['Ultra', 'Plus', 'Base']),
                ('Google', 'Pixel 8', ARRAY['Pro', 'Base']),
                ('OnePlus', '12', ARRAY['Pro', 'Base'])
        ) phones(brand, model, variants)
        CROSS JOIN UNNEST(variants) as variant
    ) LOOP
        FOREACH storage_size IN ARRAY phone_variants.storage_options
        LOOP
            base_price := phone_variants.base_price + 
                         CASE storage_size
                             WHEN '256GB' THEN 100
                             WHEN '512GB' THEN 200
                             WHEN '1TB' THEN 300
                             ELSE 0
                         END;
            
            INSERT INTO products (
                category_id,
                name,
                slug,
                sku,
                price,
                quantity,
                description,
                image_url
            ) VALUES (
                (SELECT id FROM categories WHERE slug = 'electronics-smartphones'),
                phone_variants.brand || ' ' || phone_variants.model || ' ' || 
                phone_variants.variant || ' ' || storage_size,
                
                LOWER(REPLACE(
                    phone_variants.brand || '-' || phone_variants.model || '-' ||
                    phone_variants.variant || '-' || storage_size,
                    ' ', '-')),
                
                'PH-' || LEFT(phone_variants.brand, 2) || 
                REPLACE(phone_variants.model, ' ', '') ||
                LEFT(phone_variants.variant, 1) || 
                REPLACE(storage_size, 'GB', '') ||
                '-' || LEFT(MD5(RANDOM()::TEXT), 4),
                
                base_price,
                
                -- Stock levels vary by variant and storage
                CASE 
                    WHEN phone_variants.variant LIKE '%Pro%' OR phone_variants.variant = 'Ultra' 
                    THEN floor(random() * 30 + 10)::int
                    ELSE floor(random() * 50 + 20)::int
                END,
                
                generate_description(
                    phone_variants.brand || ' ' || phone_variants.model || ' ' || 
                    phone_variants.variant || ' ' || storage_size,
                    smartphone_features,
                    smartphone_benefits
                ),
                
                'https://placehold.co/600x400/tech/' || 
                LOWER(phone_variants.brand) || '-' || 
                LOWER(REPLACE(phone_variants.model, ' ', '-'))
            );
        END LOOP;
    END LOOP;

    -- Mid-range smartphones
    FOR phone_variants IN (
        SELECT 
            brand,
            model,
            variant,
            CASE variant
                WHEN 'Plus' THEN 499.99
                ELSE 399.99
            END as base_price,
            ARRAY['64GB', '128GB', '256GB'] as storage_options
        FROM (
            VALUES 
                ('Samsung', 'Galaxy A54', ARRAY['5G', 'Plus']),
                ('Google', 'Pixel 7a', ARRAY['5G']),
                ('OnePlus', 'Nord N30', ARRAY['5G']),
                ('Motorola', 'Edge 2023', ARRAY['5G', 'Plus'])
        ) phones(brand, model, variants)
        CROSS JOIN UNNEST(variants) as variant
    ) LOOP
        FOREACH storage_size IN ARRAY phone_variants.storage_options
        LOOP
            base_price := phone_variants.base_price + 
                         CASE storage_size
                             WHEN '128GB' THEN 50
                             WHEN '256GB' THEN 100
                             ELSE 0
                         END;
            
            INSERT INTO products (
                category_id,
                name,
                slug,
                sku,
                price,
                quantity,
                description,
                image_url
            ) VALUES (
                (SELECT id FROM categories WHERE slug = 'electronics-smartphones'),
                phone_variants.brand || ' ' || phone_variants.model || ' ' || 
                phone_variants.variant || ' ' || storage_size,
                
                LOWER(REPLACE(
                    phone_variants.brand || '-' || phone_variants.model || '-' ||
                    phone_variants.variant || '-' || storage_size,
                    ' ', '-')),
                
                'PH-' || LEFT(phone_variants.brand, 2) || 
                REPLACE(phone_variants.model, ' ', '') ||
                LEFT(phone_variants.variant, 1) || 
                REPLACE(storage_size, 'GB', '') ||
                '-' || LEFT(MD5(RANDOM()::TEXT), 4),
                
                base_price,
                
                floor(random() * 100 + 50)::int,
                
                generate_description(
                    phone_variants.brand || ' ' || phone_variants.model || ' ' || 
                    phone_variants.variant || ' ' || storage_size,
                    smartphone_features,
                    smartphone_benefits
                ),
                
                'https://placehold.co/600x400/tech/' || 
                LOWER(phone_variants.brand) || '-' || 
                LOWER(REPLACE(phone_variants.model, ' ', '-'))
            );
        END LOOP;
    END LOOP;
END $$;

-- Laptops
DO $$ 
DECLARE
    laptop_features TEXT[] := ARRAY[
        'Features a high-resolution display',
        'Powered by the latest generation processor',
        'Includes a backlit keyboard',
        'Equipped with fast SSD storage',
        'Features Thunderbolt ports',
        'Includes dedicated graphics',
        'Features a precision touchpad',
        'Equipped with Wi-Fi 6E'
    ];
    laptop_benefits TEXT[] := ARRAY[
        'Perfect for professional work.',
        'Ideal for content creation and gaming.',
        'Ensures smooth multitasking performance.',
        'Delivers exceptional battery life.',
        'Provides desktop-class performance.',
        'Offers immersive gaming experience.',
        'Perfect for creative professionals.',
        'Ideal for remote work and travel.'
    ];
    laptop_variant RECORD;
    base_price NUMERIC;
    ram_storage TEXT;
BEGIN
    -- Premium laptops
    FOR laptop_variant IN (
        SELECT 
            brand,
            model,
            category,
            CASE category
                WHEN 'Gaming' THEN 1499.99
                WHEN 'Professional' THEN 1399.99
                ELSE 1199.99
            END as base_price,
            CASE 
                WHEN category = 'Gaming' THEN ARRAY['16GB/512GB', '32GB/1TB', '32GB/2TB']
                ELSE ARRAY['8GB/256GB', '16GB/512GB', '32GB/1TB']
            END as config_options
        FROM (
            VALUES 
                ('Apple', 'MacBook Pro 14"', ARRAY['Professional']),
                ('Apple', 'MacBook Pro 16"', ARRAY['Professional']),
                ('Dell', 'XPS 13', ARRAY['Professional', 'Consumer']),
                ('Dell', 'XPS 15', ARRAY['Professional', 'Gaming']),
                ('Lenovo', 'ThinkPad X1 Carbon', ARRAY['Professional']),
                ('Lenovo', 'Legion Pro 7', ARRAY['Gaming']),
                ('ASUS', 'ROG Zephyrus G14', ARRAY['Gaming']),
                ('ASUS', 'ROG Zephyrus G16', ARRAY['Gaming']),
                ('Razer', 'Blade 14', ARRAY['Gaming']),
                ('Razer', 'Blade 16', ARRAY['Gaming'])
        ) laptops(brand, model, categories)
        CROSS JOIN UNNEST(categories) as category
    ) LOOP
        FOREACH ram_storage IN ARRAY laptop_variant.config_options
        LOOP
            base_price := laptop_variant.base_price + 
                         CASE ram_storage
                             WHEN '16GB/512GB' THEN 200
                             WHEN '32GB/1TB' THEN 400
                             WHEN '32GB/2TB' THEN 600
                             ELSE 0
                         END;
            
            INSERT INTO products (
                category_id,
                name,
                slug,
                sku,
                price,
                quantity,
                description,
                image_url
            ) VALUES (
                (SELECT id FROM categories WHERE slug = 'electronics-laptops'),
                laptop_variant.brand || ' ' || laptop_variant.model || ' ' || 
                laptop_variant.category || ' ' || ram_storage,
                
                LOWER(REPLACE(
                    laptop_variant.brand || '-' || laptop_variant.model || '-' ||
                    laptop_variant.category || '-' || ram_storage,
                    ' ', '-')),
                
                'LT-' || LEFT(laptop_variant.brand, 2) || 
                REPLACE(laptop_variant.model, ' ', '') ||
                LEFT(laptop_variant.category, 1) || 
                LEFT(ram_storage, 2) ||
                '-' || LEFT(MD5(RANDOM()::TEXT), 4),
                
                base_price,
                
                -- Stock levels vary by category
                CASE 
                    WHEN laptop_variant.category = 'Gaming'
                    THEN floor(random() * 20 + 5)::int
                    ELSE floor(random() * 30 + 10)::int
                END,
                
                generate_description(
                    laptop_variant.brand || ' ' || laptop_variant.model || ' ' || 
                    laptop_variant.category || ' ' || ram_storage,
                    laptop_features,
                    laptop_benefits
                ),
                
                'https://placehold.co/600x400/tech/' || 
                LOWER(laptop_variant.brand) || '-' || 
                LOWER(REPLACE(laptop_variant.model, ' ', '-'))
            );
        END LOOP;
    END LOOP;

    -- Mid-range laptops
    FOR laptop_variant IN (
        SELECT 
            brand,
            model,
            category,
            CASE category
                WHEN 'Gaming' THEN 899.99
                ELSE 699.99
            END as base_price,
            ARRAY['8GB/256GB', '16GB/512GB'] as config_options
        FROM (
            VALUES 
                ('Apple', 'MacBook Air', ARRAY['Consumer']),
                ('Dell', 'Inspiron 15', ARRAY['Consumer', 'Gaming']),
                ('Lenovo', 'IdeaPad 5', ARRAY['Consumer']),
                ('ASUS', 'TUF Gaming A15', ARRAY['Gaming']),
                ('HP', 'Pavilion 15', ARRAY['Consumer', 'Gaming']),
                ('Acer', 'Swift 3', ARRAY['Consumer']),
                ('Acer', 'Nitro 5', ARRAY['Gaming'])
        ) laptops(brand, model, categories)
        CROSS JOIN UNNEST(categories) as category
    ) LOOP
        FOREACH ram_storage IN ARRAY laptop_variant.config_options
        LOOP
            base_price := laptop_variant.base_price + 
                         CASE ram_storage
                             WHEN '16GB/512GB' THEN 200
                             ELSE 0
                         END;
            
            INSERT INTO products (
                category_id,
                name,
                slug,
                sku,
                price,
                quantity,
                description,
                image_url
            ) VALUES (
                (SELECT id FROM categories WHERE slug = 'electronics-laptops'),
                laptop_variant.brand || ' ' || laptop_variant.model || ' ' || 
                laptop_variant.category || ' ' || ram_storage,
                
                LOWER(REPLACE(
                    laptop_variant.brand || '-' || laptop_variant.model || '-' ||
                    laptop_variant.category || '-' || ram_storage,
                    ' ', '-')),
                
                'LT-' || LEFT(laptop_variant.brand, 2) || 
                REPLACE(laptop_variant.model, ' ', '') ||
                LEFT(laptop_variant.category, 1) || 
                LEFT(ram_storage, 2) ||
                '-' || LEFT(MD5(RANDOM()::TEXT), 4),
                
                base_price,
                
                floor(random() * 50 + 20)::int,
                
                generate_description(
                    laptop_variant.brand || ' ' || laptop_variant.model || ' ' || 
                    laptop_variant.category || ' ' || ram_storage,
                    laptop_features,
                    laptop_benefits
                ),
                
                'https://placehold.co/600x400/tech/' || 
                LOWER(laptop_variant.brand) || '-' || 
                LOWER(REPLACE(laptop_variant.model, ' ', '-'))
            );
        END LOOP;
    END LOOP;
END $$; 