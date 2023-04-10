var express = require('express'); //Biblioteca, usada para conectar el html con el servidor 
var app = express();//Biblioteca
var sql = require("mssql");//Coneccion con la base de datos
var session = require('express-session');//Biblioteca para la sesion
var bodyParser = require('body-parser');//Biblioteca

app.set('view engine', 'ejs');//Settear que el engine es ejs(React java Script)
// Configuracion de la base de datos
var config = {
    user: "Guillermo",
    password: "eAaY31xj3exhxT3zZpiz",
    server: "tarea-corta-1.cf89yocbsjjy.us-east-1.rds.amazonaws.com", 
    database: "Tarea_Corta_1",
    port: 1433,//Puerto de MSQL
    trustServerCertificate: true
};
sql.connect(config, function (err) {//una vez configurado conectese a la base de datos  
    if (err) console.log(err);
    else{
        console.log('Connected to Database')
    }
    });
global.sql = sql;
app.use(express.static('public'));//Usamos el engine
const {getMainPage, auth, getLoginPage, getAgregarArticulo} = require('./routes/controller')//Paginas que van a pedir info de las bases de datos en el controller
const {agregar} = require('./routes/cruds');//Lo que agrega info a la base de datos
//Como usamos la sesion
app.use(session({
	secret: 'secret',
	resave: true,
	saveUninitialized: true
}));
app.use(bodyParser.urlencoded({extended : true}));
app.use(bodyParser.json());
//los gets son los que dan paginas
app.get('/', function (req, res) {
 //Pagina inicial, va a ser el login
    res.render('login.ejs', {root: __dirname});
});
app.post('/auth',auth);//Algo que manda infor Siempre que tomo info de la pagina web es POST si tomo info de la base de datos es un GET y tengo que agregarlo en la linea 25/26
app.post('/agregar',agregar);
app.get('/main',getMainPage);
app.get('/login',getLoginPage);
app.get('/AgregarArticulo',getAgregarArticulo);
//Los gets son paginas, los posts son funciones

var server = app.listen(80, function () {
    console.log('Server is running..');
});