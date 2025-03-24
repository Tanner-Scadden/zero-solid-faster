import { useQuery } from "@rocicorp/zero/solid";
import { initializeCart, useCartStore } from "@src/stores/cart-store";
import { zero } from ".";
import { OrderItem } from "./schema";

export const CART_QUERY = () => {
  const { orderId } = useCartStore();
  return zero.query.orders
    .where("id", "=", orderId)
    .related("items", (item) => item.related("product"))
    .one();
};

export const ADD_ITEM_TO_CART = (item: Omit<OrderItem, "orderId">) => {
  const { orderId } = useCartStore();
  const orderItem = {
    orderId,
    productId: item.productId,
    quantity: item.quantity,
    unitPrice: item.unitPrice,
  };
  console.log("ADDING ITEM TO CART", orderItem);
  return zero.mutate.order_items.insert(orderItem);
};

export const REMOVE_ITEM_FROM_CART = ({ productId }: Pick<OrderItem, "productId">) => {
  const { orderId } = useCartStore();
  console.log("REMOVING ITEM FROM CART", orderId, productId);
  return zero.mutate.order_items.delete({
    orderId,
    productId: productId,
  });
};

export const ADJUST_ITEM_QUANTITY = ({
  productId,
  quantity,
}: Pick<OrderItem, "productId" | "quantity">) => {
  const { orderId } = useCartStore();
  console.log("ADJUSTING ITEM QUANTITY", orderId, productId, quantity);
  if (quantity === 0) {
    return REMOVE_ITEM_FROM_CART({ productId });
  }

  return zero.mutate.order_items.update({
    orderId,
    productId: productId,
    quantity: quantity,
  });
};

export const CONFIRM_PURCHASE = () => {
  const { orderId } = useCartStore();
  zero.mutate.orders.update({
    id: orderId,
    status: "ordered",
  });
  initializeCart();
  setTimeout(() => {
    window.location.href = "/";
  }, 1000);
};

export const CLEAR_CART = () => {
  const { orderId } = useCartStore();
  zero.mutate.orders.delete({
    id: orderId,
  });
  initializeCart();
};
