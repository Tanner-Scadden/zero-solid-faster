import { zero } from "./index";

export const PRIMARY_CATEGORIES_QUERY = () => zero.query.categories.where("parentId", "IS", null);

export const CATEGORY_PRELOAD_QUERY = (slug: string) =>
  zero.query.categories
    .where("slug", "=", slug)
    .related("subCategories")
    .related("products", (products) => products.limit(100));

export const CATEGORY_QUERY = (slug: string) =>
  zero.query.categories
    .where("slug", "=", slug)
    .related("subCategories")
    .related("products", (products) => products.limit(1_000))
    .one();
