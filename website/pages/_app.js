import "../styles/globals.css";
import { Poppins } from "@next/font/google";
import Head from "next/head";
import { NextUIProvider } from "@nextui-org/react";

const poppins = Poppins({ weight: "400", subsets: ["latin"] });


function MyApp({ Component, pageProps }) {

  return (
    <>
      <Head>
        <title>Meetox</title>
      </Head>

      <main className={poppins.className}>
          <NextUIProvider>
           <Component {...pageProps} />
          </NextUIProvider>
      </main>
    </>
  );
}

export default MyApp;
