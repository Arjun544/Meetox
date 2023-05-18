import { Button, Input } from "@nextui-org/react";
import { RiSendPlaneFill } from "react-icons/ri";
import DownloadBtn from "./download_btn";
import Map from "./map";
import { SiAppstore, SiGoogleplay } from "react-icons/si";
import Image from "next/image";
import { useMediaQuery } from "react-responsive";

const Main = () => {
  const isTablet = useMediaQuery({ maxWidth: 1315 });
  const isSmallTablet = useMediaQuery({ maxWidth: 1146 });

  const mainHeading = `Meeting people NEARBY`;
  return (
    <div
      id="home"
      name="home"
      className="flex flex-col items-center gap-8 lg:items-stretch lg:flex-row min-h-screen min-w-max bg-yellow relative"
    >
      <div
        className={`flex flex-col w-full md:w-2/3 items-center md:items-start justify-center gap-10 mt-24 lg:mt-0 ${
          isTablet ? "md:pl-20" : "pl-32"
        }`}
      >
        <div className="flex flex-col w-full items-center md:items-start">
          <div className="flex">
            {mainHeading.split(" ").map((word, index) => (
              <h1
                key={word}
                id={word}
                className={`${
                  word === "NEARBY"
                    ? "text-white hover:underline"
                    : "text-black"
                } ${
                  isTablet ? "text-2xl" : "text-4xl"
                } font-extrabold tracking-widest mr-4 mb-2`}
              >
                {word}
              </h1>
            ))}
          </div>
          <h1
            className={`${
              isTablet ? "text-2xl" : "text-4xl"
            } text-black font-extrabold tracking-widest`}
          >
            totally rocks
          </h1>
        </div>
        <h1
          className={`text-sm text-black tracking-widest ${
            isTablet ? "hidden" : "flex"
          }`}
        >
          We make it easier to find locals, based on your personal & <br />{" "}
          professional interests. With realtime location, crosspaths &<br /> job
          findings.
        </h1>
        <div className="flex flex-col gap-2 md:gap-4">
          <h1 className="text-sm font-bold text-zinc-600 tracking-widest">
            Get notified when we launch
          </h1>
          <Input
            id="id"
            className="w-full h-12"
            clearable
            contentRightStyling={false}
            width={isTablet ? "350px" : "530px"}
            aria-label="email"
            placeholder="Enter your email"
            contentRight={
              <Button
                auto
                className="bg-yellow z-0 mr-1 ml-2 hover:bg-opacity-50 transition-all duration-700"
                icon={<RiSendPlaneFill filled="true" fill="white" size="20" />}
              />
            }
          />
        </div>
        <div
          className={`flex ${
            isSmallTablet ? "flex-col" : "flex-row"
          } gap-4 md:gap-8 `}
        >
          <DownloadBtn icon={<SiAppstore size={30} />} title="App Store" />
          <DownloadBtn icon={<SiGoogleplay size={30} />} title="Google Play" />
        </div>

        {/* <h1>Meet like-minded local people.</h1>
        <h1>Meetox With You</h1>
        <h1>Bringing together the world around you.</h1>
        <h1>The best way to find folks around you.</h1>
        <h1>Nearby: when you need them most.</h1>
        <h1>Have you met someone cool yet?</h1>
        <h1>Find someone close by in a snap!</h1>
        <h1>Making it easier to meet locals.</h1>
        <h1>Life shouldn't always be a solo, join the group.</h1> */}
        {/* <h1>Let's meet before we meet</h1> */}
      </div>
      <Map />

      <Image
        className="hidden absolute m-auto left-0 right-20 top-44 opacity-40 lg:flex"
        src="/assets/line.svg"
        alt="line"
        width={500}
        height={400}
      />
      {/* Styling using scroller.css in styles/scroller.css */}
      <a href="#features" id="features"  className="scrolldown bg-yellow absolute m-auto left-0 right-0 bottom-10 hover:scale-75 transition-all duration-1000">
        <div className="chevrons">
          <div className="chevrondown"></div>
          <div className="chevrondown"></div>
        </div>
      </a>
    </div>
  );
};

export default Main;
