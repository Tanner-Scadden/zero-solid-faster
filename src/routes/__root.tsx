import { Meta, Title } from "@solidjs/meta";
import { ExternalLink } from "@src/common/external-link";
import { ProductSearch } from "@src/common/product-search";
import { Link, Outlet, createRootRoute } from "@tanstack/solid-router";
import { TanStackRouterDevtools } from "@tanstack/solid-router-devtools";
import { AboutProjectBanner } from "./-components/about-project-banner";
import { Cart } from "./-components/cart";
import { CategoryDrawer } from "./-components/category-drawer";

export const Route = createRootRoute({
  component: () => (
    <>
      <Title>ZeroFaster</Title>
      <Meta name="description" content="ZeroFaster" />
      <Meta property="og:title" content="ZeroFaster" />
      <Meta property="og:description" content="ZeroFaster" />
      <Meta property="og:image" content="https://zero-tanstack-faster.railway.up.app/favicon.ico" />
      <Meta property="og:type" content="website" />
      <div class="sticky top-0 bg-white border-b px-3 py-2 flex items-center justify-between border-blue-500">
        <Link to="/" class="text-4xl font-bold text-blue-500">
          ZeroFaster
        </Link>
        <ProductSearch />
        <div class="flex items-center gap-2">
          <Cart />
        </div>
      </div>
      <div class="flex">
        <CategoryDrawer />
        <div
          class="w-[calc(100%-12rem)] p-3 pb-0 overflow-x-auto max-h-[calc(100vh-2rem)] relative"
          id="__content"
        >
          <Outlet />
        </div>
      </div>
      <div class="h-6 border-t border-blue-500 bg-white fixed bottom-0 left-[12rem] w-[calc(100%-15rem)] text-sm justify-center items-center flex">
        <ExternalLink href="https://github.com/Tanner-Scadden/zero-solid-faster">
          Check out the source code
        </ExternalLink>
      </div>
      <AboutProjectBanner />
      <TanStackRouterDevtools />
    </>
  ),
});
