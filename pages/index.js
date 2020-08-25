import React, { useEffect, useState } from "react";
import Link from "next/link";

export default function index() {
  const [Movies, setMovies] = useState([]);

  useEffect(() => {
    (async () => {
      const response = await fetch("/api").then((response) => response.json());
      setMovies(response.movies);
    })();
  }, []);

  useEffect(() => console.log(Movies), [Movies]);

  return (
    <div>
      {Movies.map((val) => (
        <Link href={"/" + val}>{val}</Link>
      ))}
    </div>
  );
}
