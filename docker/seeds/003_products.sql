-- Insert products for Electronics > Smartphones
INSERT INTO products (category_id, name, slug, sku, price, quantity, description, image_url) VALUES
((SELECT id FROM categories WHERE slug = 'electronics-smartphones-android'), 'Samsung Galaxy S23 Ultra', 'samsung-galaxy-s23-ultra', 'SAMS23U-256-BLK', 1199.99, 50, 'Flagship Android smartphone with 256GB storage and advanced camera system', 'https://example.com/images/galaxy-s23-ultra.jpg'),
((SELECT id FROM categories WHERE slug = 'electronics-smartphones-android'), 'Google Pixel 8 Pro', 'google-pixel-8-pro', 'GGLPX8P-256-HAZ', 999.99, 35, 'Google''s latest flagship with advanced AI features and exceptional camera', 'https://example.com/images/pixel-8-pro.jpg'),
((SELECT id FROM categories WHERE slug = 'electronics-smartphones-android'), 'OnePlus 12', 'oneplus-12', 'OP12-256-EMR', 899.99, 40, 'Powerful Android phone with Snapdragon 8 Gen 3 and fast charging', 'https://example.com/images/oneplus-12.jpg'),
((SELECT id FROM categories WHERE slug = 'electronics-smartphones-iphone'), 'iPhone 15 Pro Max', 'iphone-15-pro-max', 'APL15PM-256-TIT', 1199.99, 45, 'Apple''s premium iPhone with A17 Pro chip and titanium design', 'https://example.com/images/iphone-15-pro-max.jpg'),
((SELECT id FROM categories WHERE slug = 'electronics-smartphones-iphone'), 'iPhone 15', 'iphone-15', 'APL15-128-PINK', 799.99, 60, 'Feature-rich iPhone with dynamic island and USB-C', 'https://example.com/images/iphone-15.jpg');

-- Insert products for Electronics > Laptops
INSERT INTO products (category_id, name, slug, sku, price, quantity, description, image_url) VALUES
((SELECT id FROM categories WHERE slug = 'electronics-laptops'), 'MacBook Pro 16" M3', 'macbook-pro-16-m3', 'APLMBP16-M3-SG', 2499.99, 25, '16-inch MacBook Pro with M3 Pro chip and Mini-LED display', 'https://example.com/images/macbook-pro-16.jpg'),
((SELECT id FROM categories WHERE slug = 'electronics-laptops'), 'Dell XPS 15', 'dell-xps-15', 'DELLXPS15-i9-RTX', 2199.99, 30, 'Premium Windows laptop with 4K OLED display and RTX graphics', 'https://example.com/images/dell-xps-15.jpg'),
((SELECT id FROM categories WHERE slug = 'electronics-laptops'), 'Lenovo ThinkPad X1 Carbon', 'lenovo-thinkpad-x1-carbon', 'LENX1C-i7-1TB', 1799.99, 20, 'Business laptop with excellent keyboard and long battery life', 'https://example.com/images/thinkpad-x1.jpg'),
((SELECT id FROM categories WHERE slug = 'electronics-laptops'), 'ASUS ROG Zephyrus G14', 'asus-rog-zephyrus-g14', 'ASUSROG-R9-RTX', 1699.99, 15, 'Compact gaming laptop with AMD Ryzen 9 and RTX graphics', 'https://example.com/images/rog-g14.jpg'),
((SELECT id FROM categories WHERE slug = 'electronics-laptops'), 'HP Spectre x360', 'hp-spectre-x360', 'HPSPEC-i7-OLED', 1499.99, 25, 'Convertible laptop with OLED display and premium design', 'https://example.com/images/spectre-x360.jpg');

