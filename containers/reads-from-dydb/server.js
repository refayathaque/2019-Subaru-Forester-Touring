"use strict";

import express from "express";
import listTables from "./list-tables.js";

const PORT = 8080;

const app = express();

app.get("/", async (req, res) => {
  const tables = await listTables();
  res.send({ DynamoDBtables: tables });
});

app.listen(PORT, () => console.log(`This app is listening on port ${PORT}`));

// how to handle async/await with express:
// https://www.wisdomgeek.com/development/web-development/using-async-await-in-expressjs/
