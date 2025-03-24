import { useQuery } from "@rocicorp/zero/solid";
import { ADJUST_ITEM_QUANTITY, CART_QUERY } from "@src/zero/cart-queries";
import { PRODUCT_INVENTORY_QUERY } from "@src/zero/product-queries";

export function ManageQuantityButtons(props: { productId: string }) {
  const [cartData] = useQuery(() => CART_QUERY());

  const [inventory] = useQuery(() => PRODUCT_INVENTORY_QUERY({ productId: props.productId }));

  const quantityAvailable = () => {
    console.log(inventory(), props.productId);
    return Math.max(
      0,
      (inventory()?.quantity ?? 0) -
        (inventory()?.orderedItems.reduce((acc, item) => acc + item.quantity, 0) ?? 0)
    );
  };

  const quantityInCart = () =>
    cartData()?.items.find((item) => item.productId === props.productId)?.quantity ?? 0;

  return (
    <div class="flex flex-col">
      <button
        type="button"
        class="rounded-sm p-1 border-blue-300 border hover:border-blue-500 cursor-pointer h-6 w-6 flex items-center justify-center text-sm"
        onClick={() =>
          ADJUST_ITEM_QUANTITY({ productId: props.productId, quantity: quantityInCart() - 1 })
        }
      >
        -
      </button>
      <button
        type="button"
        class="rounded-sm p-1 border-blue-300 border hover:border-blue-500 cursor-pointer h-6 w-6 flex items-center justify-center text-sm disabled:opacity-50 disabled:cursor-not-allowed disabled:hover:border-blue-300"
        onClick={() =>
          ADJUST_ITEM_QUANTITY({ productId: props.productId, quantity: quantityInCart() + 1 })
        }
        disabled={quantityAvailable() <= 0}
      >
        +
      </button>
    </div>
  );
}
