module.exports = {
    getMainPage: (req, res)=>{
        var output = 0;
        let dbrequest = new sql.Request();
        let dbquery = "EXEC dbo.SP_MostrarArticulos @output out";
        dbrequest.output('output',sql.Int, output);//@output
        dbrequest.query(dbquery,function(err,rows,fields){
            if (err) console.log(err)
            else{
                res.render('main.ejs', {"Articulos": rows});
            }
        });

    },
    getLoginPage: (req, res)=>{
        res.render('login.ejs');
    },
    auth: (req, res)=>{
        var username = req.body.username;//Tomamos la info de la base de datos desde login
        var password = req.body.password;
        var output = 0;
        let dbrequest = new sql.Request();
        let dbquery = 'EXEC sp_Login @Usuario, @Contrasenna, @output out';//Esto va a estar basicamente en un querry de SQL
        if (username && password) {
            //Dentro de la base de datos
            dbrequest.input('Usuario',sql.VarChar,username);//@Usuario
            dbrequest.input('Contrasenna',sql.VarChar,password);//@Contrasenna
            dbrequest.output('output', sql.Int, output);//@Output
            dbrequest.query(dbquery, function(error, results, fields) {
                //Ejecucion del querry
                if (results.output.output == 1) {
                    req.session.loggedin = true;
                    req.session.username = username;
                    res.redirect('/main');
                } else {
                    res.send('Incorrect Username and/or Password!');
                }			
                res.end();
            });
        } else {
            res.send('Please enter Username and Password!');
            res.end();
        }
        },
    getAgregarArticulo: (req,res)=>{
        res.render('AgregarArticulo.ejs');
    }
    
    
}