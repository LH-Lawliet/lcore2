// get the client
const {Client} = require('pg');
const sqlClient = new Client({
    user: GetConvar("dbUSER", "defaultUser"),
    host: GetConvar("dbIP", "defaultIP"),
    database: GetConvar("dbDB", "defaultDB"),
    password: GetConvar("dbPASSWORD", "defaultPASSWORD"),
    port: parseInt(GetConvar("dbPORT", "defaultPORT")),
})
sqlClient.connect()

let ready = false

sqlClient.query('SELECT $1::text as message', ['Connected to the database!'], (err, res) => {
    console.log(err ? err.stack : res.rows[0].message) // Hello World!
    ready = true;
})

exports('isDatabaseReady', function() {
    return ready
})

exports('query', function(string, variables, callback) {
    sqlClient.query(string, variables, (err, res) => {
        if (callback) {
            callback(err || "", res)
        } else {
            if (err) console.error(err)
        }
    })
})