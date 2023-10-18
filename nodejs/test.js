
// import fs from "fs";
const fs = require("fs")

let data = "hello world?"

// fs.writeFileSync("text.txt", "data")

let otherdata = fs.readFileSync("text.txt", "utf8")

console.log(otherdata)