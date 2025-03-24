import { useQuery } from "@rocicorp/zero/solid";
import { ManageQuantityButtons } from "@src/common/manage-quantity-buttons";
import { CART_QUERY } from "@src/zero/cart-queries";
import { Link, createFileRoute } from "@tanstack/solid-router";
import { For } from "solid-js";

export const Route = createFileRoute("/cart")({
  component: RouteComponent,
  loader: () => {
    CART_QUERY().preload();
  },
});

function RouteComponent() {
  const [cartData] = useQuery(() => CART_QUERY());

  return (
    <div>
      <h1>Cart</h1>
      <div class="flex flex-col gap-4">
        <For each={cartData()?.items}>
          {(orderItem) => {
            const quantity = () => orderItem?.quantity ?? 0;

            return (
              <>
                <div class="flex items-center justify-between">
                  <Link
                    to="/products/$product"
                    params={{ product: orderItem.product!.slug }}
                    class="hover:text-blue-500"
                  >
                    {orderItem.product!.name}
                  </Link>
                  <div class="flex items-center gap-2">
                    <p>{quantity()}</p>
                    <ManageQuantityButtons productId={orderItem.productId} />
                  </div>
                </div>
                <hr />
              </>
            );
          }}
        </For>
      </div>
    </div>
  );
}
