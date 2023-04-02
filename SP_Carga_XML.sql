USE TareaProgramada1
GO
BEGIN
		DECLARE @inXML nvarchar (1000)
		SET @inXML = 'D:\S3\archivosbd\DatosXML_ejemplo.xml'
		DECLARE @Datos xml
		DECLARE @Instruccion nvarchar(500) = 'SELECT @Datos = D FROM OPENROWSET (BULK '+ CHAR(39) + @inXML + CHAR(39) + ', SINGLE_BLOB) AS Datos(D)'
		DECLARE @Parametros nvarchar(500) 
		SET @Parametros = N'@Datos xml OUTPUT'
		EXECUTE sp_executesql @Instruccion, @Parametros, @Datos OUTPUT
		DECLARE @hdoc int
		EXEC sp_xml_preparedocument @hdoc OUTPUT, @Datos

		DECLARE @ArticuloTemp TABLE (
			sec [int] IDENTITY(1,1),
			Nombre [varchar] (128),
			ClaseArticulo [varchar] (128),
			Precio [money]
		);									/*Se crea una tabla temporal que almacena los datos para luego hacer un inner join con la tabla verdadera*/
	

		
		INSERT INTO [dbo].[Usuario](
			[Nombre],
			[Clave]
		)
		SELECT *
		FROM OPENXML (@hdoc, '/root/Usuarios/Usuario' , 1)	/*Lee los contenidos del XML y para eso necesita un identificador,el 
															PATH del nodo y el 1 que sirve para retornar solo atributos*/
		WITH(												/*Dentro del WITH se pone el nombre y el tipo de los atributos a retornar*/
			Nombre nvarchar (30),
			Password nvarchar (30)
		)

		INSERT INTO [dbo].[ClaseArticulo](
			   [Nombre])
		SELECT *
		FROM OPENXML (@hdoc, '/root/ClasesdeArticulos/ClasesdeArticulo' , 1)
		WITH(
			Nombre nvarchar(50)
		)

		INSERT INTO @ArticuloTemp(
			   [Nombre],
			   [ClaseArticulo],
			   [Precio])
		SELECT *
		FROM OPENXML (@hdoc, '/root/Articulos/Articulo' , 1)
		WITH(
			Nombre nvarchar(50),
			ClasesdeArticulo nvarchar(50),
			precio money
		)													/* Se inserta primero en una tabla temporal para asi luego poder insertar en una tabla permanente y realizar el mapeo*/

		SELECT * FROM @ArticuloTemp

		INSERT INTO [dbo].[Articulo](
		[Nombre],
		[idClaseArticulo],
		[Precio])
		SELECT
			A.Nombre,
			CA.id as idClaseArticulo,
			A.Precio
		FROM
			[dbo].[ClaseArticulo] CA INNER JOIN @ArticuloTemp A ON CA.Nombre = A.ClaseArticulo


		DELETE FROM @ArticuloTemp
END