-- Insert products for Fashion > Men's Clothing
INSERT INTO products (category_id, name, slug, sku, price, quantity, description, image_url) VALUES
((SELECT id FROM categories WHERE slug = 'fashion-mens-clothing-t-shirts'), 'Premium Cotton Crew Neck', 'premium-cotton-crew-neck', 'MCTS-BLK-L', 29.99, 100, 'Soft cotton t-shirt with comfortable fit', 'https://example.com/images/cotton-crew-neck.jpg'),
((SELECT id FROM categories WHERE slug = 'fashion-mens-clothing-t-shirts'), 'Organic Cotton V-Neck', 'organic-cotton-v-neck', 'MVTS-WHT-M', 24.99, 80, 'Eco-friendly v-neck t-shirt', 'https://example.com/images/organic-v-neck.jpg'),
((SELECT id FROM categories WHERE slug = 'fashion-mens-clothing-jeans'), 'Slim Fit Dark Wash Jeans', 'slim-fit-dark-wash-jeans', 'MJEN-DARK-32', 79.99, 50, 'Classic dark wash jeans with stretch comfort', 'https://example.com/images/dark-jeans.jpg'),
((SELECT id FROM categories WHERE slug = 'fashion-mens-clothing-jeans'), 'Straight Fit Light Wash Jeans', 'straight-fit-light-wash-jeans', 'MJEN-LIGHT-34', 69.99, 45, 'Comfortable straight fit jeans in light wash', 'https://example.com/images/light-jeans.jpg'),
((SELECT id FROM categories WHERE slug = 'fashion-mens-clothing-suits'), 'Classic Wool Suit', 'classic-wool-suit', 'MSUIT-NAVY-40', 499.99, 15, 'Timeless navy wool suit for any formal occasion', 'https://example.com/images/wool-suit.jpg');

-- Insert products for Home & Garden > Furniture
INSERT INTO products (category_id, name, slug, sku, price, quantity, description, image_url) VALUES
((SELECT id FROM categories WHERE slug = 'home-garden-furniture-living-room'), 'Modern Leather Sofa', 'modern-leather-sofa', 'FURN-SOFA-BLK', 1299.99, 10, 'Contemporary leather sofa with clean lines', 'https://example.com/images/leather-sofa.jpg'),
((SELECT id FROM categories WHERE slug = 'home-garden-furniture-living-room'), 'Mid-Century Armchair', 'mid-century-armchair', 'FURN-CHAIR-GRY', 499.99, 15, 'Stylish mid-century modern armchair', 'https://example.com/images/armchair.jpg'),
((SELECT id FROM categories WHERE slug = 'home-garden-furniture-bedroom'), 'Queen Platform Bed', 'queen-platform-bed', 'FURN-BED-Q-WAL', 799.99, 8, 'Modern platform bed with walnut finish', 'https://example.com/images/platform-bed.jpg'),
((SELECT id FROM categories WHERE slug = 'home-garden-furniture-office'), 'Ergonomic Office Chair', 'ergonomic-office-chair', 'FURN-CHAIR-ERG', 299.99, 20, 'Adjustable office chair with lumbar support', 'https://example.com/images/office-chair.jpg'),
((SELECT id FROM categories WHERE slug = 'home-garden-furniture-outdoor'), 'Patio Dining Set', 'patio-dining-set', 'FURN-PATIO-6PC', 899.99, 5, '6-piece weather-resistant dining set', 'https://example.com/images/patio-set.jpg');

-- Insert products for Books & Media > Books
INSERT INTO products (category_id, name, slug, sku, price, quantity, description, image_url) VALUES
((SELECT id FROM categories WHERE slug = 'books-media-books-fiction'), 'The Midnight Library', 'the-midnight-library', 'BOOK-MID-LIB-HC', 24.99, 75, 'Matt Haig''s bestselling novel about infinite possibilities', 'https://example.com/images/midnight-library.jpg'),
((SELECT id FROM categories WHERE slug = 'books-media-books-fiction'), 'Project Hail Mary', 'project-hail-mary', 'BOOK-PHM-HC', 26.99, 60, 'Andy Weir''s latest sci-fi adventure', 'https://example.com/images/hail-mary.jpg'),
((SELECT id FROM categories WHERE slug = 'books-media-books-non-fiction'), 'Atomic Habits', 'atomic-habits', 'BOOK-ATOM-HAB-PB', 18.99, 100, 'James Clear''s guide to building good habits', 'https://example.com/images/atomic-habits.jpg'),
((SELECT id FROM categories WHERE slug = 'books-media-books-non-fiction'), 'Think Again', 'think-again', 'BOOK-THK-AGN-HC', 27.99, 45, 'Adam Grant''s book on the power of rethinking', 'https://example.com/images/think-again.jpg'),
((SELECT id FROM categories WHERE slug = 'books-media-books-children'), 'The Very Hungry Caterpillar', 'the-very-hungry-caterpillar', 'BOOK-VHC-HC', 19.99, 85, 'Eric Carle''s beloved children''s classic', 'https://example.com/images/hungry-caterpillar.jpg');

