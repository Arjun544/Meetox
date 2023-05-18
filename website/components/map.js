import "mapbox-gl/dist/mapbox-gl.css";
import mapboxgl from "!mapbox-gl";
import React, { useRef, useState, useEffect } from "react";
import { useMediaQuery } from "react-responsive";

const Map = () => {
  mapboxgl.accessToken =
    "pk.eyJ1IjoibWVldG94IiwiYSI6ImNsYW50emhuazBjNGMzb2x4Y29ta3FnaGgifQ.B2oralnsRbhQjirxPCg4QA";
  const mapContainer = useRef(null);
  const map = useRef(null);
  const [lat, setLat] = useState(42.35);
  const [lng, setLng] = useState(-70.9);

  useEffect(() => {
    navigator.geolocation.getCurrentPosition(function (position) {
      setLat(position.coords.latitude);
      setLng(position.coords.longitude);
    });

    return () => {};
  }, []);

  useEffect(() => {
    if (map.current) return; // initialize map only once
    map.current = new mapboxgl.Map({
      container: mapContainer.current,
      style: "mapbox://styles/meetox/clbmoqzdu000l14pgzr4h26ye",
      zoom: 1.5,
      maxZoom: 1.5,
      minZoom: 0.8,
      center: [lat, lng],
      projection: "globe",
      attributionControl: false,
    });

    map.current.on("load", async () => {
      map.current.setStyle({
        ...map.current.getStyle(),
        fog: {
          range: [-0.1, 1],
          color: "white",
          "horizon-blend": 0.015,
          "high-color": "#FBD46D",
          "space-color": "#FBD46D",
          "star-intensity": 0,
        },
      });

      // Map click
      map.current.on("click", (e) => {
        map.current.flyTo({
          center: [lat, lng],
        });
      });

      map.current.scrollZoom.disable();

      // At low zooms, complete a revolution every two minutes.
      const secondsPerRevolution = 120;
      // Above zoom level 5, do not rotate.
      const maxSpinZoom = 5;
      // Rotate at intermediate speeds between zoom levels 3 and 5.
      const slowSpinZoom = 3;

      let userInteracting = false;

      function spinGlobe() {
        const zoom = map.current.getZoom();
        if (!userInteracting && zoom < maxSpinZoom) {
          let distancePerSecond = 360 / secondsPerRevolution;
          if (zoom > slowSpinZoom) {
            // Slow spinning at higher zooms
            const zoomDif = (maxSpinZoom - zoom) / (maxSpinZoom - slowSpinZoom);
            distancePerSecond *= zoomDif;
          }
          const center = map.current.getCenter();
          center.lng -= distancePerSecond;
          // Smoothly animate the map over one second.
          // When this animation is complete, it calls a 'moveend' event.
          map.current.easeTo({ center, duration: 500, easing: (n) => n });
        }
      }

      // Pause spinning on interaction
      map.current.on("mousedown", () => {
        userInteracting = true;
      });

      // Restart spinning the globe when interaction is complete
      map.current.on("mouseup", () => {
        userInteracting = false;
        spinGlobe();
      });

      // These events account for cases where the mouse has moved
      // off the map, so 'mouseup' will not be fired.
      map.current.on("dragend", () => {
        userInteracting = false;
        spinGlobe();
      });

      map.current.on("pitchend", () => {
        userInteracting = false;
        spinGlobe();
      });
      map.current.on("rotateend", () => {
        userInteracting = false;
        spinGlobe();
      });

      // When animation is complete, start spinning if there is no ongoing interaction
      map.current.on("moveend", () => {
        spinGlobe();
      });

      const currentUserMarker = document.createElement("div");
      currentUserMarker.style.background = "url(/assets/location.svg)";
      currentUserMarker.style.backgroundSize = "100%";
      currentUserMarker.style.width = "40px";
      currentUserMarker.style.height = "40px";
      currentUserMarker.className = "animate-pulse";

      const markers = [
        {
          image: "/assets/user1.svg",
          location: {
            lat: lat + 15,
            lng: lng + 15,
          },
        },
        {
          image: "/assets/circle1.svg",
          location: {
            lat: lat + 50,
            lng: lng + 50,
          },
        },
        {
          image: "/assets/circle2.svg",
          location: {
            lat: -(lat + 15),
            lng: lng + 15,
          },
        },
        {
          image: "/assets/user2.svg",
          location: {
            lat: -(lat + 60),
            lng: lng - 10,
          },
        },
        {
          image: "/assets/question.svg",
          location: {
            lat: -(lat - 30),
            lng: lng + 30,
          },
        },
      ];

      for (const marker of markers) {
        const customMarker = document.createElement("div");

        customMarker.className = "h-20 w-14";
        customMarker.style.background = `url(${marker.image})`;
        customMarker.style.backgroundSize = "100%";
        customMarker.style.backgroundRepeat = "no-repeat";

        new mapboxgl.Marker(customMarker)
          .setLngLat([marker.location.lat, marker.location.lng])
          .addTo(map.current);
      }

      new mapboxgl.Marker(currentUserMarker)
        .setLngLat([lat, lng])
        .addTo(map.current);

      spinGlobe();
    });

    return () => {};
  }, [lat, lng]);

  useMediaQuery({ maxWidth: 1250 }, undefined, (matched) => {
    matched
      ? map.current.zoomTo(0.8, { duration: 1000 })
      : map.current.zoomTo(1.5, { duration: 1000 });
  });

  return (
    <div
      ref={mapContainer}
      className="flex items-center justify-center w-full lg:w-1/2 relative"
    >
      <div className="flex w-10 bg-yellow h-12 absolute left-0 bottom-0 z-30"></div>
    </div>
  );
};

export default Map;
