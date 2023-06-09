USE [TareaProgramada1]
GO
/****** Object:  StoredProcedure [dbo].[sp_MostrarArticulos]    Script Date: 12/04/2023 07:16:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER   PROCEDURE [dbo].[sp_MostrarArticulos] 
					@output INT OUT --Codigo se salida
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
	 DECLARE @xmlTable
TABLE(		
			id INT IDENTITY (1, 1),
			Nombre VARCHAR(128),
			ClaseDeArticulo VARCHAR(128),
			Precio MONEY
)
	INSERT 
		INTO @xmlTable
		SELECT Nombre,
			   (SELECT Nombre FROM ClaseArticulo A WHERE A.id=idClaseArticulo),
			   Precio
		FROM Articulo

		SELECT * FROM @xmlTable
	END TRY
	BEGIN CATCH

	
	
	
	END CATCH

	SET NOCOUNT OFF;
END;