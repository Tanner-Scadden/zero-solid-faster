import { zero } from "./index";

export const PRODUCT_QUERY = (productSlug: string) =>
  zero.query.products
    .where("slug", "=", productSlug)
    .related("category", (productCategory) =>
      productCategory.related("parentCategory", (parentCategory) =>
        parentCategory
          .related("subCategories", (subCategories) =>
            subCategories.related("products", (products) =>
              products.where("slug", "!=", productSlug).limit(25)
            )
          )
          .limit(5)
      )
    )
    .one();

export const PRODUCT_INVENTORY_QUERY = ({
  productId,
  productSlug,
}: { productId?: string; productSlug?: string }) =>
  zero.query.products
    .where(productId ? "id" : "slug", "=", productId ?? productSlug ?? "")
    .related("orderedItems")
    .one();

export const PRODUCT_SEARCH_QUERY = (search: string) =>
  zero.query.products.where(({ or, cmp }) => or(cmp("name", "ILIKE", `%${search}%`))).limit(25);

export const CART_QUERY = (productIds: string[]) =>
  zero.query.products.where("id", "IN", productIds);
