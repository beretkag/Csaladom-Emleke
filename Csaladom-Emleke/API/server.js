require('dotenv').config();
const express = require('express');
var mysql = require('mysql');
const moment = require('moment');
const path = require('path');
const cors = require('cors');
const multer = require('multer');
const fs = require('fs');
const jwt = require('jsonwebtoken');
const { get } = require('http');

const app = express();

app.use(cors());
app.use(express.urlencoded({ extended: true }));
app.use(express.json());
app.use('/img', express.static(path.join(__dirname + '/Uploads')))

// Image file Upload settings
var storage = multer.diskStorage({
    destination: path.join(__dirname + '/Uploads'),
    filename: function(req, file, cb) {
        let file_name = file.originalname.replace(path.extname(file.originalname), "") + '-' + Date.now() + path.extname(file.originalname);
        cb(null, file_name);
    }
});

var upload = multer({ storage: storage,  limits: {fileSize: 5242420}});

const port = process.env.PORT;
const token = process.env.TOKEN;
const debug = process.env.DEBUG;

var pool = mysql.createPool({
    connectionLimit: 10,
    host: process.env.DBHOST,
    user: process.env.DBUSER,
    password: process.env.DBPASS,
    database: process.env.DBNAME
});


// file upload
app.post('/fileUpload', tokencheck(), upload.array("files"), (req, res) => {
    log(req.socket.remoteAddress, `${req.files.length} file(s) uploaded to /Public/uploads`);
    res.status(200).json(req.files);
});

// file Delete
app.delete('/fileDelete/:table/:id', tokencheck(), (req, res) => {
    let table = req.params.table;
    let id = req.params.id;
    pool.query(`SELECT Nev FROM ${table} WHERE ID=${id}`, (err, results) => {
        if (err) {
            log(req.socket.remoteAddress, err);
            res.status(500).send(err);
        } else {
            if (results[0].Nev != '') {
                fs.rm(path.join(__dirname + '/Uploads/' + results[0].Nev), (err) => {
                    if (err) {
                        log(req.socket.remoteAddress, err);
                        res.status(500).send(err);
                    }
                    else{
                        res.status(200).send(results[0].Nev)
                    }
                });
            }
            else{
                res.status(200).json(results[0].Nev);
            }
        }
    });
});

// LOGINCHECK
app.post('/login', (req, res) => {
    var table = req.body.table;
    var email = req.body.email;
    var passwd = req.body.password;

    pool.query(`SELECT ID, Nev, email, jogosultsag FROM ${table}  WHERE email=? AND Jelszo=?`, [email, passwd], (err, results) => {
        if (err) {
            log(req.socket.remoteAddress, err);
            res.status(500).send(err);
        } else {
            log(req.socket.remoteAddress, `${results.length} records sent form ${table} table (logincheck).`);
            res.status(200).send(
                results.length == 0 ? results :
                jwt.sign({
                ID:results[0].ID,
                Nev:results[0].Nev,
                email:results[0].email,
                jogosultsag:results[0].jogosultsag
            }, process.env.KEY, {expiresIn:"1d"}));
        }
    });

});

app.post(`/user/data`, (req, res)=>{
    try {
        res.status(200).send(jwt.verify(req.body.token.split(' ')[1], process.env.KEY));
    } catch (error) {
        res.status(200).send({
            ID:0,
            Nev:"",
            email:"",
            jogosultsag:0
        });
    }
})

