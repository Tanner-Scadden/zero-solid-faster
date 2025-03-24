import { For, Show, createSignal, onCleanup, onMount } from "solid-js";

import { useQuery } from "@rocicorp/zero/solid";
import { PRODUCT_SEARCH_QUERY } from "@src/zero/product-queries";
import { ProductPreview } from "./product-preview";

export const ProductSearch = () => {
  const [search, setSearch] = createSignal("");
  const [debouncedSearch, setDebouncedSearch] = createSignal("");
  let searchTimeout: ReturnType<typeof setTimeout>;

  const handleSearch = (value: string) => {
    setSearch(value);
    clearTimeout(searchTimeout);
    searchTimeout = setTimeout(() => {
      setDebouncedSearch(value);
    }, 100);
  };

  onCleanup(() => {
    clearTimeout(searchTimeout);
  });

  const [products] = useQuery(() => PRODUCT_SEARCH_QUERY(debouncedSearch()));

  const abortController = new AbortController();

  onMount(() => {
    const handleKeyDown = (e: KeyboardEvent) => {
      // Check for Command+K or Command+F
      if ((e.metaKey || e.ctrlKey) && e.key === "k") {
        e.preventDefault(); // Prevent browser's default find behavior
        const input = document.getElementById("product-search-input") as HTMLInputElement;
        if (input) {
          input.focus();
          input.select(); // Select any existing text
        }
      }
    };

    window.addEventListener("keydown", handleKeyDown, {
      signal: abortController.signal,
    });

    onCleanup(() => {
      abortController.abort();
    });
  });

  return (
    <div class="relative w-64 sm:w-96 md:w-[400px]">
      <input
        type="text"
        value={search()}
        onInput={(e) => handleSearch(e.target.value)}
        placeholder="(⌘K) to search..."
        class="w-full p-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
        id="product-search-input"
      />
      <Show when={search().length}>
        <div class="absolute top-full left-0 right-0 mt-1 bg-white border border-gray-200 rounded-md shadow-lg z-50 max-h-[30vh] overflow-y-auto">
          <Show when={!products()?.length}>
            <div class="p-2">No results found</div>
          </Show>
          <For each={products()}>
            {(product) => {
              return (
                <div
                  class="p-2 hover:bg-gray-50"
                  onClick={() => setSearch("")}
                  onKeyDown={(e) => {
                    if (e.key === "Enter") {
                      setSearch("");
                    }
                  }}
                >
                  <ProductPreview product={product} isPreview />
                </div>
              );
            }}
          </For>
        </div>
      </Show>
    </div>
  );
};
