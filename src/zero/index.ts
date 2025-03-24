import { createZero } from "@rocicorp/zero/solid";
import { decodeJwt } from "jose";
import Cookies from "js-cookie";
/* @refresh reload */
import { schema } from "./schema.ts";

const encodedJWT = Cookies.get("jwt");
const decodedJWT = encodedJWT && decodeJwt(encodedJWT);
const userID = decodedJWT?.sub ? (decodedJWT.sub as string) : "anon";

export const zero = createZero({
  userID,
  auth: () => encodedJWT,
  server: import.meta.env.VITE_PUBLIC_SERVER,
  schema,
  kvStore: "idb",
});
