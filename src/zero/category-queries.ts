import { zero } from "./index";

export const CATEGORY_QUERY = (slug: string) =>
  zero.query.categories.where("slug", "=", slug).related("subCategories").one();
