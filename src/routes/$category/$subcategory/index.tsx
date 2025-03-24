import { createFileRoute } from "@tanstack/solid-router";

export const Route = createFileRoute("/$category/$subCategory/")({
  component: RouteComponent,
});

function RouteComponent() {
  return <div>Hello "/$category/$subcategory/"!</div>;
}