-- Insert products for Sports & Outdoors > Team Sports
INSERT INTO products (category_id, name, slug, sku, price, quantity, description, image_url) VALUES
((SELECT id FROM categories WHERE slug = 'sports-outdoors-team-sports-soccer'), 'Professional Soccer Ball', 'professional-soccer-ball', 'SPRT-SOC-PRO', 29.99, 100, 'FIFA-approved professional soccer ball', 'https://example.com/images/soccer-ball.jpg'),
((SELECT id FROM categories WHERE slug = 'sports-outdoors-team-sports-soccer'), 'Soccer Cleats Elite', 'soccer-cleats-elite', 'SPRT-SOC-CLT', 89.99, 45, 'Professional-grade soccer cleats', 'https://example.com/images/soccer-cleats.jpg'),
((SELECT id FROM categories WHERE slug = 'sports-outdoors-team-sports-basketball'), 'Indoor Basketball', 'indoor-basketball', 'SPRT-BSK-IND', 39.99, 75, 'Official size indoor basketball', 'https://example.com/images/basketball.jpg'),
((SELECT id FROM categories WHERE slug = 'sports-outdoors-team-sports-baseball'), 'Baseball Glove Pro', 'baseball-glove-pro', 'SPRT-BSB-GLV', 79.99, 30, 'Professional leather baseball glove', 'https://example.com/images/baseball-glove.jpg'),
((SELECT id FROM categories WHERE slug = 'sports-outdoors-team-sports-football'), 'Official NFL Football', 'official-nfl-football', 'SPRT-NFL-OFF', 59.99, 40, 'Official size NFL football', 'https://example.com/images/football.jpg');

-- Insert products for Beauty & Health > Makeup
INSERT INTO products (category_id, name, slug, sku, price, quantity, description, image_url) VALUES
((SELECT id FROM categories WHERE slug = 'beauty-health-makeup-face'), 'Liquid Foundation SPF 30', 'liquid-foundation-spf-30', 'MKUP-FND-N20', 39.99, 85, 'Long-wearing foundation with sun protection', 'https://example.com/images/foundation.jpg'),
((SELECT id FROM categories WHERE slug = 'beauty-health-makeup-face'), 'Setting Powder Translucent', 'setting-powder-translucent', 'MKUP-PWD-TR', 29.99, 70, 'Lightweight setting powder for all skin types', 'https://example.com/images/setting-powder.jpg'),
((SELECT id FROM categories WHERE slug = 'beauty-health-makeup-eyes'), 'Eyeshadow Palette Natural', 'eyeshadow-palette-natural', 'MKUP-EYE-NAT', 45.99, 55, '12-color neutral eyeshadow palette', 'https://example.com/images/eyeshadow.jpg'),
((SELECT id FROM categories WHERE slug = 'beauty-health-makeup-lips'), 'Matte Lipstick Red', 'matte-lipstick-red', 'MKUP-LIP-RED', 19.99, 90, 'Long-lasting matte red lipstick', 'https://example.com/images/lipstick.jpg'),
((SELECT id FROM categories WHERE slug = 'beauty-health-makeup-nails'), 'Gel Nail Polish Set', 'gel-nail-polish-set', 'MKUP-NPL-SET', 34.99, 40, '6-color gel nail polish collection', 'https://example.com/images/nail-polish.jpg');

