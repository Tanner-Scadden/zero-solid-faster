import { zero } from "@src/zero";
import { onMount } from "solid-js";
import { createStore } from "solid-js/store";

type CartStore = {
  orderId: string;
};

const [cartStore, setCartStore] = createStore<CartStore>({
  orderId: localStorage.getItem("orderId") ?? "",
});

onMount(async () => {
  if (cartStore.orderId) {
    console.log("CART ALREADY EXISTS");
    return;
  }

  console.log("INITIALIZING CART");

  const orderId = crypto.randomUUID();
  setCartStore("orderId", orderId);
  localStorage.setItem("orderId", orderId);

  console.log("Attempting to insert order:", {
    id: orderId,
    userId: null,
    status: "cart",
    createdAt: Date.now(),
    updatedAt: Date.now(),
  });

  const result = await zero.mutate.orders.insert({
    id: orderId,
    userId: null,
    status: "cart",
    createdAt: Date.now(),
    updatedAt: Date.now(),
  });

  console.log("Order inserted:", result);
});

export const useCartStore = () => {
  return {
    orderId: cartStore.orderId,
  };
};
