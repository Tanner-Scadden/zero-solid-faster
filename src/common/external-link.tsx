import { type JSX } from "solid-js";

export const ExternalLink = (props: { href: string; children: JSX.Element }) => {
  return (
    <a href={props.href} target="_blank" rel="noreferrer" class="hover:text-blue-500">
      {props.children}
    </a>
  );
};
