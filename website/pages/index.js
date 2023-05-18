import { useState, useEffect } from "react";
import Download from "../components/download";
import Features from "../components/features";
import Main from "../components/main";
import NavBar from "../components/navbar";
import Register from "../components/waitlist";
import { IoIosArrowDropupCircle } from "react-icons/io";
import Plans from "../components/plans";

export default function Home() {
  const [isOnTop, setIsOnTop] = useState(true);

  useEffect(() => {
    const handleOnTopScroll = () => {
      window.pageYOffset > 150 ? setIsOnTop(true) : setIsOnTop(false);
    };

    window.addEventListener("scroll", handleOnTopScroll);
  }, []);

  const scrollToTop = () => {
    console.log("tappped", window.pageYOffset);
    window.scrollTo({
      top: 0,
      behavior: "smooth",
    });
  };

  return (
    <>
      <div className="box-border flex flex-col w-full h-screen snap-y snap-mandatory scroll-smooth">
        {/* <div className="absolute z-10 left-0 -bottom-0">
        <Image
        src={"/assets/blur_bg.svg"}
        alt="Blur Background"
        width={900}
        height={900}
        ></Image>
      </div> */}

        <NavBar />

        <section id="#home" className="snap-always snap-center">
          <Main />
          
        </section>
        <section id="features" className="snap-always snap-center">
          <Features />
        </section>
        <section id="plans" className="snap-always snap-center">
          <Plans />
        </section>
        <section id="download" className="snap-always snap-center">
          <Download />
        </section>
        <section id="waitlist" className="snap-always snap-center">
          <Register />
        </section>
      </div>
      {isOnTop && (
        <IoIosArrowDropupCircle
          onClick={scrollToTop}
          className="fixed h-12 w-12 z-50 right-10 bottom-10 text-yellow cursor-pointer hover:scale-75 transition-all duration-700"
        />
      )}
    </>
  );
}
