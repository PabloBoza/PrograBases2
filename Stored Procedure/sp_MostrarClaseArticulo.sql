CREATE OR ALTER PROCEDURE sp_MostrarClaseArticulo
					@output INT OUT --Codigo se salida
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
	 DECLARE @xmlTable
TABLE(
			Nombre VARCHAR(128)
)
	INSERT 
		INTO @xmlTable
		SELECT Nombre
		FROM ClaseArticulo

		SELECT Nombre FROM @xmlTable
	END TRY
	BEGIN CATCH

	
	
	
	END CATCH

	SET NOCOUNT OFF;
END;