-- Insert products for Art & Crafts > Drawing
INSERT INTO products (category_id, name, slug, sku, price, quantity, description, image_url) VALUES
((SELECT id FROM categories WHERE slug = 'art-crafts-drawing-pencils'), 'Professional Graphite Set', 'professional-graphite-set', 'ART-PNC-PRO', 24.99, 60, '12-piece professional graphite pencil set', 'https://example.com/images/graphite-set.jpg'),
((SELECT id FROM categories WHERE slug = 'art-crafts-drawing-pencils'), 'Colored Pencils Artist Grade', 'colored-pencils-artist-grade', 'ART-PNC-COL', 49.99, 45, '36-color artist-grade colored pencils', 'https://example.com/images/colored-pencils.jpg'),
((SELECT id FROM categories WHERE slug = 'art-crafts-drawing-paper'), 'Sketch Pad A4 Premium', 'sketch-pad-a4-premium', 'ART-PAP-A4', 15.99, 100, '100-sheet premium sketching paper', 'https://example.com/images/sketch-pad.jpg'),
((SELECT id FROM categories WHERE slug = 'art-crafts-drawing-markers'), 'Dual Tip Markers Set', 'dual-tip-markers-set', 'ART-MRK-DUAL', 39.99, 50, '24-color dual tip art markers', 'https://example.com/images/markers.jpg'),
((SELECT id FROM categories WHERE slug = 'art-crafts-drawing-accessories'), 'Artist Pencil Case', 'artist-pencil-case', 'ART-ACC-CASE', 19.99, 75, 'Professional canvas pencil case', 'https://example.com/images/pencil-case.jpg');

-- Insert products for Food & Beverages > Groceries
INSERT INTO products (category_id, name, slug, sku, price, quantity, description, image_url) VALUES
((SELECT id FROM categories WHERE slug = 'food-beverages-groceries-produce'), 'Organic Banana Bundle', 'organic-banana-bundle', 'FOOD-BAN-ORG', 4.99, 200, 'Bunch of organic bananas', 'https://example.com/images/bananas.jpg'),
((SELECT id FROM categories WHERE slug = 'food-beverages-groceries-produce'), 'Fresh Avocados Pack', 'fresh-avocados-pack', 'FOOD-AVO-4PK', 6.99, 150, 'Pack of 4 ripe avocados', 'https://example.com/images/avocados.jpg'),
((SELECT id FROM categories WHERE slug = 'food-beverages-groceries-meat'), 'Premium Ground Beef', 'premium-ground-beef', 'FOOD-BEEF-1LB', 8.99, 100, '1lb premium ground beef', 'https://example.com/images/ground-beef.jpg'),
((SELECT id FROM categories WHERE slug = 'food-beverages-groceries-dairy'), 'Organic Whole Milk', 'organic-whole-milk', 'FOOD-MILK-GAL', 5.99, 80, '1 gallon organic whole milk', 'https://example.com/images/milk.jpg'),
((SELECT id FROM categories WHERE slug = 'food-beverages-groceries-pantry'), 'Extra Virgin Olive Oil', 'extra-virgin-olive-oil', 'FOOD-OIL-500', 12.99, 120, '500ml extra virgin olive oil', 'https://example.com/images/olive-oil.jpg');

