import dynamic from "next/dynamic";
import React from "react";
import { useRouter } from "next/router";
import ReactPlayer from "react-player";

function movie() {
  const router = useRouter();
  const { movie } = router.query;

  return <ReactPlayer url={"http://localhost:3001/" + movie} controls={true} />;
}

export default dynamic(() => Promise.resolve(movie), {
  ssr: false,
});
