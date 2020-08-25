const fs = require("fs");

export default async (req, res) => {
  if (req.method === "GET") {
    const dir = "/home/pi/app/public";
    const files = fs.readdirSync(dir);

    res.status(200).json({ movies: files });
  } else {
    res.status(405);
  }
};
