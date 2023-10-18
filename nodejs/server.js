const express = require("express")

const app = express()


// function something() {
//     console.log("something")
// }

app.get("/abc", (req,res) => {
    res.send("ABC")
})

app.get("/def", (req,res) => {
    res.send("DEF")
})

const port = 8000
app.listen(port, () => {
    console.log("server is running on port", port)
})