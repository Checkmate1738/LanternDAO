import React, { createContext } from "react";
import Index from "./content";
import { Box } from "@chakra-ui/react";
import { useColorModeValue } from "@src/components/ui/color-mode";

export const defaultTheme = createContext();

function App() {
  const textColor = useColorModeValue("black","white");
  const titleName = useColorModeValue("blue.500", "blue.600");
  const titleBG = useColorModeValue("gray.300", "gray.400");
  const titleFW = 200;

  const navBG = useColorModeValue("white","black");

  const primaryBg = useColorModeValue("gray.300", "gray.600");
  const primaryFontSize = 20;

  const secondaryFontSize = 16;

  sessionStorage.setItem("address", "0xa4df52..");


  return (
    <>
      <defaultTheme.Provider value={{ navBG,titleName, titleBG, primaryBg,primaryFontSize, secondaryFontSize,titleFW,textColor }}>
        <Box>
          <Index />
        </Box>
      </defaultTheme.Provider>
    </>
  );
}

export default App;
