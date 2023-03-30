USE TareaProgramada1
GO

CREATE PROCEDURE SP_Login
	@Nombre varchar(16),
	@Clave varchar(16)

	AS
	BEGIN
		SELECT * FROM [dbo].[Usuario] WHERE Nombre = @Nombre AND Clave = @Clave
	END

GO