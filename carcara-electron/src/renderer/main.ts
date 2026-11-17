import { mountApp } from "./app.js";

const root = document.getElementById("app");
if (!root) {
  throw new Error("#app mount point missing");
}
mountApp(root);
