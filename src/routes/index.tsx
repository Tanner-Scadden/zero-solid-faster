import { useQuery } from "@rocicorp/zero/solid";
import { PRIMARY_CATEGORIES_QUERY } from "@src/zero/category-queries";
import { createFileRoute } from "@tanstack/solid-router";
import { CategoryDisplay } from "../common/category-display";

export const Route = createFileRoute("/")({
  component: Index,
});

function Index() {
  const [categories] = useQuery(PRIMARY_CATEGORIES_QUERY);

  return <CategoryDisplay slugs={[categories()?.[0]?.slug ?? ""]} />;
}
