-- Insert main categories
INSERT INTO categories (name, slug, description) VALUES
('Electronics', 'electronics', 'Electronic devices and accessories'),
('Fashion', 'fashion', 'Clothing, shoes, and accessories'),
('Home & Garden', 'home-garden', 'Home decor, furniture, and garden supplies'),
('Books & Media', 'books-media', 'Books, movies, music, and educational materials'),
('Sports & Outdoors', 'sports-outdoors', 'Sports equipment and outdoor gear'),
('Beauty & Health', 'beauty-health', 'Cosmetics, personal care, and health products'),
('Toys & Games', 'toys-games', 'Toys, games, and entertainment'),
('Food & Beverages', 'food-beverages', 'Food items and drinks'),
('Automotive', 'automotive', 'Car parts, accessories, and maintenance'),
('Art & Crafts', 'art-crafts', 'Art supplies and craft materials');

-- Insert subcategories for Electronics
INSERT INTO categories (parent_id, name, slug, description) VALUES
((SELECT id FROM categories WHERE slug = 'electronics'), 'Smartphones', 'electronics-smartphones', 'Mobile phones and accessories'),
((SELECT id FROM categories WHERE slug = 'electronics'), 'Laptops', 'electronics-laptops', 'Notebooks and accessories'),
((SELECT id FROM categories WHERE slug = 'electronics'), 'Tablets', 'electronics-tablets', 'Tablet devices and accessories'),
((SELECT id FROM categories WHERE slug = 'electronics'), 'Audio', 'electronics-audio', 'Headphones, speakers, and audio equipment'),
((SELECT id FROM categories WHERE slug = 'electronics'), 'Cameras', 'electronics-cameras', 'Digital cameras and photography equipment');

-- Insert sub-subcategories for Electronics > Smartphones
INSERT INTO categories (parent_id, name, slug, description) VALUES
((SELECT id FROM categories WHERE slug = 'electronics-smartphones'), 'Android Phones', 'electronics-smartphones-android', 'Android smartphones'),
((SELECT id FROM categories WHERE slug = 'electronics-smartphones'), 'iPhones', 'electronics-smartphones-iphone', 'Apple iPhones'),
((SELECT id FROM categories WHERE slug = 'electronics-smartphones'), 'Phone Cases', 'electronics-smartphones-cases', 'Protective cases and covers'),
((SELECT id FROM categories WHERE slug = 'electronics-smartphones'), 'Chargers', 'electronics-smartphones-chargers', 'Charging cables and accessories');

-- Insert subcategories for Fashion
INSERT INTO categories (parent_id, name, slug, description) VALUES
((SELECT id FROM categories WHERE slug = 'fashion'), 'Men''s Clothing', 'fashion-mens-clothing', 'Clothing for men'),
((SELECT id FROM categories WHERE slug = 'fashion'), 'Women''s Clothing', 'fashion-womens-clothing', 'Clothing for women'),
((SELECT id FROM categories WHERE slug = 'fashion'), 'Kids'' Clothing', 'fashion-kids-clothing', 'Clothing for children'),
((SELECT id FROM categories WHERE slug = 'fashion'), 'Shoes', 'fashion-shoes', 'Footwear for all ages'),
((SELECT id FROM categories WHERE slug = 'fashion'), 'Accessories', 'fashion-accessories', 'Fashion accessories');

-- Insert sub-subcategories for Fashion > Men's Clothing
INSERT INTO categories (parent_id, name, slug, description) VALUES
((SELECT id FROM categories WHERE slug = 'fashion-mens-clothing'), 'T-Shirts', 'fashion-mens-clothing-t-shirts', 'Men''s t-shirts'),
((SELECT id FROM categories WHERE slug = 'fashion-mens-clothing'), 'Jeans', 'fashion-mens-clothing-jeans', 'Men''s jeans'),
((SELECT id FROM categories WHERE slug = 'fashion-mens-clothing'), 'Suits', 'fashion-mens-clothing-suits', 'Men''s suits and formal wear'),
((SELECT id FROM categories WHERE slug = 'fashion-mens-clothing'), 'Outerwear', 'fashion-mens-clothing-outerwear', 'Men''s jackets and coats');

