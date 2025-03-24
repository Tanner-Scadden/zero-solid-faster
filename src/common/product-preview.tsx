import { useQuery } from "@rocicorp/zero/solid";
import { scrollToTop } from "@src/utils/scroll-to-top";
import { PRODUCT_QUERY } from "@src/zero/product-queries";
import { Product } from "@src/zero/schema";
import { Link } from "@tanstack/solid-router";
import { Show } from "solid-js";

export const ProductPreview = (props: {
  product: Product;
  preload?: boolean;
  isPreview?: boolean;
}) => {
  useQuery(() => PRODUCT_QUERY(props.product.slug), { ttl: 5 });

  return (
    <Link
      to="/products/$product"
      params={{ product: props.product.slug }}
      class={`flex gap-1 ${
        props.isPreview
          ? "w-full h-12"
          : "w-64 h-32 rounded-sm border border-blue-200 hover:border-blue-500 overflow-hidden"
      }`}
      onClick={scrollToTop}
      onKeyDown={(e) => {
        if (e.key === "Enter") {
          scrollToTop();
        }
      }}
    >
      <img
        src={props.product.imageUrl ?? ""}
        alt={props.product.name ?? ""}
        width={props.isPreview ? 25 : 100}
        height={props.isPreview ? 25 : 100}
        loading="eager"
      />
      <div class={`flex overflow-hidden ${props.isPreview ? "py-1" : "flex-col gap-1"}`}>
        <h3 class={props.isPreview ? "truncate" : ""}>{props.product.name}</h3>
        <Show when={!props.isPreview}>
          <p class="text-sm">${props.product.price}</p>
          <p class="text-sm truncate text-wrap">{props.product.description}</p>
        </Show>
      </div>
    </Link>
  );
};
