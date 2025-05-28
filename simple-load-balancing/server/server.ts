import express from "express";

const app = express();
const port = process.env.PORT || 3000;

app.get("/", (_, res) => {
  res.send("Hello from Bun + Express!");
});

app.listen(port, () => {
  console.log(`Server running on http://localhost:${port}`);
});

