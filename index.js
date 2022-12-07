const express = require('express')
const { Client } = require('pg');
const { Server } = require("socket.io")
const http = require('http');

const app = express()
const server = http.createServer(app)
const io = new Server(server)
const port = 3000

const getDbClient = () =>
    new Client({
        user: 'postgres',
        host: process.env.RDS_HOSTNAME,
        database: 'postgres',
        password: 'postgres',
        port: 5432,
    })

app.get('/', (req, res) => {
    res.sendFile(__dirname + '/index.html')
})

app.get('/health', async (req, res) => {
    const result = { healthy: true, err: null}
    const db = getDbClient()

    try {
        await db.connect()
        await db.query('SELECT NOW()')
    } catch (err) {
        result.healthy = false
        result.err = err.message
    } finally {
        await db.end()
        res.send(result)
    }
})

server.listen(port, () => console.log(`Example app listening on port ${port}!`))


io.on('connection', (socket) => {
    console.log('a user connected')
    socket.on('disconnect', () => {
        console.log('user disconnected')
    })
    socket.on('chat message', (msg) => {
        io.emit('chat message', msg)
    })
});