-- Insert subcategories for Home & Garden
INSERT INTO categories (parent_id, name, slug, description) VALUES
((SELECT id FROM categories WHERE slug = 'home-garden'), 'Furniture', 'home-garden-furniture', 'Home and office furniture'),
((SELECT id FROM categories WHERE slug = 'home-garden'), 'Decor', 'home-garden-decor', 'Home decoration items'),
((SELECT id FROM categories WHERE slug = 'home-garden'), 'Kitchen', 'home-garden-kitchen', 'Kitchen appliances and accessories'),
((SELECT id FROM categories WHERE slug = 'home-garden'), 'Garden', 'home-garden-garden', 'Garden tools and plants'),
((SELECT id FROM categories WHERE slug = 'home-garden'), 'Lighting', 'home-garden-lighting', 'Home lighting fixtures');

-- Insert sub-subcategories for Home & Garden > Furniture
INSERT INTO categories (parent_id, name, slug, description) VALUES
((SELECT id FROM categories WHERE slug = 'home-garden-furniture'), 'Living Room', 'home-garden-furniture-living-room', 'Living room furniture'),
((SELECT id FROM categories WHERE slug = 'home-garden-furniture'), 'Bedroom', 'home-garden-furniture-bedroom', 'Bedroom furniture'),
((SELECT id FROM categories WHERE slug = 'home-garden-furniture'), 'Office', 'home-garden-furniture-office', 'Office furniture'),
((SELECT id FROM categories WHERE slug = 'home-garden-furniture'), 'Outdoor', 'home-garden-furniture-outdoor', 'Outdoor furniture');

-- Insert subcategories for Books & Media
INSERT INTO categories (parent_id, name, slug, description) VALUES
((SELECT id FROM categories WHERE slug = 'books-media'), 'Books', 'books-media-books', 'Physical and digital books'),
((SELECT id FROM categories WHERE slug = 'books-media'), 'Movies', 'books-media-movies', 'Movies and TV shows'),
((SELECT id FROM categories WHERE slug = 'books-media'), 'Music', 'books-media-music', 'Music albums and singles'),
((SELECT id FROM categories WHERE slug = 'books-media'), 'Magazines', 'books-media-magazines', 'Periodicals and magazines'),
((SELECT id FROM categories WHERE slug = 'books-media'), 'Educational', 'books-media-educational', 'Educational materials');

-- Insert sub-subcategories for Books & Media > Books
INSERT INTO categories (parent_id, name, slug, description) VALUES
((SELECT id FROM categories WHERE slug = 'books-media-books'), 'Fiction', 'books-media-books-fiction', 'Fiction books'),
((SELECT id FROM categories WHERE slug = 'books-media-books'), 'Non-Fiction', 'books-media-books-non-fiction', 'Non-fiction books'),
((SELECT id FROM categories WHERE slug = 'books-media-books'), 'Children''s Books', 'books-media-books-children', 'Books for children'),
((SELECT id FROM categories WHERE slug = 'books-media-books'), 'Textbooks', 'books-media-books-textbooks', 'Educational textbooks');

-- Insert subcategories for Sports & Outdoors
INSERT INTO categories (parent_id, name, slug, description) VALUES
((SELECT id FROM categories WHERE slug = 'sports-outdoors'), 'Team Sports', 'sports-outdoors-team-sports', 'Equipment for team sports'),
((SELECT id FROM categories WHERE slug = 'sports-outdoors'), 'Fitness', 'sports-outdoors-fitness', 'Fitness equipment and accessories'),
((SELECT id FROM categories WHERE slug = 'sports-outdoors'), 'Camping', 'sports-outdoors-camping', 'Camping gear and equipment'),
((SELECT id FROM categories WHERE slug = 'sports-outdoors'), 'Cycling', 'sports-outdoors-cycling', 'Bicycles and cycling accessories'),
((SELECT id FROM categories WHERE slug = 'sports-outdoors'), 'Water Sports', 'sports-outdoors-water-sports', 'Water sports equipment');

