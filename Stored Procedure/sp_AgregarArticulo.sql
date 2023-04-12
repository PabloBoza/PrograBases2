CREATE OR ALTER PROCEDURE sp_AgregarArticulo 
							@Nombre VARCHAR(128), --Nombre del Articulo a agregar
							@ClaseArticulo VARCHAR(128),--Nombre de la ClaseArticulo del articulo 
							@Precio MONEY,  --Precio del articulo
							@output INT OUT

AS

		-- Inicia codigo en el cual se captura errores

		IF NOT EXISTS (SELECT 1 FROM dbo.Articulo A WHERE A.IdClaseArticulo=(SELECT id FROM ClaseArticulo B WHERE B.Nombre=@ClaseArticulo))
		BEGIN
		   SET @output=1;
		   PRINT 'ERROR: CODE ERROR 1'
		   RETURN;
		END; 
		IF EXISTS (SELECT 1 FROM dbo.Articulo A WHERE A.Nombre=@Nombre)
		BEGIN
		   SET @output=2;
		   PRINT 'ERROR: CODE ERROR 2'
		   RETURN;
		END;
		INSERT 
			INTO Articulo
			SELECT (SELECT id FROM ClaseArticulo B WHERE B.Nombre=@ClaseArticulo),
				   @Nombre,
				   @Precio 

GO