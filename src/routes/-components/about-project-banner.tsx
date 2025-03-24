import { ExternalLink } from "@src/common/external-link";
import { GitHubIcon } from "@src/common/icons/github-icon";
import { LinkedInIcon } from "@src/common/icons/linkedin-icon";
import { TwitterIcon } from "@src/common/icons/twitter-icon";
import { Show, createSignal } from "solid-js";

export const AboutProjectBanner = () => {
  const [isOpen, setIsOpen] = createSignal(true);
  return (
    <Show when={isOpen()}>
      <div class="fixed bottom-4 right-4 bg-gray-50 shadow-2x p-4 rounded-sm flex flex-col gap-2 text-sm w-96 border-blue-100 border">
        <div class="flex justify-between items-center">
          <p class="font-bold">
            Welcome to <span class="text-blue-500">ZeroFaster</span>
          </p>
          <button
            type="button"
            class="hover:border-blue-500 hover:border rounded-full p-2 w-4 h-4 flex items-center justify-center"
            onClick={() => setIsOpen(!isOpen())}
          >
            X
          </button>
        </div>
        <p class="text-xs">
          This project took inspiration from{" "}
          <ExternalLink href="https://next-faster.vercel.app/">NextFaster</ExternalLink>. After .
          After seeing their incredible work, I wanted to build something that pushed the boundaries
          of how fast a SPA could be, in a similar manner.{" "}
          <ExternalLink href="https://github.com/Tanner-Scadden/zero-solid-faster">
            Check out the source code
          </ExternalLink>
          .
        </p>
        <p class="text-xs">
          Shout out to the incredible work by the{" "}
          <ExternalLink href="https://tanstack.com">Tanstack</ExternalLink>,{" "}
          <ExternalLink href="https://zero.rocicorp.dev">Zero</ExternalLink>, and{" "}
          <ExternalLink href="https://solidjs.com">SolidJS</ExternalLink> teams!
        </p>
        <hr />
        <div class="flex items-center gap-2">
          <p>Created by Tanner Scadden</p>
          <ExternalLink href="https://x.com/TannerSDev">
            <TwitterIcon />
          </ExternalLink>
          <ExternalLink href="https://linkedin.com/in/tanner-scadden">
            <LinkedInIcon />
          </ExternalLink>
          <ExternalLink href="https://github.com/Tanner-Scadden">
            <GitHubIcon />
          </ExternalLink>
        </div>
      </div>
    </Show>
  );
};
