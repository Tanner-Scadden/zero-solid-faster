import { createFileRoute } from '@tanstack/solid-router'

export const Route = createFileRoute('/$category/$subcategory/$product/')({
  component: RouteComponent,
})

function RouteComponent() {
  return <div>Hello "/$category/$subcategory/$product/"!</div>
}
