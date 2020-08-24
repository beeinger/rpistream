import puppeteer from "puppeteer";

export default async (req, res) => {
  if (req.method === "GET") {
    const browser = await puppeteer.launch({
      userDataDir: "tmp/user-data-dir",
      args: ["--no-sandbox"],
      headless: true,
    });
    const page = await browser.newPage();
    await page.goto("http://localhost:3001/", { timeout: 0 });
    await page.waitForSelector("body > main > header");
    const hrefs = await page.evaluate(() =>
      Array.from(document.querySelectorAll("a[href]"), (a) => {
        const href = a.getAttribute("href");
        if (href.substr(href.length - 3) === "mp4") return href.substr(1);
      })
    );
    var movies = hrefs.filter(function (el) {
      return el != null;
    });
    await browser.close();
    res.status(200).json({ movies });
  } else {
    res.status(405);
  }
};