-- Insert sub-subcategories for Sports & Outdoors > Team Sports
INSERT INTO categories (parent_id, name, slug, description) VALUES
((SELECT id FROM categories WHERE slug = 'sports-outdoors-team-sports'), 'Soccer', 'sports-outdoors-team-sports-soccer', 'Soccer equipment'),
((SELECT id FROM categories WHERE slug = 'sports-outdoors-team-sports'), 'Basketball', 'sports-outdoors-team-sports-basketball', 'Basketball equipment'),
((SELECT id FROM categories WHERE slug = 'sports-outdoors-team-sports'), 'Baseball', 'sports-outdoors-team-sports-baseball', 'Baseball equipment'),
((SELECT id FROM categories WHERE slug = 'sports-outdoors-team-sports'), 'Football', 'sports-outdoors-team-sports-football', 'Football equipment');

-- Insert subcategories for Beauty & Health
INSERT INTO categories (parent_id, name, slug, description) VALUES
((SELECT id FROM categories WHERE slug = 'beauty-health'), 'Makeup', 'beauty-health-makeup', 'Cosmetic products'),
((SELECT id FROM categories WHERE slug = 'beauty-health'), 'Skincare', 'beauty-health-skincare', 'Skin care products'),
((SELECT id FROM categories WHERE slug = 'beauty-health'), 'Hair Care', 'beauty-health-hair-care', 'Hair care products'),
((SELECT id FROM categories WHERE slug = 'beauty-health'), 'Personal Care', 'beauty-health-personal-care', 'Personal care products'),
((SELECT id FROM categories WHERE slug = 'beauty-health'), 'Health', 'beauty-health-health', 'Health and wellness products');

-- Insert sub-subcategories for Beauty & Health > Makeup
INSERT INTO categories (parent_id, name, slug, description) VALUES
((SELECT id FROM categories WHERE slug = 'beauty-health-makeup'), 'Face', 'beauty-health-makeup-face', 'Face makeup products'),
((SELECT id FROM categories WHERE slug = 'beauty-health-makeup'), 'Eyes', 'beauty-health-makeup-eyes', 'Eye makeup products'),
((SELECT id FROM categories WHERE slug = 'beauty-health-makeup'), 'Lips', 'beauty-health-makeup-lips', 'Lip makeup products'),
((SELECT id FROM categories WHERE slug = 'beauty-health-makeup'), 'Nails', 'beauty-health-makeup-nails', 'Nail care products');

-- Insert subcategories for Toys & Games
INSERT INTO categories (parent_id, name, slug, description) VALUES
((SELECT id FROM categories WHERE slug = 'toys-games'), 'Board Games', 'toys-games-board-games', 'Traditional board games'),
((SELECT id FROM categories WHERE slug = 'toys-games'), 'Video Games', 'toys-games-video-games', 'Video games and consoles'),
((SELECT id FROM categories WHERE slug = 'toys-games'), 'Educational Toys', 'toys-games-educational', 'Educational toys and games'),
((SELECT id FROM categories WHERE slug = 'toys-games'), 'Action Figures', 'toys-games-action-figures', 'Action figures and collectibles'),
((SELECT id FROM categories WHERE slug = 'toys-games'), 'Puzzles', 'toys-games-puzzles', 'Jigsaw puzzles and brain teasers');

-- Insert sub-subcategories for Toys & Games > Board Games
INSERT INTO categories (parent_id, name, slug, description) VALUES
((SELECT id FROM categories WHERE slug = 'toys-games-board-games'), 'Strategy', 'toys-games-board-games-strategy', 'Strategy board games'),
((SELECT id FROM categories WHERE slug = 'toys-games-board-games'), 'Family', 'toys-games-board-games-family', 'Family board games'),
((SELECT id FROM categories WHERE slug = 'toys-games-board-games'), 'Party', 'toys-games-board-games-party', 'Party board games'),
((SELECT id FROM categories WHERE slug = 'toys-games-board-games'), 'Card Games', 'toys-games-board-games-cards', 'Card games and decks');

-- Insert subcategories for Food & Beverages
INSERT INTO categories (parent_id, name, slug, description) VALUES
((SELECT id FROM categories WHERE slug = 'food-beverages'), 'Groceries', 'food-beverages-groceries', 'Food and grocery items'),
((SELECT id FROM categories WHERE slug = 'food-beverages'), 'Beverages', 'food-beverages-drinks', 'Drinks and beverages'),
((SELECT id FROM categories WHERE slug = 'food-beverages'), 'Snacks', 'food-beverages-snacks', 'Snacks and treats'),
((SELECT id FROM categories WHERE slug = 'food-beverages'), 'Organic', 'food-beverages-organic', 'Organic food products'),
((SELECT id FROM categories WHERE slug = 'food-beverages'), 'International', 'food-beverages-international', 'International cuisine');

