USE TareaProgramada1


-----/ Script creacion tabla [Usuario]
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuario](

 [id] [int] IDENTITY(1,1) NOT NULL,
 [Nombre] [varchar](128) NOT NULL,
 [Clave] [nvarchar] (128) NOT NULL,

CONSTRAINT [PK_Usuario] PRIMARY KEY CLUSTERED (

	[id] ASC

) WITH (

	PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF,
	ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON

) ON
	[PRIMARY] 
) ON 
	[PRIMARY] 
GO


-----/ Script creacion tabla [TipoIdentificacion] /-----

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventLog](

 [id] [int] IDENTITY(1,1) NOT NULL,
 [logDescription] [varchar](2000) NOT NULL,
 [postIdUser] [varchar] (256) NOT NULL,
 [postUserIP] [varchar] (256) NOT NULL,
 [postTime] [datetime] NOT NULL,

CONSTRAINT [PK_EventLog] PRIMARY KEY CLUSTERED (

	[id] ASC

) WITH (

	PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF,
	ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON

) ON
	[PRIMARY] 
) ON 
	[PRIMARY] 
GO

-----/ Script de la tabla [Articulo] /-----

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Articulo](

 [id] [int] IDENTITY(1,1) NOT NULL,
 [idClaseArticulo] [int] NOT NULL,
 [Nombre] [nvarchar] (128) NOT NULL,
 [Precio] [money] NOT NULL,

CONSTRAINT [PK_Articulo] PRIMARY KEY CLUSTERED (

	[id] ASC

) WITH (

	PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF,
	ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON

) ON
	[PRIMARY] 
) ON 
	[PRIMARY]
GO

-----/ Script de la tabla [ClaseArticulo] /-----

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClaseArticulo](

 [id] [int] IDENTITY(1,1) NOT NULL,
 [Nombre] [nvarchar] (128) NOT NULL,


CONSTRAINT [PK_ClaseArticulo] PRIMARY KEY CLUSTERED (

	[id] ASC

) WITH (

	PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF,
	ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON

) ON
	[PRIMARY] 
) ON 
	[PRIMARY]
GO

-----* Script ligar tablas [Articulo] | [ClaseArticulo] *-----

ALTER TABLE [dbo].[Articulo] WITH CHECK ADD CONSTRAINT [FK_Articulo_ClaseArticulo]
FOREIGN KEY([idClaseArticulo])
REFERENCES [dbo].[ClaseArticulo] ([id])
GO

ALTER TABLE [dbo].[Articulo] CHECK CONSTRAINT [FK_Articulo_ClaseArticulo]
GO


-----/ Script de la tabla [DBErrors] /-----

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DBErrors](

 [id] [int] IDENTITY(1,1) NOT NULL,
 [userName] [nvarchar] (128) NULL,
 [ErrorNumber] [int] NULL,
 [ErrorState] [int] NULL,
 [ErrorSeverity] [int] NULL,
 [ErrorLine] [int] NULL,
 [ErrorProcedure] [varchar] (MAX) NULL,
 [ErrorMessage] [varchar] (MAX) NULL,
 [ErrorDateTime] [datetime] NULL,


CONSTRAINT [PK_DBErrors] PRIMARY KEY CLUSTERED (

	[id] ASC

) WITH (

	PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF,
	ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON

) ON
	[PRIMARY] 
) TEXTIMAGE_ON 
	[PRIMARY]
GO