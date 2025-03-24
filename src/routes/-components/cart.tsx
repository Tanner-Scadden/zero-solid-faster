import { useQuery } from "@rocicorp/zero/solid";
import { CartIcon } from "@src/common/icons/cart-icon";
import { CART_QUERY } from "@src/zero/cart-queries";
import { Link } from "@tanstack/solid-router";
import { Show } from "solid-js";

export const Cart = () => {
  const [cartData] = useQuery(() => CART_QUERY());

  const totalItems = () => cartData()?.items.reduce((acc, item) => acc + item.quantity, 0) ?? 0;

  return (
    <Link class="flex items-center gap-1" to="/checkout">
      <Show when={totalItems()} fallback={<p>Empty</p>}>
        <p>{totalItems()}</p>
      </Show>
      <CartIcon />
    </Link>
  );
};
