import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";

// https://vite.dev/config/
export default defineConfig({
  plugins: [react()],
  server: {
    host: "172.20.10.13", //"192.168.100.56",
    port: 3560,
  },
});
