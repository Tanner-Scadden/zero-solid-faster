import { useQuery } from "@rocicorp/zero/solid";
import { Meta, Title } from "@solidjs/meta";
import { CategoryPreview } from "@src/common/category-preview";
import { ProductPreview } from "@src/common/product-preview";
import { CATEGORY_QUERY } from "@src/zero/category-queries";
import { Product } from "@src/zero/schema";
import { Link } from "@tanstack/solid-router";
import { createVirtualizer } from "@tanstack/solid-virtual";
import { For, Show } from "solid-js";

const CategoryProducts = (props: { products: Product[] }) => {
  const rowVirtualizer = createVirtualizer({
    count: props.products.length,
    getScrollElement: () => document.getElementById("category-products"),
    estimateSize: () => 6 * 10,
    overscan: 200,
  });

  return (
    <>
      <h3 class="text-lg font-bold">Products</h3>
      <div
        class="flex flex-wrap justify-between gap-2 border-b-2 border-blue-500 pb-2"
        id="category-products"
      >
        <For each={rowVirtualizer.getVirtualItems()}>
          {(item) => {
            const product = () => props.products[item.index];
            if (!product()) return null;
            return <ProductPreview product={product()!} preload />;
          }}
        </For>
      </div>
    </>
  );
};

export const CategoryDisplay = (props: { slugs: string[] }) => {
  const [category] = useQuery(() => CATEGORY_QUERY(props.slugs.at(-1) ?? ""));

  return (
    <div class="flex flex-col gap-2">
      <Title>{category()?.name} | Zero Tanstack Faster</Title>
      <Meta name="description" content={category()?.description ?? ""} />
      <Meta property="og:title" content={category()?.name ?? ""} />
      <Meta property="og:description" content={category()?.description ?? ""} />
      <Meta property="og:type" content="website" />
      <Show when={props.slugs.length > 1}>
        <Link
          to="/categories/$"
          params={{ _splat: props.slugs.slice(0, -1).join("/") }}
          class="text-blue-300 hover:text-blue-500"
        >
          Go back to {props.slugs.at(-2)}
        </Link>
      </Show>
      <h2 class="text-2xl font-bold">{category()?.name}</h2>
      <div class="flex flex-col gap-2">
        <Show when={category()?.subCategories.length}>
          <h3 class="text-lg font-bold">Subcategories</h3>
          <div class="flex flex-wrap gap-2 border-b-2 border-blue-500 pb-2">
            <For each={category()?.subCategories}>
              {(subCategory) => (
                <CategoryPreview splats={props.slugs} category={subCategory} preload />
              )}
            </For>
          </div>
        </Show>
        <Show when={category()?.products.length}>
          <CategoryProducts products={category()!.products as Product[]} />
        </Show>
      </div>
    </div>
  );
};
