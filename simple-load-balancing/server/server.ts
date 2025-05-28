import express from "express";
import os from "os";

const app = express();
const port = process.env.PORT || 3000;

app.get("/", (_, res) => {
  res.send("Hello from Bun + Express!" + " - instance " + os.hostname());
});

app.listen(port, () => {
  console.log(`Server running on http://localhost:${port}`);
});

