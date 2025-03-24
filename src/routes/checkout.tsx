import { useQuery } from "@rocicorp/zero/solid";
import { ManageQuantityButtons } from "@src/common/manage-quantity-buttons";
import { CART_QUERY, CLEAR_CART, CONFIRM_PURCHASE } from "@src/zero/cart-queries";
import { Link, createFileRoute } from "@tanstack/solid-router";
import { For } from "solid-js";

export const Route = createFileRoute("/checkout")({
  component: RouteComponent,
  loader: () => {
    CART_QUERY().preload();
  },
});

function RouteComponent() {
  const [cartData] = useQuery(() => CART_QUERY());

  const cartTotal = () => {
    return Number(
      cartData()?.items.reduce((acc, item) => acc + (item.unitPrice ?? 0) * (item.quantity ?? 0), 0)
    ).toFixed(2);
  };

  return (
    <div class="flex flex-col gap-4">
      <h1>Cart</h1>
      <div class="flex justify-end">
        <button
          onClick={CLEAR_CART}
          type="button"
          class="rounded-sm py-1 max-w-48 px-2  border-blue-300 border hover:border-blue-500 cursor-pointer"
        >
          Clear Cart
        </button>
      </div>
      <div class="flex flex-col gap-4">
        <For each={cartData()?.items}>
          {(orderItem) => {
            const quantity = () => orderItem?.quantity ?? 0;
            const sum = () => Number((orderItem?.unitPrice ?? 0) * quantity()).toFixed(2);

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
                    <p class="w-24 text-right">${sum()}</p>
                  </div>
                </div>
                <hr />
              </>
            );
          }}
        </For>
      </div>
      <div class="flex items-center justify-between">
        <p>Total</p>
        <p>${cartTotal()}</p>
      </div>
      <div class="flex justify-end">
        <button
          onClick={CONFIRM_PURCHASE}
          type="button"
          class="rounded-sm py-1 max-w-48 px-2 bg-blue-500 text-white border-blue-300 border hover:border-blue-500 cursor-pointer"
        >
          Confirm Purchase
        </button>
      </div>
    </div>
  );
}