-- Insert products for Automotive > Parts
INSERT INTO products (category_id, name, slug, sku, price, quantity, description, image_url) VALUES
((SELECT id FROM categories WHERE slug = 'automotive-parts-engine'), 'Oil Filter Premium', 'oil-filter-premium', 'AUTO-FLT-OIL', 12.99, 200, 'High-quality engine oil filter', 'https://example.com/images/oil-filter.jpg'),
((SELECT id FROM categories WHERE slug = 'automotive-parts-engine'), 'Spark Plug Set', 'spark-plug-set', 'AUTO-SPK-4PC', 24.99, 150, 'Set of 4 iridium spark plugs', 'https://example.com/images/spark-plugs.jpg'),
((SELECT id FROM categories WHERE slug = 'automotive-parts-brakes'), 'Brake Pad Set Front', 'brake-pad-set-front', 'AUTO-BRK-FRT', 49.99, 80, 'Front ceramic brake pad set', 'https://example.com/images/brake-pads.jpg'),
((SELECT id FROM categories WHERE slug = 'automotive-parts-electrical'), 'Car Battery 12V', 'car-battery-12v', 'AUTO-BAT-12V', 129.99, 40, '12V automotive battery with 3-year warranty', 'https://example.com/images/car-battery.jpg'),
((SELECT id FROM categories WHERE slug = 'automotive-parts-suspension'), 'Shock Absorber Pair', 'shock-absorber-pair', 'AUTO-SHK-PR', 89.99, 30, 'Pair of front shock absorbers', 'https://example.com/images/shock-absorbers.jpg');

-- Insert products for Toys & Games > Board Games and Video Games
INSERT INTO products (category_id, name, slug, sku, price, quantity, description, image_url) VALUES
((SELECT id FROM categories WHERE slug = 'toys-games-board-games-strategy'), 'Chess Set Deluxe', 'chess-set-deluxe', 'GAME-CHS-DLX', 49.99, 35, 'Wooden chess set with storage', 'https://example.com/images/chess-set.jpg'),
((SELECT id FROM categories WHERE slug = 'toys-games-board-games-strategy'), 'Settlers of Catan', 'settlers-of-catan', 'GAME-CTN-BASE', 44.99, 50, 'Classic strategy board game', 'https://example.com/images/catan.jpg'),
((SELECT id FROM categories WHERE slug = 'toys-games-board-games-family'), 'Monopoly Classic', 'monopoly-classic', 'GAME-MNP-CLS', 29.99, 75, 'Classic Monopoly board game', 'https://example.com/images/monopoly.jpg'),
((SELECT id FROM categories WHERE slug = 'toys-games-board-games-party'), 'Jenga Classic', 'jenga-classic', 'GAME-JNG-CLS', 19.99, 60, 'Classic wooden block stacking game', 'https://example.com/images/jenga.jpg'),
((SELECT id FROM categories WHERE slug = 'toys-games-board-games-cards'), 'Uno Card Game', 'uno-card-game', 'GAME-UNO-STD', 9.99, 100, 'Classic Uno card game', 'https://example.com/images/uno.jpg'),
((SELECT id FROM categories WHERE slug = 'toys-games-video-games'), 'PlayStation 5 Console', 'playstation-5-console', 'GAME-PS5-DISC', 499.99, 25, 'Sony PlayStation 5 gaming console', 'https://example.com/images/ps5.jpg'),
((SELECT id FROM categories WHERE slug = 'toys-games-video-games'), 'Xbox Series X', 'xbox-series-x', 'GAME-XBX-1TB', 499.99, 20, 'Microsoft Xbox Series X gaming console', 'https://example.com/images/xbox-series-x.jpg'),
((SELECT id FROM categories WHERE slug = 'toys-games-video-games'), 'Nintendo Switch OLED', 'nintendo-switch-oled', 'GAME-NSW-OLED', 349.99, 30, 'Nintendo Switch OLED Model', 'https://example.com/images/switch-oled.jpg'),
((SELECT id FROM categories WHERE slug = 'toys-games-video-games'), 'DualSense Controller', 'dualsense-controller', 'GAME-PS5-CTRL', 69.99, 50, 'PS5 DualSense wireless controller', 'https://example.com/images/dualsense.jpg'),
((SELECT id FROM categories WHERE slug = 'toys-games-video-games'), 'The Legend of Zelda', 'legend-of-zelda-totk', 'GAME-NSW-ZLDA', 59.99, 100, 'The Legend of Zelda: Tears of the Kingdom', 'https://example.com/images/zelda.jpg'); 