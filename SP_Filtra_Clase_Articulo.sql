USE TareaProgramada1
GO

CREATE PROCEDURE SP_Filtra_Clase_Articulo (
	@Nombre nvarchar(128),
	@OutResultCode int,
	@inUserId int,
	@inIP varchar(50)
	)
	
	AS
	BEGIN
		
		SET NOCOUNT ON

		BEGIN TRY

			DECLARE @LogDescription VARCHAR(2000)='TipoAccion = <Consulta por la clase articulo> Description=<'+@Nombre+'>'

			SELECT * FROM [dbo].[Articulo] A INNER JOIN [dbo].[ClaseArticulo] CA ON A.idClaseArticulo = CA.id 
			WHERE  CA.Nombre LIKE '%'+@Nombre+'%'
			ORDER BY CA.Nombre ASC

			INSERT INTO [dbo].[EventLog](
				[logDescription],
				[postIdUser],
				[postUserIP],
				[postTime]
			)
			VALUES (
				@LogDescription,
				@inUserID,
				@inIP,
				GETDATE()
			)

		END TRY

	 	BEGIN CATCH

			IF @@TRANCOUNT>0  -- Error paso dentro de la transaccion
			BEGIN
				ROLLBACK TRANSACTION tUpdateArticulo; -- Se deshacen los cambios realizados
			END;
			INSERT INTO [dbo].[DBErrors]	VALUES (
				SUSER_SNAME(),
				ERROR_NUMBER(),
				ERROR_STATE(),
				ERROR_SEVERITY(),
				ERROR_LINE(),
				ERROR_PROCEDURE(),
				ERROR_MESSAGE(),
				GETDATE()
			);

			Set @OutResultCode=50005;

	
		END CATCH

		SET NOCOUNT OFF

	END;