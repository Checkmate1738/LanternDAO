import { StrictMode } from "react";
import { createRoot } from "react-dom/client";
import { Provider } from "@src/components/ui/provider";
import App from "./App.jsx";
import background from "@src/assets/background1.jpeg"
import { Box } from "@chakra-ui/react";

createRoot(document.getElementById("root")).render(
  <StrictMode>
    <Provider>
      <Box bgImage={background} bgSize={"cover"} bgRepeat={"no-repeat"} bgPos={"center"} zIndex={4}>
      <App />
      </Box>
    </Provider>
  </StrictMode>
);
