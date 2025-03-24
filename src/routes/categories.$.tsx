import { useQuery } from "@rocicorp/zero/solid";
import { CATEGORY_QUERY, PRIMARY_CATEGORIES_QUERY } from "@src/zero/category-queries";
import { createFileRoute } from "@tanstack/solid-router";
import { CategoryDisplay } from "../common/category-display";

export const Route = createFileRoute("/categories/$")({
  component: RouteComponent,
  loader: async ({ params }) => {
    const category = params._splat?.split("/")?.at(-1);
    PRIMARY_CATEGORIES_QUERY().preload();
    if (category) CATEGORY_QUERY(category).preload();
  },
});

function RouteComponent() {
  const param = Route.useParams();

  const [categories] = useQuery(PRIMARY_CATEGORIES_QUERY);

  const slugs = () => param()._splat?.split("/") ?? [categories()?.[0]?.slug ?? ""];

  return <CategoryDisplay slugs={slugs()} />;
}
