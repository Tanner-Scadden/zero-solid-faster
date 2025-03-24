import { useQuery } from "@rocicorp/zero/solid";
import { Meta, Title } from "@solidjs/meta";
import { CategoryPreview } from "@src/common/category-preview";
import { ManageQuantityButtons } from "@src/common/manage-quantity-buttons";
import { ProductPreview } from "@src/common/product-preview";
import { ADD_ITEM_TO_CART, CART_QUERY } from "@src/zero/cart-queries";
import { PRODUCT_QUERY } from "@src/zero/product-queries";
import { Link, createFileRoute } from "@tanstack/solid-router";
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
  const [cartData] = useQuery(() => CART_QUERY());

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
      <Show when={product()}>
        {(product) => (
          <>
            <Title>{product().name} | Zero Tanstack Faster</Title>
            <Meta name="description" content={product().description ?? ""} />
            <Meta property="og:title" content={product().name ?? ""} />
            <Meta property="og:description" content={product().description ?? ""} />
            <Meta property="og:image" content={product().imageUrl ?? ""} />
            <Meta property="og:type" content="product" />
            <div class="flex no-wrap justify-between">
              <div class="flex w-1/3">
                <img
                  src={product().imageUrl ?? ""}
                  alt={product().name ?? ""}
                  width={300}
                  height={400}
                />
              </div>
              <div class="flex flex-col gap-2 w-2/3 pl-3">
                <h2>{product().name}</h2>
                <p>${product().price}</p>
                <p>
                  <Show
                    when={(product().quantity || 0) <= 5}
                    fallback={`${product().quantity} in stock`}
                  >
                    Only {product().quantity} left!
                  </Show>
                </p>
                <Show
                  when={!cartData()?.items.find((item) => item.productId === product().id)}
                  fallback={
                    <div class="flex items-center gap-2">
                      <p>
                        {
                          cartData()?.items.find((item) => item.productId === product().id)
                            ?.quantity
                        }{" "}
                        in{" "}
                        <Link to="/cart" class="hover:text-blue-500">
                          cart
                        </Link>
                      </p>
                      <ManageQuantityButtons productId={product().id} />
                    </div>
                  }
                >
                  <button
                    type="button"
                    class="rounded-sm py-1 max-w-36 border-blue-300 border hover:border-blue-500 cursor-pointer"
                    onClick={() =>
                      ADD_ITEM_TO_CART({
                        productId: product().id,
                        quantity: 1,
                        unitPrice: product().price,
                      })
                    }
                  >
                    Add to cart
                  </button>
                </Show>
                <p>{product()?.description}</p>
              </div>
            </div>
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
          </>
        )}
      </Show>
    </div>
  );
}
