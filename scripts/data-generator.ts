import { faker } from "@faker-js/faker";
import type { Product } from "../src/zero/schema";

export const categoriesToGenerateFor = [
  "electronics-smartphones",
  "electronics-laptops",
  "electronics-tablets",
  "electronics-audio",
  "electronics-cameras",
  "fashion-mens-clothing",
  "fashion-womens-clothing",
  "fashion-kids-clothing",
  "fashion-shoes",
  "fashion-accessories",
  "home-garden-furniture",
  "home-garden-decor",
  "home-garden-kitchen",
  "home-garden-garden",
  "home-garden-lighting",
  "books-media-books",
  "books-media-movies",
  "books-media-music",
  "books-media-magazines",
  "books-media-educational",
  "sports-outdoors-team-sports",
  "sports-outdoors-fitness",
  "sports-outdoors-camping",
  "sports-outdoors-cycling",
  "sports-outdoors-water-sports",
  "beauty-health-makeup",
  "beauty-health-skincare",
  "beauty-health-hair-care",
  "beauty-health-personal-care",
  "beauty-health-health",
  "toys-games-board-games",
  "toys-games-video-games",
  "toys-games-educational",
  "toys-games-action-figures",
  "toys-games-puzzles",
  "food-beverages-groceries",
  "food-beverages-drinks",
  "food-beverages-snacks",
  "food-beverages-organic",
  "food-beverages-international",
  "automotive-parts",
  "automotive-accessories",
  "automotive-tools",
  "automotive-care",
  "automotive-electronics",
  "art-crafts-drawing",
  "art-crafts-painting",
  "art-crafts-crafting",
  "art-crafts-scrapbooking",
  "art-crafts-sewing",
];

/**
 * CamelToSnakeCase<S>:
 * - Recursively transforms a string type from camelCase to snake_case.
 * - e.g., "someProperty" -> "some_property"
 */
type CamelToSnakeCase<S extends string> = S extends `${infer First}${infer Rest}`
  ? First extends Capitalize<First>
    ? // If the character is uppercase, insert '_' before lowercasing it:
      `_${Lowercase<First>}${CamelToSnakeCase<Rest>}`
    : // Otherwise keep it as is and continue:
      `${First}${CamelToSnakeCase<Rest>}`
  : S;

/**
 * ConvertKeysToSnakeCase<T>:
 * - Recursively maps all the object's keys from camelCase to snake_case.
 * - Deeply applies the transformation to nested objects.
 */
type ConvertKeysToSnakeCase<T> = {
  [K in keyof T as CamelToSnakeCase<K & string>]: T[K] extends object
    ? ConvertKeysToSnakeCase<T[K]>
    : T[K];
};

type SeederProduct = Required<Omit<ConvertKeysToSnakeCase<Product>, "category_id">>;

const usedNames = new Map<string, number>();
const generateUniqueName = () => {
  const name = faker.commerce.productName();
  const count = usedNames.get(name) ?? 0;
  usedNames.set(name, count + 1);
  return `${name} ${count + 1}`;
};

const usedSkus = new Map<string, number>();
const generateUniqueSku = () => {
  const sku = `SKU-${faker.string.alphanumeric(12).toUpperCase()}`;
  const count = usedSkus.get(sku) ?? 0;
  usedSkus.set(sku, count + 1);
  return sku;
};

const generateProduct = () => {
  const id = faker.string.uuid();
  const name = generateUniqueName();
  return {
    id,
    name,
    description: faker.commerce.productDescription(),
    price: parseFloat(faker.commerce.price({ min: 1, max: 1000 })),
    image_url: faker.image.url({
      width: 250,
      height: 250,
    }),
    slug: name.toLowerCase().replace(/ /g, "-"),
    created_at: faker.date.past().getTime(),
    updated_at: faker.date.recent().getTime(),
    quantity: faker.number.int({ min: 0, max: 1000 }),
    sku: generateUniqueSku(),
  } satisfies SeederProduct;
};

const TOTAL_PRODUCTS = 1_000_000;
const BATCH_SIZE = 20_000;

const generateData = async () => {
  const productsPerCategory = Math.ceil(TOTAL_PRODUCTS / categoriesToGenerateFor.length);
  console.log(`Generating ${productsPerCategory} products per category...`);

  const products: SeederProduct[] = [];
  let count = 0;
  let loop = 0;
  for (const categorySlug of categoriesToGenerateFor) {
    console.log(`Generating products for category: ${categorySlug}`);

    for (let i = 0; i < productsPerCategory; i++) {
      products.push(generateProduct());
      count++;

      // When we reach the batch size or it's the last item, write to file
      if (products.length === BATCH_SIZE || count === TOTAL_PRODUCTS) {
        // Convert products to SQL insert statements with transaction
        const sqlStatements = `
BEGIN;
${products
  .map(
    (product) => `
          INSERT INTO products (
            id, name, description, price, category_id, 
            created_at, updated_at, quantity, sku, image_url, slug
          ) VALUES (
            '${product.id}',
            '${product.name.replace(/'/g, "''")}',
            '${product.description!.replace(/'/g, "''")}',
            ${product.price},
            (SELECT id FROM categories WHERE slug = '${categorySlug}'),
            '${new Date(product.created_at).toISOString()}',
            '${new Date(product.updated_at).toISOString()}',
            ${product.quantity},
            '${product.sku}',
            '${product.image_url}',
            '${product.slug}'
          );`
  )
  .join("\n")}
COMMIT;
        `;

        // Write to file
        await Bun.write(
          `docker/seeds/${100 + loop}_generated_products_${categorySlug.replace(/-/g, "_")}.sql`,
          sqlStatements
        );

        // Clear the products array for the next batch
        products.length = 0;
        loop++;
      }
    }
  }

  console.log(`Generated ${count} products total`);
};

// Run the generator
generateData().catch(console.error);
