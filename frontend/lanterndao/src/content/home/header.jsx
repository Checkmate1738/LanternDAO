import { useContext } from "react";
import { Box,Text,Flex,HStack,Span } from "@chakra-ui/react";
import { defaultTheme } from "@src/App";
import { useColorMode } from "@src/components/ui/color-mode";
import { LuMoon, LuSun } from "react-icons/lu";

export default function Header() {
    const {toggleColorMode,colorMode} = useColorMode();
    const {navBG,primaryFontSize,titleBG,titleFW,titleName,primaryBg} = useContext(defaultTheme);

    const address = sessionStorage.getItem("address")

  return (
    <Flex
            className="Header"
            bgColor={navBG}
            zIndex={100}
            display={"flex"}
            justifyContent={"center"}
            alignItems={"center"}
            position={"fixed"}
          >
            <HStack spaceX={20} padding={1}>
              <Text
                display={"flex"}
                borderRadius={16}
                boxShadow={"0px 1px 1px 0px"}
                padding={2}
                fontSize={primaryFontSize}
                bgColor={titleBG}
                fontWeight={titleFW}
                color={titleName}
                flexWrap={"nowrap"}
                cursor={"pointer"}
              >
                LANTERN <Span fontWeight={600}>DAO</Span>
              </Text>
              {window.innerWidth}
              <Text>CONNECTED TO : {address}</Text>
              <Box>
                {colorMode === "dark" ? (
                  <Box
                    display={"flex"}
                    justifyContent={"center"}
                    alignItems={"center"}
                    padding={4}
                    paddingLeft={8}
                    paddingRight={8}
                    fontSize={16}
                    border={"2px solid green.300"}
                    borderRightRadius={16}
                    borderLeftRadius={16}
                    bgColor={primaryBg}
                    onClick={toggleColorMode}
                  >
                    <LuSun />
                  </Box>
                ) : (
                  <Box
                    display={"flex"}
                    justifyContent={"center"}
                    alignItems={"center"}
                    padding={4}
                    paddingLeft={8}
                    paddingRight={8}
                    fontSize={16}
                    border={"2px solid green.300"}
                    borderRightRadius={16}
                    borderLeftRadius={16}
                    bgColor={primaryBg}
                    onClick={toggleColorMode}
                  >
                    <LuMoon />
                  </Box>
                )}
              </Box>
            </HStack>
          </Flex>
  );
}
