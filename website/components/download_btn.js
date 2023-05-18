import React from "react";

const DownloadBtn = ({ title, icon }) => {
  return (
    <button
      className={`button flex items-center w-56 py-4 px-8 rounded-3xl cursor-pointer transition-all ${
        title === "Google Play"
          ? " bg-black hover:bg-gray-700"
          : "bg-blue-300 bg-gradient-to-t from-blue-500 hover:bg-blue-400 hover:text-white"
      }`}
    >
      <i className="pr-4">{icon}</i>
      <div className="flex flex-col items-center">
        <h1 className="text-sm font-semibold tracking-wider">Coming soon</h1>
        <h1 className="text-sm font-semibold tracking-wider">{title}</h1>
      </div>
    </button>
    
  );
};

export default DownloadBtn;
