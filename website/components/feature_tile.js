import React from "react";

const FeatureTile = ({ title, color, icon, desc }) => {
      return (
        <div className="flex gap-16 hover:bg-slate-100 rounded-3xl p-6 cursor-pointer transition-all duration-500">
          <div className="relative">
            <div
              className={`flex h-10 w-10 rounded-full bg-${color}  filter drop-shadow-sm`}
            ></div>
            <div
              className={`flex items-center justify-center absolute left-1 top-1 h-20 w-20 rounded-3xl bg-${color} bg-opacity-20 backdrop-filter backdrop-blur-sm`}
            >
              <i color='red'>{icon}</i>
            </div>
          </div>
          <div className="flex flex-col gap-4">
            <h1 className="text-black font-semibold tracking-widest">
              {title}
            </h1>
            <h1 className="text-slate-500 text-xs font-medium tracking-widest">
              {desc}
            </h1>
          </div>
        </div>
      );
};

export default FeatureTile;
