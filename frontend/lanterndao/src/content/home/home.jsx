import { useContext } from "react";
import { useColorMode } from "@src/components/ui/color-mode";
import { HStack, Text, Image, Box, Span, Button, Flex } from "@chakra-ui/react";
import Header from "./header";
import Body from "./body";
import { defaultTheme } from "@src/App";
import react from "@src/assets/react.svg";

function Home() {
  const { colorMode, toggleColorMode } = useColorMode();
  const { titleName, titleBG, primaryBg, primaryFontSize, titleFW, navBG } =
    useContext(defaultTheme);

  

  return (
    <>
      
      <Header/>
      <Body/>
      
    </>
  );
}

export default Home;
