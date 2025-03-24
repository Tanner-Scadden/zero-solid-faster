import { Outlet, createRootRoute } from "@tanstack/solid-router";
import { TanStackRouterDevtools } from "@tanstack/solid-router-devtools";
import { CategoryDrawer } from "./-components/category-drawer";

export const Route = createRootRoute({
  component: () => (
    <>
      <div class="sticky top-0 bg-white border-b px-3 py-2 flex items-center justify-between border-blue-500">
        <h1 class="text-4xl font-bold text-blue-500">ZeroFaster</h1>
        <input
          type="text"
          class="border border-gray-300 rounded-md p-2 w-64"
          placeholder="Search..."
        />
        <button class="bg-blue-500 text-white rounded-md p-2" type="button">
          Login
        </button>
      </div>
      <div class="flex">
        <CategoryDrawer />
        <div class="w-[calc(100%-12rem)]">
          <Outlet />
        </div>
      </div>
      <TanStackRouterDevtools />
    </>
  ),
});
