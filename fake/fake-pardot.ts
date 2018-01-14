import * as express from "express";
import * as session from "express-session";
import * as bodyParser from "body-parser";
import { dirname } from "path";
import * as cookieParser from "cookie-parser";
import * as fs from "fs";
import { createWriteStream } from "fs";

const visitorActivity: string = fs.readFileSync("./data/visitorActivity.xml", "utf8");


const app: express.Express = express();
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
const router: express.Router = express.Router();

router.post("/:objecttype/version/3/do/query", (req, res) => {
  console.log(req.originalUrl);
  console.log(req.query);

  res.set("Content-Type", "text/xml");
  res.send(visitorActivity);
});

router.post("/login/version/3", (req, res) => {
  console.log(req.originalUrl);
  console.log(req.query);

  res.set("Content-Type", "text/xml");
  res.send(`<?xml version="1.0" encoding="UTF-8"?>
  <rsp stat="ok" version="1.0">
      <api_key>75f90041a584d3f8588786133bbe5f25</api_key>
  </rsp>`);
});


app.use("/api", router);

app.listen(9907);