app.post(`/registration`, (req, res)=>{
    var records = req.body.newUser;
    var str = 'null';
    var str2 = 'ID';

    var fields = Object.keys(records);
    var values = Object.values(records);

    values.forEach(value => {
        if (value == null || value == "") {
            str += ",NULL"
        }else {
            str += ",'" + value + "'"
        }
    })

    fields.forEach(field => {
        str2 += "," + field
    })

    pool.query(`INSERT INTO felhasznalok (${str2}) VALUES(${str})`, (err, results) => {
        if (err) {
            log(req.socket.remoteAddress, err);
            res.status(500).send(err);
        } else {
            log(req.socket.remoteAddress, `${results.affectedRows} record inserted to felhasznalok table.`);
            /*----------------------------------------*/
            records = req.body.newCsaladfa;
            records.felhasznaloID = results.insertId;
            str = 'null';
            str2 = 'ID';

            var fields = Object.keys(records);
            var values = Object.values(records);

            values.forEach(value => {
                if (value == null || value == "") {
                    str += ",NULL"
                }else {
                    str += ",'" + value + "'"
                }
            })

            fields.forEach(field => {
                str2 += "," + field
            })
            pool.query(`INSERT INTO csaladfak (${str2}) VALUES(${str})`, (err, results) => {
                if (err) {
                    log(req.socket.remoteAddress, err);
                    res.status(500).send(err);
                } else {
                    log(req.socket.remoteAddress, `${results.affectedRows} record inserted to csaladfak table.`);
                    /*----------------------------------------*/
                    let csaladtagok = req.body.csaladtagok;
                    let csaladfaID = results.insertId;
                    for (let i = 0; i < csaladtagok.length; i++) {
                        let record = csaladtagok[i];
                        record.csaladfaID = csaladfaID;
                        let _str = 'null';
                        let _str2 = 'ID';
    
                        var fields = Object.keys(record);
                        var values = Object.values(record);
    
                        values.forEach(value => {
                            if (value == null || value == "") {
                                _str += ",NULL"
                            }else {
                                _str += ",'" + value + "'"
                            }
                        })
    
                        fields.forEach(field => {
                            _str2 += "," + field
                        })
                        pool.query(`INSERT INTO csaladtagok (${_str2}) VALUES(${_str})`, (err, result) => {
                            if (err) {
                                log(req.socket.remoteAddress, err);
                                res.status(500).send(err);
                            } else {
                                log(req.socket.remoteAddress, `${result.affectedRows} record inserted to csaladtagok table.`);
                                if (i == csaladtagok.length-1) {
                                    res.status(200).send(results);
                                }
                            }
                        });
                    }
                    /*----------------------------------------*/
                }
            });
            /*----------------------------------------*/   
        }
    }); 
});

// GET ID BY email
app.get('/forgotpass/:email', tokencheck(), (req, res) => {
    var table = "felhasznalok";
    var field = "email";
    var value = req.params.email;
    pool.query(`SELECT ID FROM ${table} WHERE ${field}='${value}'`, (err, results) => {
        if (err) {
            log(req.socket.remoteAddress, err);
            res.status(500).send(err);
        } else {
            log(req.socket.remoteAddress, `${results.length} records sent form ${table} table.`);
            res.status(200).send(results);
        }
    });
});

// GET ALL RECORDS
app.get('/:table', tokencheck(), (req, res) => {
    var table = req.params.table;
    pool.query(`SELECT * FROM ${table}`, (err, results) => {
        if (err) {
            log(req.socket.remoteAddress, err);
            res.status(500).send(err);
        } else {
            log(req.socket.remoteAddress, `${results.length} records sent form ${table} table.`);
            res.status(200).send(results);
        }
    });
});

// GET ONE RECORD BY ID
app.get('/:table/:id', tokencheck(), (req, res) => {
    var table = req.params.table;
    var id = req.params.id;
    pool.query(`SELECT * FROM ${table} WHERE ID=${id}`, (err, results) => {
        if (err) {
            log(req.socket.remoteAddress, err);
            res.status(500).send(err);
        } else {
            log(req.socket.remoteAddress, `${results.length} record sent form ${table} table.`);
            res.status(200).send(results);
        }
    });
});

// GET RECORDS BY field
app.get('/:table/:field/:value', tokencheck(), (req, res) => {
    var table = req.params.table;
    var field = req.params.field;
    var value = req.params.value;
    pool.query(`SELECT * FROM ${table} WHERE ${field}='${value}'`, (err, results) => {
        if (err) {
            log(req.socket.remoteAddress, err);
            res.status(500).send(err);
        } else {
            log(req.socket.remoteAddress, `${results.length} records sent form ${table} table.`);
            res.status(200).send(results);
        }
    });
});






