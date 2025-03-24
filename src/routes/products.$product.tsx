import { useQuery } from "@rocicorp/zero/solid";
import { Meta, Title } from "@solidjs/meta";
import { CategoryPreview } from "@src/common/category-preview";
import { ProductPreview } from "@src/common/product-preview";
import { PRODUCT_QUERY } from "@src/zero/product-queries";
import { createFileRoute } from "@tanstack/solid-router";
import { createVirtualizer } from "@tanstack/solid-virtual";
import { For, Show } from "solid-js";

export const Route = createFileRoute("/products/$product")({
  component: RouteComponent,
  loader: async ({ params }) => {
    PRODUCT_QUERY(params.product).preload({
      ttl: 30,
    });
  },
});

function RouteComponent() {
  const param = Route.useParams();
  const [product] = useQuery(() => PRODUCT_QUERY(param().product));

  const relatedProducts = () => {
    const category = product()?.category;
    if (!category) return [];
    return (
      category.parentCategory?.subCategories.flatMap((subCategory) => subCategory.products) || []
    );
  };

  const relatedCategories = () => {
    const category = product()?.category;
    if (!category) return [];
    return category.parentCategory?.subCategories
      .flatMap((subCategory) => subCategory)
      .sort(() => Math.random() - 0.5);
  };

  const rowVirtualizer = createVirtualizer({
    count: relatedProducts().length,
    getScrollElement: () => document.getElementById("related-products"),
    estimateSize: () => 6 * 10,
    overscan: 200,
  });

  return (
    <div class="flex flex-col gap-2">
      <Title>{product()?.name} | Zero Tanstack Faster</Title>
      <Meta name="description" content={product()?.description ?? ""} />
      <Meta property="og:title" content={product()?.name ?? ""} />
      <Meta property="og:description" content={product()?.description ?? ""} />
      <Meta property="og:image" content={product()?.imageUrl ?? ""} />
      <Meta property="og:type" content="product" />
      <h2>{product()?.name}</h2>
      <div class="flex">
        <img src={product()?.imageUrl ?? ""} alt={product()?.name ?? ""} width={300} height={400} />
      </div>
      <p>{product()?.description}</p>
      <hr />
      <div class="flex flex-col gap-2">
        <h6 class="text-lg font-bold">Similar categories</h6>
        <div class="flex flex-wrap gap-2">
          <For each={relatedCategories()}>
            {(category) => <CategoryPreview splats={[]} category={category} />}
          </For>
        </div>
      </div>
      <hr />
      <div class="flex flex-col gap-2" id="related-products">
        <h6 class="text-lg font-bold">You might also like</h6>
        <div class="flex flex-wrap gap-2">
          <For each={rowVirtualizer.getVirtualItems()}>
            {(item) => (
              <Show when={relatedProducts()[item.index]}>
                <ProductPreview product={relatedProducts()[item.index]} preload />
              </Show>
            )}
          </For>
        </div>
      </div>
    </div>
  );
}
