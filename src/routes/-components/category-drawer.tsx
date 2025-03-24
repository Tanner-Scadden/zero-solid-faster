import { useQuery } from "@rocicorp/zero/solid";
import { zero } from "@src/zero";
import { Link } from "@tanstack/solid-router";
import { For } from "solid-js";

import { CATEGORY_QUERY } from "@src/zero/category-queries";

export const CategoryDrawer = () => {
  const [categories] = useQuery(() => zero.query.categories.where("parentId", "IS", null), {
    ttl: Infinity,
  });

  return (
    <div class="h-full min-h-[calc(100vh-59px)] border-r border-blue-500 w-48 px-2">
      <h2 class="py-2 text-lg underline">Categories</h2>
      <ul class="flex flex-col gap-0.5">
        <For each={categories()}>
          {(category) => (
            <li
              class="text-sm"
              onMouseEnter={() => {
                CATEGORY_QUERY(category.slug).preload({
                  ttl: 30,
                });
              }}
            >
              <Link
                to="/$category"
                params={{ category: category.slug }}
                class="[&.active]:text-blue-500 hover:border-b-2 border-blue-300 pb-0.5 hover:text-blue-500"
              >
                {category.name}
              </Link>
            </li>
          )}
        </For>
      </ul>
    </div>
  );
};