-- Insert sub-subcategories for Food & Beverages > Groceries
INSERT INTO categories (parent_id, name, slug, description) VALUES
((SELECT id FROM categories WHERE slug = 'food-beverages-groceries'), 'Fresh Produce', 'food-beverages-groceries-produce', 'Fresh fruits and vegetables'),
((SELECT id FROM categories WHERE slug = 'food-beverages-groceries'), 'Meat & Seafood', 'food-beverages-groceries-meat', 'Meat and seafood products'),
((SELECT id FROM categories WHERE slug = 'food-beverages-groceries'), 'Dairy', 'food-beverages-groceries-dairy', 'Dairy products'),
((SELECT id FROM categories WHERE slug = 'food-beverages-groceries'), 'Pantry', 'food-beverages-groceries-pantry', 'Pantry staples');

-- Insert subcategories for Automotive
INSERT INTO categories (parent_id, name, slug, description) VALUES
((SELECT id FROM categories WHERE slug = 'automotive'), 'Parts', 'automotive-parts', 'Car parts and components'),
((SELECT id FROM categories WHERE slug = 'automotive'), 'Accessories', 'automotive-accessories', 'Car accessories'),
((SELECT id FROM categories WHERE slug = 'automotive'), 'Tools', 'automotive-tools', 'Automotive tools'),
((SELECT id FROM categories WHERE slug = 'automotive'), 'Care', 'automotive-care', 'Car care products'),
((SELECT id FROM categories WHERE slug = 'automotive'), 'Electronics', 'automotive-electronics', 'Car electronics');

-- Insert sub-subcategories for Automotive > Parts
INSERT INTO categories (parent_id, name, slug, description) VALUES
((SELECT id FROM categories WHERE slug = 'automotive-parts'), 'Engine', 'automotive-parts-engine', 'Engine parts'),
((SELECT id FROM categories WHERE slug = 'automotive-parts'), 'Brakes', 'automotive-parts-brakes', 'Brake system parts'),
((SELECT id FROM categories WHERE slug = 'automotive-parts'), 'Suspension', 'automotive-parts-suspension', 'Suspension parts'),
((SELECT id FROM categories WHERE slug = 'automotive-parts'), 'Electrical', 'automotive-parts-electrical', 'Electrical system parts');

-- Insert subcategories for Art & Crafts
INSERT INTO categories (parent_id, name, slug, description) VALUES
((SELECT id FROM categories WHERE slug = 'art-crafts'), 'Drawing', 'art-crafts-drawing', 'Drawing supplies'),
((SELECT id FROM categories WHERE slug = 'art-crafts'), 'Painting', 'art-crafts-painting', 'Painting supplies'),
((SELECT id FROM categories WHERE slug = 'art-crafts'), 'Crafting', 'art-crafts-crafting', 'Crafting materials'),
((SELECT id FROM categories WHERE slug = 'art-crafts'), 'Scrapbooking', 'art-crafts-scrapbooking', 'Scrapbooking supplies'),
((SELECT id FROM categories WHERE slug = 'art-crafts'), 'Sewing', 'art-crafts-sewing', 'Sewing supplies');

-- Insert sub-subcategories for Art & Crafts > Drawing
INSERT INTO categories (parent_id, name, slug, description) VALUES
((SELECT id FROM categories WHERE slug = 'art-crafts-drawing'), 'Pencils', 'art-crafts-drawing-pencils', 'Drawing pencils'),
((SELECT id FROM categories WHERE slug = 'art-crafts-drawing'), 'Paper', 'art-crafts-drawing-paper', 'Drawing paper'),
((SELECT id FROM categories WHERE slug = 'art-crafts-drawing'), 'Markers', 'art-crafts-drawing-markers', 'Drawing markers'),
((SELECT id FROM categories WHERE slug = 'art-crafts-drawing'), 'Accessories', 'art-crafts-drawing-accessories', 'Drawing accessories'); 