import { useQuery } from "@rocicorp/zero/solid";
import { ADJUST_ITEM_QUANTITY, CART_QUERY } from "@src/zero/cart-queries";

export function ManageQuantityButtons({ productId }: { productId: string }) {
  const [cartData] = useQuery(() => CART_QUERY());

  const existingQuantity = () =>
    cartData()?.items.find((item) => item.productId === productId)?.quantity ?? 0;

  return (
    <div class="flex flex-col">
      <button
        type="button"
        class="rounded-sm p-1 border-blue-300 border hover:border-blue-500 cursor-pointer h-6 w-6 flex items-center justify-center text-sm"
        onClick={() => ADJUST_ITEM_QUANTITY({ productId, quantity: existingQuantity() - 1 })}
      >
        -
      </button>
      <button
        type="button"
        class="rounded-sm p-1 border-blue-300 border hover:border-blue-500 cursor-pointer h-6 w-6 flex items-center justify-center text-sm"
        onClick={() => ADJUST_ITEM_QUANTITY({ productId, quantity: existingQuantity() + 1 })}
      >
        +
      </button>
    </div>
  );
}
