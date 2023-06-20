import { useEffect, useRef, useState } from "react";
import { MdClose } from "react-icons/md";
import { RiMenu5Fill, RiShieldStarFill } from "react-icons/ri";
import ScrollspyNav from "react-scrollspy-nav";
import Logo from "./logo";

export default function NavBar() {
  const [scrolled, setscrolled] = useState(false);
  const [hasScrolledPassedMainSection, setHasScrolledPassedMainSection] =
    useState(false);

  const [isMenuOpen, setIsMenuOpen] = useState(false);
  const ref = useRef();

  useEffect(() => {
    const handleScroll = () => {
      window.pageYOffset > 0 ? setscrolled(true) : setscrolled(false);
    };
    const handleScrollMainSection = () => {
      window.pageYOffset > 800
        ? setHasScrolledPassedMainSection(true)
        : setHasScrolledPassedMainSection(false);
    };

    window.addEventListener("scroll", handleScroll);
    window.addEventListener("scroll", handleScrollMainSection);
  }, [scrolled]);

  // useOutsideClick(ref, () => {
  //   if (isMenuOpen) {
  //     setIsMenuOpen(false);
  //   }
  // });
  return (
    <ScrollspyNav
      scrollTargetIds={["home", "features", "download", "waitlist"]}
      offset={-150}
      activeNavClass="is-active"
      scrollDuration="300"
      headerBackground="true"
    >
      {/* large screen navbar */}
      <div className={`fixed z-50 top-0 right-0 left-0 w-screen flex h-24`}>
        <div
          className={`flex flex-row w-full px-6 items-center justify-between md:px-10 lg:px-32 ${
            scrolled
              ? "bg-white shadow-md shadow-neutral-100 bg-opacity-60 backdrop-filter backdrop-blur-lg"
              : "shadow-none bg-transparent"
          }`}
        >
          <a href="#home" className="flex">
            <Logo
              color={hasScrolledPassedMainSection ? "#FBD46D" : "#fff"}
            ></Logo>
            <h3 className="text-black font-extrabold tracking-widest ml-4">
              Meetox
            </h3>
          </a>
          <div className="hidden md:hidden lg:flex gap-8 text-sm font-light tracking-widest items-center">
            <a
              href="#home"
              className="font-semibold hover:font-extrabold hover:text-yellow hover:bg-black hover:px-4 hover:py-2.5 hover:rounded-lg hover:scale-110 px-4 py-2 transition-all duration-700"
            >
              Home
            </a>
            <a
              href="#features"
              className="font-semibold hover:font-extrabold hover:text-yellow hover:bg-black hover:px-4 hover:py-2.5 hover:rounded-lg hover:scale-110 px-4 py-2 transition-all duration-700"
            >
              Features
            </a>

            <a
              href="#download"
              className="font-semibold hover:font-extrabold hover:text-yellow hover:bg-black hover:px-4 hover:py-2.5 hover:rounded-lg hover:scale-110 px-4 py-2 transition-all duration-700"
            >
              Download
            </a>

            <a
              href="#plans"
              className={`${
                hasScrolledPassedMainSection
                  ? "bg-yellow text-black"
                  : "bg-black text-white"
              } flex gap-4 filter drop-shadow-lg font-semibold px-4 py-3 rounded-lg hover:scale-110 transition-all duration-700`}
            >
              <RiShieldStarFill size={20} />
              Meetox PLUS
            </a>
          </div>

          {/* Medium & Small screens menu */}
          <div
            onClick={() => setIsMenuOpen((prevoiusState) => !prevoiusState)}
            className="text-black cursor-pointer transition-all duration-1000 ease-in-out lg:hidden"
          >
            {isMenuOpen ? <MdClose size={30} /> : <RiMenu5Fill size={30} />}
          </div>
          {isMenuOpen && (
            <div
              ref={ref}
              className="fixed z-50 top-24 right-0 flex flex-col h-52 w-full bg-yellow opacity-100 justify-evenly pl-4 lg:hidden shadow-md "
            >
              <a
                href="#home"
                className="font-semibold hover:font-extrabold hover:text-yellow hover:bg-black hover:px-9 hover:py-2 hover:rounded-lg hover:scale-110 px-4 py-2 transition-all duration-700"
              >
                Home
              </a>
              <a
                href="#features"
                className="font-semibold hover:font-extrabold hover:text-yellow hover:bg-black hover:px-9 hover:py-2 hover:rounded-lg hover:scale-110 px-4 py-2 transition-all duration-700"
              >
                Features
              </a>

              <a
                href="#download"
                className="font-semibold hover:font-extrabold hover:text-yellow hover:bg-black hover:px-9 hover:py-2 hover:rounded-lg hover:scale-110 px-4 py-2 transition-all duration-700"
              >
                Download
              </a>
              <a
                href="#plans"
                className="font-semibold hover:font-extrabold hover:text-yellow hover:bg-black hover:px-9 hover:py-2 hover:rounded-lg hover:scale-110 px-4 py-2 transition-all duration-700"
              >
                Meetox PLUS
              </a>
            </div>
          )}
        </div>
      </div>
    </ScrollspyNav>
  );
}
