USE TareaProgramada1
GO

CREATE PROCEDURE SP_Filtra_Nombre_Alfabeto (
	@Nombre nvarchar(128),
	@OutResultCode int,
	@inIDUser nvarchar(128),
	@inIP nvarchar(128)
	)
	
	AS
	BEGIN
		
		SET NOCOUNT ON

		BEGIN TRY

			DECLARE @LogDescription nvarchar(1000) = 'TipoAccion = <Consulta por nombre en tabla Articulo en orden alfabetico> Description=<Ascendente>'

			SELECT * FROM [dbo].[Articulo] WHERE Nombre LIKE '%'+@Nombre+'%'
			ORDER BY Nombre ASC

			INSERT INTO [dbo].[EventLog] (
				[logDescription],
				[postIdUser],
				[postUserIP],
				[postTime]
			)
			VALUES (
				@LogDescription,
				@inIDUser,
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