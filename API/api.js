const express = require('express')
const cors = require('cors');
const app = express()
const port = 3000
app.use(cors())
const connection = require('../Connection/conn')
app.get("/User", (req,res)=>{
    connection.query("select * from User", (err, rows, fields) => {
        if (err) throw err
        res.send(200, rows)
    })
})

app.listen(port, () => {
    console.log(`Successfully listening on port ${port}`)
})