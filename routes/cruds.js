module.exports = {
    agregar: (req,res)=> {
        var Nombre = req.body.username;
        var ClaseArticulo = req.body.ClaseArticulo;
        var Precio = req.body.password;
        var output = 0;
        let dbrequest = new sql.Request();
        let dbquery = 'EXEC SP_Inserta_Articulo @Nombre, @Precio, @output out';
        if (Nombre && Precio) {
            dbrequest.input('Nombre',sql.VarChar,Nombre);
            dbrequest.input('Precio',sql.Money,Precio);
            dbrequest.output('output', sql.Int, output);
            dbrequest.query(dbquery, function(err, results, fields) {
                if (results.output.output == 1|results.output.output == 2){
                    if(results.output.output==1){
                        res.send('La clase del articulo no existe');
                        
                    }
                    else{
                        res.send('Un articulo con el mismo nombre ya existe');
                    }
                }        
                else {
                    /*res.send('Articulo agregado con exito');*/
                    res.redirect('/main');
                    
                }			
                res.end();
            });
        } else {
            res.send('Porfavor introduzca datos');
            res.end();
        }
    }
}