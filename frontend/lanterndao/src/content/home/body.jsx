import {
  Box,
  Text,
  Button,
  Image,
  HStack,
  List,
  Heading,
} from "@chakra-ui/react";
import react from "@src/assets/react.svg";

function Intro() {
  const welcome =
    "Welcome to Lantern DAO, this is Fully Decentralized Autonomous Organization, that is enthusiastic towards various NFT features and ready to spear-head leading transformations such as liquidating NFTs, making it an entity for collateral in NFT-Fi, NFTs have a huge potential and Lantern through various strategies has implemented some of the use cases of NFTs. If you would be interested, all that is needed is your wallet address";

  return (
    <Section name={"Intro"} wrap={"nowrap"}>
      <Text textAlign={"center"} fontSize={"lg"}>
        {welcome}
      </Text>

      <Box
        display={"flex"}
        paddingY={"8vh"}
        justifyContent={"center"}
        alignItems={"center"}
      >
        <Button
          type={"submit"}
          paddingX={"8px"}
          paddingY={"2px"}
          bgColor={"blue.600"}
          _focus={{ backgroundColor: "blue.200" }}
          onClick={() => {
            console.log("clicked!");
            alert("yeah");
          }}
          borderRadius={15}
          boxShadow={"1px 1px 0px 1px"}
        >
          {"Connect Wallet"}
        </Button>
      </Box>
    </Section>
  );
}

function Auction({ width, height, paddX, paddY }) {
  const title = "Auctions";
  const auction =
    "Lantern's Auction protocol, is made from the popular types of auction, i.e;";

  const auctionTypes = [
    "English Auction",
    "Dutch Auction",
    "Sealed-Bid Auction",
    "Vickery Auction",
  ];

  return (
    <Section name={"Section 1 - Auction"} wrap={"wrap-reverse"}>
      <Box
        as={"aside"}
        bgColor={"yellow.300"}
        paddingX={paddX}
        paddingY={paddY}
        textAlign={"center"}
      >
        <Heading as="h2" textAlign={"start"}>
          {title}
        </Heading>
        <Text textAlign={"left"} fontSize={"lg"}>
          {auction}
        </Text>
        <Box display={"flex"} justifyContent={"center"} alignItems={"center"}>
          <List.Root>
            {auctionTypes.map((item, index) => (
              <List.Item
                as="li"
                key={index}
                listStyle={"none"}
                textAlign={"start"}
                fontSize={"md"}
                fontWeight={600}
              >
                {item}
              </List.Item>
            ))}
          </List.Root>
        </Box>
      </Box>
      <Box
        as={"aside"}
        bgColor={"purple.300"}
        paddingX={paddX}
        paddingY={paddY}
        textAlign={"center"}
      >
        <Image src={react} width={width} height={height} />
      </Box>
    </Section>
  );
}

function NFT_Fi({ width, height, paddX, paddY }) {
  const title = "NFT Finance";
  const nft_fi = "NFT Fi text";

  return (
    <Section name={"Section 2 - nft fi"} wrap={"wrap"}>
      <Box
        as={"aside"}
        bgColor={"purple.300"}
        paddingX={paddX}
        paddingY={paddY}
        textAlign={"center"}
      >
        <Image src={react} width={width} height={height} />
      </Box>
      <Box
        as={"aside"}
        paddingX={paddX}
        paddingY={paddY}
        bgColor={"yellow.300"}
        textAlign={"center"}
      >
        <Heading as="h2" textAlign={"start"}>
          {title}
        </Heading>
        <Text>{nft_fi}</Text>
      </Box>
    </Section>
  );
}

function Farming({ width, height, paddX, paddY }) {
  const title = "Farming strategies";
  const farming = "Farming text";

  return (
    <Section name={"Section 3 - Yield farming"} wrap={"wrap-reverse"}>
      <Box
        as={"aside"}
        bgColor={"yellow.300"}
        paddingX={paddX}
        paddingY={paddY}
        textAlign={"center"}
      >
        <Heading as="h2" textAlign={"start"}>
          {title}
        </Heading>
        <Text>{farming}</Text>
      </Box>
      <Box
        as={"aside"}
        bgColor={"purple.300"}
        paddingX={paddX}
        paddingY={paddY}
        textAlign={"center"}
      >
        <Image src={react} width={width} height={height} />
      </Box>
    </Section>
  );
}

function Footer() {
  const footer = "footer";

  return (
    <HStack className="Footer" bgColor={"rebeccapurple"} padding={4}>
      {footer}
    </HStack>
  );
}

function Section({ children, name, wrap }) {
  return (
    <Box
      className={name}
      minHeight={"50vh"}
      display={"flex"}
      justifyContent={"space-evenly"}
      alignItems={"center"}
      flexWrap={wrap}
    >
      {children}
    </Box>
  );
}

export default function Body() {
  const padY = "16vh";
  const padX = "16vw";

  const imageX = window.innerWidth / 8;
  const imageY = "200px";

  return (
    <Box as={"section"}>
      <Intro paddX={padX} paddY={padY} width={imageX} height={imageY} />

      <Auction paddX={padX} paddY={padY} width={imageX} height={imageY} />

      <NFT_Fi paddX={padX} paddY={padY} width={imageX} height={imageY} />

      <Farming paddX={padX} paddY={padY} width={imageX} height={imageY} />

      <Footer />
    </Box>
  );
}
