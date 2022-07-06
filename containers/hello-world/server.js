"use strict";

import express from "express";

const PORT = 8080;

const app = express();

const secretMessage = process.env.secretMessage;
// how to get environment variables declared in terraform container definition (in task definition)

app.get("/", (req, res) => {
  res.send(`Hello World, ${secretMessage}`);
});

app.listen(PORT, () => console.log(`This app is listening on port ${PORT}`));
