import Image from "next/image";
import React from "react";
import FeatureTile from "./feature_tile";
import {
  RiUser4Fill,
  RiBubbleChartFill,
  RiTeamFill,
  RiQuestionMark,
  RiPinDistanceFill,
} from "react-icons/ri";
import { FaUserFriends } from "react-icons/fa";
import { MdOutlineWork } from "react-icons/md";

const Features = () => {
  const features = [
    {
      id: 1,
      title: "Nearby people, circles, questions & jobs",
      description:
        "Simply connect to people, circles, questions & jobs based on your fun & profession",
      image: "/assets/mockup.png",
    },
    {
      id: 2,

      title: "Nearby people, circles, questions & jobs",
      description:
        "Simply connect to people, circles, questions & jobs based on your fun & profession",
      image: "/assets/mockup.png",
    },
    {
      id: 3,

      title: "Nearby people, circles, questions & jobs",
      description:
        "Simply connect to people, circles, questions & jobs based on your fun & profession",
      image: "/assets/mockup.png",
    },
  ];
  const mainHeading = "Bringing together the world around YOU";
  const subHeading = "See what Meetox can do for you";

  return (
    <div className="flex flex-col items-center bg-white">
      <div className="flex mt-16">
        {mainHeading.split(" ").map((word, index) => (
          <h1
            key={word}
            id={word}
            className={`${
              word === "YOU" ? "text-yellow  hover:underline" : "text-black"
            } text-4xl font-extrabold tracking-widest mr-4 mb-2`}
          >
            {word}
          </h1>
        ))}
      </div>
      <div className="flex">
        {subHeading.split(" ").map((word, index) => (
          <h1
            key={word}
            id={word}
            className={`${
              word === "Meetox"
                ? "text-yellow  hover:underline"
                : "text-slate-400"
            } text-xl font-bold tracking-widest mr-4 mb-20`}
          >
            {word}
          </h1>
        ))}
      </div>
      <div className="flex w-full min-h-screen overflow-y-scroll">
        {/* <div className="grid w-2/3 bg-white min-h-screen overflow-y-scroll">
          {features.map((feature, index) => (
            <div
              key={feature.id}
              id={feature.id}
              className="flex flex-col bg-white w-1/2 min-h-screen snap-center"
            >
              <h1 className="">{feature.title}</h1>
            </div>
          ))}
        </div> */}
        <div className="w-full grid grid-cols-2 gap-y-12 gap-x-4 h-0 justify-center ml-20">
          <FeatureTile
            title="Profile Types"
            desc="Discover by your circles, friends & interests based on fun & professional profile types."
            color="yellow"
            icon={<RiUser4Fill color="bg-black" size={35} />}
          />
          <FeatureTile
            title="Circles"
            desc="With circles you can connect with groups of people of your interests."
            color="blue-500"
            icon={<RiBubbleChartFill size={35} className="fill-blue-500" />}
          />
          <FeatureTile
            title="Friends"
            desc="Keep your favorite nearby people in your friends list to share everything."
            color="yellow"
            icon={<RiTeamFill size={35} className="fill-yellow" />}
          />
          <FeatureTile
            title="Realtime Questions"
            desc="Need quick responses within 12 hours? Ask your nearby neighbors."
            color="green-500"
            icon={<RiQuestionMark size={35} className="fill-green-500" />}
          />
          <FeatureTile
            title="Nearby Unknowns"
            desc="Have you not met someone cool yet? Discover unknowns around you."
            color="orange-500"
            icon={<FaUserFriends size={35} className="fill-orange-500" />}
          />
          <FeatureTile
            title="Jobs findings & recruiting"
            desc="Find your favorite job opportunities in your careers."
            color="purple-500"
            icon={<MdOutlineWork size={35} className="fill-purple-500" />}
          />
          <FeatureTile
            title="Cross Paths"
            desc="Get notified when you cross paths with someone who has same interests."
            color="slate-500"
            icon={<RiPinDistanceFill size={35} className="fill-slate-500" />}
          />
        </div>
        <div className="flex items-start justify-center bg-white w-full">
          <div className="flex h-4/5 w-1/2 bgb-red-500 rounded-[50px] border-8 border-blue-600"></div>
          {/* <Image
            alt="Feature image"
            src="/assets/mockup.png"
            width={350}
            height={350}
          ></Image> */}
        </div>
      </div>
    </div>
  );
};

export default Features;
