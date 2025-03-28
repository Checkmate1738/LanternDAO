import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";
import jsconfigPaths from "vite-jsconfig-paths";

// https://vite.dev/config/
export default defineConfig({
  plugins: [react(), jsconfigPaths()],
  server: {
    host: "172.20.10.13", //"localhost", //"172.20.10.13", //"192.168.100.56",
    port: 3560,
  },
});
