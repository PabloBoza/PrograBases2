USE [TareaProgramada1]
GO
/****** Object:  StoredProcedure [dbo].[sp_AgregarArticulo]    Script Date: 12/04/2023 02:28:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER   PROCEDURE [dbo].[sp_AgregarArticulo] 
							@Nombre VARCHAR(128), --Nombre del Articulo a agregar
							@ClaseArticulo VARCHAR(128),--Nombre de la ClaseArticulo del articulo 
							@Precio MONEY,  --Precio del articulo
							@output INT OUT

AS

		-- Inicia codigo en el cual se captura errores

		IF NOT EXISTS (SELECT 1 FROM dbo.Articulo A WHERE A.idClaseArticulo=(SELECT id FROM ClaseArticulo B WHERE B.Nombre=@ClaseArticulo))
		BEGIN
		   SET @output=1;
		   --Error Clase de articulo no existe
		   RETURN;
		END; 
		IF EXISTS (SELECT 1 FROM dbo.Articulo A WHERE A.Nombre=@Nombre)
		BEGIN
		   SET @output=2;
		   --El articulo ya existe
		   RETURN;
		END;
		INSERT 
			INTO Articulo
			SELECT (SELECT id FROM ClaseArticulo B WHERE B.Nombre=@ClaseArticulo),
				   @Nombre,
				   @Precio 

