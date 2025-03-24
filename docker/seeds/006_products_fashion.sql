DO $$
DECLARE
    clothing_features TEXT[] := ARRAY[
        'Made from premium materials',
        'Features a comfortable fit',
        'Includes detailed stitching',
        'Made with sustainable materials',
        'Features a modern cut',
        'Includes practical pockets',
        'Made with breathable fabric',
        'Features reinforced seams',
        'Designed for durability',
        'Includes adjustable elements'
    ];
    clothing_benefits TEXT[] := ARRAY[
        'Perfect for everyday wear.',
        'Ideal for special occasions.',
        'Ensures all-day comfort.',
        'Suitable for all seasons.',
        'Easy to mix and match.',
        'Great for layering.',
        'Maintains shape after washing.',
        'Versatile for different occasions.',
        'Provides excellent value.',
        'Timeless design that stays in style.'
    ];
    brand_variant RECORD;
    size_variant TEXT;
    color_variant TEXT;
    mens_category_id UUID;
    womens_category_id UUID;
BEGIN
    -- Get category IDs
    SELECT id INTO mens_category_id FROM categories WHERE slug = 'fashion-mens-clothing';
    SELECT id INTO womens_category_id FROM categories WHERE slug = 'fashion-womens-clothing';

    -- Premium Men's Fashion
    FOR brand_variant IN (
        SELECT 
            brand,
            category,
            item_type,
            CASE 
                WHEN brand IN ('Ralph Lauren', 'Hugo Boss', 'Brooks Brothers') THEN brands.base_price * 1.5
                WHEN brand IN ('Tommy Hilfiger', 'Calvin Klein', 'Lacoste') THEN brands.base_price * 1.2
                ELSE brands.base_price
            END as final_price,
            CASE 
                WHEN item_type IN ('Suit', 'Blazer', 'Coat') THEN ARRAY['38R', '40R', '42R', '44R', '46R']
                WHEN item_type IN ('Dress Shirt', 'Casual Shirt') THEN ARRAY['S', 'M', 'L', 'XL', 'XXL']
                ELSE ARRAY['30x30', '32x32', '34x32', '36x32', '38x32']
            END as size_options,
            CASE item_type
                WHEN 'Suit' THEN ARRAY['Navy', 'Charcoal', 'Black', 'Grey']
                WHEN 'Dress Shirt' THEN ARRAY['White', 'Light Blue', 'Pink', 'Striped']
                WHEN 'Casual Shirt' THEN ARRAY['Blue', 'White', 'Black', 'Grey', 'Navy']
                WHEN 'Jeans' THEN ARRAY['Dark Blue', 'Light Blue', 'Black', 'Grey']
                ELSE ARRAY['Black', 'Navy', 'Grey', 'Khaki', 'Olive']
            END as color_options
        FROM (
            VALUES 
                ('Ralph Lauren', 'Professional', 'Suit', 599.99),
                ('Hugo Boss', 'Professional', 'Suit', 699.99),
                ('Brooks Brothers', 'Professional', 'Blazer', 449.99),
                ('Tommy Hilfiger', 'Professional', 'Dress Shirt', 89.99),
                ('Calvin Klein', 'Professional', 'Dress Shirt', 79.99),
                ('Lacoste', 'Casual', 'Polo Shirt', 89.99),
                ('Levi''s', 'Casual', 'Jeans', 69.99),
                ('Diesel', 'Casual', 'Jeans', 129.99),
                ('J.Crew', 'Casual', 'Chinos', 79.99),
                ('Uniqlo', 'Casual', 'T-Shirt', 24.99),
                ('Nike', 'Athletic', 'Performance Shirt', 39.99),
                ('Under Armour', 'Athletic', 'Athletic Shorts', 34.99),
                ('Adidas', 'Athletic', 'Track Pants', 59.99)
        ) brands(brand, category, item_type, base_price)
    ) LOOP
        FOREACH size_variant IN ARRAY brand_variant.size_options
        LOOP
            FOREACH color_variant IN ARRAY brand_variant.color_options
            LOOP
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
                    mens_category_id,
                    brand_variant.brand || ' ' || brand_variant.item_type || ' - ' || 
                    color_variant || ' (' || size_variant || ')',
                    
                    LOWER(REPLACE(
                        brand_variant.brand || '-' || brand_variant.item_type || '-' ||
                        color_variant || '-' || size_variant,
                        ' ', '-')),
                    
                    'MF-' || LEFT(brand_variant.brand, 2) || 
                    LEFT(REPLACE(brand_variant.item_type, ' ', ''), 3) ||
                    LEFT(size_variant, 2) ||
                    '-' || LEFT(MD5(RANDOM()::TEXT), 4),
                    
                    brand_variant.final_price,
                    
                    -- Stock levels vary by category and brand tier
                    CASE 
                        WHEN brand_variant.brand IN ('Ralph Lauren', 'Hugo Boss', 'Brooks Brothers')
                        THEN floor(random() * 15 + 5)::int
                        WHEN brand_variant.category = 'Athletic'
                        THEN floor(random() * 50 + 30)::int
                        ELSE floor(random() * 30 + 15)::int
                    END,
                    
                    generate_description(
                        brand_variant.brand || ' ' || brand_variant.item_type || ' in ' || 
                        color_variant,
                        clothing_features,
                        clothing_benefits
                    ),
                    
                    'https://placehold.co/600x800/fashion/' || 
                    LOWER(REPLACE(brand_variant.brand, ' ', '-')) || '-' ||
                    LOWER(REPLACE(brand_variant.item_type, ' ', '-'))
                );
            END LOOP;
        END LOOP;
    END LOOP;

    -- Women's Fashion
    FOR brand_variant IN (
        SELECT 
            brand,
            category,
            item_type,
            CASE 
                WHEN brand IN ('Theory', 'Vince', 'Eileen Fisher') THEN brands.base_price * 1.5
                WHEN brand IN ('Michael Kors', 'Kate Spade', 'Coach') THEN brands.base_price * 1.3
                ELSE brands.base_price
            END as final_price,
            CASE 
                WHEN item_type IN ('Dress', 'Blazer', 'Coat') THEN ARRAY['0', '2', '4', '6', '8', '10', '12', '14']
                ELSE ARRAY['XS', 'S', 'M', 'L', 'XL']
            END as size_options,
            CASE item_type
                WHEN 'Dress' THEN ARRAY['Black', 'Navy', 'Red', 'Floral', 'White']
                WHEN 'Blouse' THEN ARRAY['White', 'Ivory', 'Black', 'Pink', 'Blue']
                WHEN 'Skirt' THEN ARRAY['Black', 'Navy', 'Grey', 'Plaid']
                WHEN 'Jeans' THEN ARRAY['Dark Blue', 'Light Blue', 'Black', 'White']
                ELSE ARRAY['Black', 'Navy', 'Grey', 'Beige', 'Brown']
            END as color_options
        FROM (
            VALUES 
                ('Theory', 'Professional', 'Blazer', 425.99),
                ('Vince', 'Professional', 'Dress', 375.99),
                ('Eileen Fisher', 'Professional', 'Blouse', 228.99),
                ('Michael Kors', 'Professional', 'Dress', 175.99),
                ('Kate Spade', 'Professional', 'Skirt', 198.99),
                ('Coach', 'Professional', 'Blazer', 348.99),
                ('Madewell', 'Casual', 'Jeans', 128.99),
                ('J.Crew', 'Casual', 'Sweater', 89.99),
                ('Anthropologie', 'Casual', 'Dress', 148.99),
                ('Zara', 'Casual', 'Blouse', 49.99),
                ('Lululemon', 'Athletic', 'Leggings', 98.99),
                ('Athleta', 'Athletic', 'Sports Bra', 54.99),
                ('Nike', 'Athletic', 'Athletic Top', 45.99)
        ) brands(brand, category, item_type, base_price)
    ) LOOP
        FOREACH size_variant IN ARRAY brand_variant.size_options
        LOOP
            FOREACH color_variant IN ARRAY brand_variant.color_options
            LOOP
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
                    womens_category_id,
                    brand_variant.brand || ' ' || brand_variant.item_type || ' - ' || 
                    color_variant || ' (Size ' || size_variant || ')',
                    
                    LOWER(REPLACE(
                        brand_variant.brand || '-' || brand_variant.item_type || '-' ||
                        color_variant || '-' || size_variant,
                        ' ', '-')),
                    
                    'WF-' || LEFT(brand_variant.brand, 2) || 
                    LEFT(REPLACE(brand_variant.item_type, ' ', ''), 3) ||
                    REPLACE(size_variant, ' ', '') ||
                    '-' || LEFT(MD5(RANDOM()::TEXT), 4),
                    
                    brand_variant.final_price,
                    
                    -- Stock levels vary by category and brand tier
                    CASE 
                        WHEN brand_variant.brand IN ('Theory', 'Vince', 'Eileen Fisher')
                        THEN floor(random() * 15 + 5)::int
                        WHEN brand_variant.category = 'Athletic'
                        THEN floor(random() * 50 + 30)::int
                        ELSE floor(random() * 30 + 15)::int
                    END,
                    
                    generate_description(
                        brand_variant.brand || ' ' || brand_variant.item_type || ' in ' || 
                        color_variant,
                        clothing_features,
                        clothing_benefits
                    ),
                    
                    'https://placehold.co/600x800/fashion/' || 
                    LOWER(REPLACE(brand_variant.brand, ' ', '-')) || '-' ||
                    LOWER(REPLACE(brand_variant.item_type, ' ', '-'))
                );
            END LOOP;
        END LOOP;
    END LOOP;
END $$; 