// GET RECORDS WITH LIKE
app.get('/like/:table/:field/:value', tokencheck(), (req, res) => {
    var table = req.params.table;
    var field = req.params.field;
    var value = req.params.value;
    pool.query(`SELECT * FROM ${table} WHERE ${field} LIKE '%${value}%'`, (err, results) => {
        if (err) {
            log(req.socket.remoteAddress, err);
            res.status(500).send(err);
        } else {
            log(req.socket.remoteAddress, `${results.length} records sent form ${table} table.`);
            res.status(200).send(results);
        }
    });
});

// INSERT RECORD
app.post('/:table', tokencheck(), (req, res) => {
    var table = req.params.table;
    var records = req.body;
    var str = 'null';
    var str2 = 'ID';

    var fields = Object.keys(records);
    var values = Object.values(records);

    values.forEach(value => {
        if (value == null || value == "") {
            str += ",NULL"
        }else {
            str += ",'" + value + "'"
        }
    })

    fields.forEach(field => {
        str2 += "," + field
    })

    pool.query(`INSERT INTO ${table} (${str2}) VALUES(${str})`, (err, results) => {
        if (err) {
            log(req.socket.remoteAddress, err);
            res.status(500).send(err);
        } else {
            log(req.socket.remoteAddress, `${results.affectedRows} record inserted to ${table} table.`);
            res.status(200).send(results);
        }
    });
});

// UPDATE RECORD
app.patch('/:table/:id', tokencheck(), (req, res) => {
    var table = req.params.table;
    var id = req.params.id;
    var records = req.body;
    var str = '';

    var fields = Object.keys(records);
    var values = Object.values(records);

    for (let i = 0; i < fields.length; i++) {
        if (values[i] == null || values[i] == "") {
            str += fields[i] + "=NULL";
        }else{
            str += fields[i] + "='" + values[i] + "'";
        }
        if (i != fields.length - 1) {
            str += ",";
        }
    }

    pool.query(`UPDATE ${table} SET ${str} WHERE ID=${id}`, (err, results) => {
        if (err) {
            log(req.socket.remoteAddress, err);
            res.status(500).send(err);
        } else {
            log(req.socket.remoteAddress, `${results.affectedRows} record updated in ${table} table.`);
            res.status(200).send(results);
        }
    });
});

// DELETE ALL RECORDS
app.delete('/:table', tokencheck(), (req, res) => {
    var table = req.params.table;
    pool.query(`DELETE FROM ${table}`, (err, results) => {
        if (err) {
            log(req.socket.remoteAddress, err);
            res.status(500).send(err);
        } else {
            log(req.socket.remoteAddress, `${results.affectedRows} record deleted form ${table} table.`);
            res.status(200).send(results);
        }
    });
});

// DELETE ONE RECORD
app.delete('/:table/:field/:value', tokencheck(), (req, res) => {
    var table = req.params.table;
    var field = req.params.field;
    var value = req.params.value;

    pool.query(`DELETE FROM ${table} WHERE ${field}=${value}`, (err, results) => {
        if (err) {
            log(req.socket.remoteAddress, err);
            res.status(500).send(err);
        } else {
            log(req.socket.remoteAddress, `${results.affectedRows} record deleted form ${table} table.`);
            res.status(200).send(results);
        }
    });
});


app.listen(port, () => {
    console.log(`Server listening on port ${port}.`);
})

// MIDDLEVARE FUNCTIONS


function tokencheck() {
    return (req, res, next) => {
        try {
            jwt.verify(req.headers.authorization.split(' ')[1], process.env.KEY);
            next();
        } catch (error) {
            if (req.params.table == "felhasznalok" || ((req.params.table == "csaladfak" || req.params.table == "csaladtagok") && req.method == 'GET')) {
                next();
            }
            else{
                res.status(401).send(error);
            }
        }
    };
}

function log(req, res) {
    if (debug == 1) {
        var timestamp = moment(new Date()).format('yyyy-MM-DD HH:mm:ss');
        console.log(`[${timestamp}] : ${req} >>> ${res}`);
    }
}