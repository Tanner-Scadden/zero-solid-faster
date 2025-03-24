import { zero } from "@src/zero";
import { onMount } from "solid-js";
import { createStore } from "solid-js/store";

type CartStore = {
  orderId: string;
};

const [cartStore, setCartStore] = createStore<CartStore>({
  orderId: localStorage.getItem("orderId") ?? "",
});

export const initializeCart = () => {
  console.log("INITIALIZING CART");

  const orderId = crypto.randomUUID();
  setCartStore("orderId", orderId);
  localStorage.setItem("orderId", orderId);

  console.log("Attempting to insert order:", {
    id: orderId,
    status: "cart",
    createdAt: Date.now(),
    updatedAt: Date.now(),
  });

  zero.mutate.orders.insert({
    id: orderId,
    status: "cart",
    createdAt: Date.now(),
    updatedAt: Date.now(),
  });
};

onMount(() => {
  if (cartStore.orderId) {
    console.log("CART ALREADY EXISTS");
    return;
  }
  initializeCart();
});

export const useCartStore = () => {
  return {
    orderId: cartStore.orderId,
  };
};
