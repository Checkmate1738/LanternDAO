/*function App() {
  return (
    <>
      <div>
        <h1>Hello world</h1>
      </div>
    </>
  );
}

export default App;
*/

import React from "react";
import Web3 from "web3";
import { Transak } from "@transak/transak-sdk";

const App = () => {
  const initTransak = () => {
    const transak = new Transak({
      apiKey: "YOUR_API_KEY", // Replace with your Transak API Key
      environment: "STAGING", // Use 'PRODUCTION' in production
      walletAddress: "0xYourWalletAddress", // Wallet address where funds will be sent
      fiatCurrency: "USD", // Fiat currency to use (optional)
      cryptoCurrencyList: "ETH,USDT", // Cryptos supported (optional)
      networks: "ethereum", // Networks supported (e.g., 'ethereum,polygon')
      defaultNetwork: "ethereum", // Default network
    });

    transak.init();

    // Listen to Transak events
    transak.on("TRANSAK_ORDER_SUCCESSFUL", (orderData) => {
      console.log("Order successful:", orderData);
      transak.close(); // Close the widget
    });

    transak.on("TRANSAK_ORDER_FAILED", (orderData) => {
      console.log("Order failed:", orderData);
      transak.close();
    });

    // Handle widget close
    transak.on("TRANSAK_WIDGET_CLOSE", () => {
      console.log("Widget closed");
    });
  };

  return (
    <div>
      <h1>Integrate Transak with Web3.js</h1>
      <button onClick={initTransak}>Buy Crypto</button>
    </div>
  );
};

export default App;
