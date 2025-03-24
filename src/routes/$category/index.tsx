import { useQuery } from "@rocicorp/zero/solid";
import { CATEGORY_QUERY } from "@src/zero/category-queries";
import { createFileRoute } from "@tanstack/solid-router";
import { For } from "solid-js";

export const Route = createFileRoute("/$category/")({
  component: RouteComponent,
  loader: async ({ params }) => {
    CATEGORY_QUERY(params.category).run();
  },
});

function RouteComponent() {
  const param = Route.useParams();

  const [category] = useQuery(() => CATEGORY_QUERY(param().category));
  return (
    <div class="flex flex-col gap-2">
      <h1 class="text-2xl font-bold">{category()?.name}</h1>
      <div class="flex flex-col gap-2">
        <For each={category()?.subCategories}>
          {(subCategory) => <div class="text-sm">{subCategory.name}</div>}
        </For>
      </div>
    </div>
  );
}
