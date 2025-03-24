import { useQuery } from "@rocicorp/zero/solid";
import { scrollToTop } from "@src/utils/scroll-to-top";
import { CATEGORY_PRELOAD_QUERY } from "@src/zero/category-queries";
import { Category } from "@src/zero/schema";
import { Link } from "@tanstack/solid-router";

export const CategoryPreview = (props: {
  splats: string[];
  category: Category;
  preload?: boolean;
}) => {
  useQuery(() => CATEGORY_PRELOAD_QUERY(`${props.splats.join("/")}/${props.category.slug}`), {
    ttl: 5,
  });

  return (
    <Link
      to="/categories/$"
      params={{ _splat: `${props.splats.join("/")}/${props.category.slug}` }}
      class="flex flex-col p-1 w-64 h-24 rounded-sm border border-blue-200 hover:border-blue-500 overflow-hidden gap-1"
      onClick={scrollToTop}
      onKeyDown={(e) => {
        if (e.key === "Enter") {
          scrollToTop();
        }
      }}
    >
      <h3>{props.category.name}</h3>
      <p>{props.category.description}</p>
    </Link>
  );
};
