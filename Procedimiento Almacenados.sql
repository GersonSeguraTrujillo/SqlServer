------Usuario
create PROCEDURE sp_Registrar_Usuario(
	@Nombres varchar(40),
	@Apellidos varchar(40),
	@Correo varchar(50),
	@Clave varchar(600),
	@rol int,
	@Mensaje varchar (500) output,
	@Resultado int output
	)
	as 
	begin
			SET @Resultado = 0

		IF Not exists (Select * from USUARIO where Correo = @Correo)
	begin 
			insert into USUARIO(Nombre,Apellido,Correo,Contraseña, rol)  values (@Nombres,@Apellidos,@Correo,@Clave,@rol)

			set @Resultado = SCOPE_IDENTITY()
	end
		else
			set @Mensaje = 'El Correo del Usuario ya Existe'
	end
	go
	-----
	create PROCEDURE sp_Editar_Usuario(
	@IdUsuario int,
	@Nombres varchar(40),
	@Apellidos varchar(40),
	@Correo varchar(50),
	@Clave varchar(600),
	@rol int,
	@Mensaje varchar (500) output,
	@Resultado int output
 )
 as 
 begin
	SET @Resultado = 0
	IF Not exists (Select * from USUARIO 
						where Correo = @Correo and IdUsuario != @IdUsuario)
begin 
	update top (1) USUARIO 
		set Nombre = @Nombres,
			Apellido = @Apellidos,
			Correo = @Correo,
			Contraseña=@Clave,
			rol = @rol
			where IdUsuario = @IdUsuario
			set @Resultado = 1
	end
	else
	set @Mensaje = 'El Correo del Usuario ya Existe'
end
go
------medico

CREATE PROCEDURE sp_Registrar_Medico(
	@Nombre varchar(50),
	@Apellido varchar(50),
	@Correo varchar(50),
	@Mensaje varchar (500) output,
	@Resultado int output
	)
	as 
	begin
			SET @Resultado = 0

		IF Not exists (Select * from MEDICO where Correo = @Correo)
	begin 
			insert into MEDICO(Nombre,Apellido,Correo)  values (@Nombre,@Apellido,@Correo)

			set @Resultado = SCOPE_IDENTITY()
	end
		else
			set @Mensaje = 'El   Medico ya Existe'
	end
	go



	CREATE PROCEDURE sp_Editar_Medico(
	@IdMedico int,
	@Nombre varchar(50),
	@Apellido varchar(50),
	@Correo varchar(50),
	@Mensaje varchar (500) output,
	@Resultado int output
 )
 as 
 begin
	SET @Resultado = 0
	IF Not exists (Select * from Medico
						where Correo = @Correo and IdMedico != @IdMedico)
begin 
	update top (1) Medico 
		set Nombre = @Nombre,
			Apellido = @Apellido,
			Correo = @Correo
	
			where IdMedico = @IdMedico
			set @Resultado = 1
	end
	else
	set @Mensaje = 'El Correo del Usuario ya Existe'
end
go

Create procedure sp_Eliminar_Medico(
@IdMedico  int  ,
@Mensaje varchar(500) output,
@Resultado bit output
)
as 
begin
	set @Resultado = 0
	if not exists (Select * from Cita C
	inner join Medico M on C.IdMedico= M.IdMedico
	where C.IdMedico= @IdMedico)
begin 
delete top (1) from Medico where IdMedico = @IdMedico
set @Resultado = 1
end
else 
set @Mensaje = 'La medito se encuentra relacionada en una cita'

end
GO

---------Especialidades

Create PROCEDURE sp_Registrar_Especialidad(
	@Nombre  nvarchar (50),
	@Descripcion  nvarchar (700),
	@Mensaje varchar (500) output,
	@Resultado int output
	)
	as 
	begin
			SET @Resultado = 0

		IF Not exists (Select * from Especialidad where Nombre = @Nombre)
	begin 
			insert into Especialidad(Nombre,Descripcion)  values (@Nombre,@Descripcion)

			set @Resultado = SCOPE_IDENTITY()
	end
		else
			set @Mensaje = 'La especialidad ya Existe'
	end
	go



	
	CREATE PROCEDURE sp_Editar_Especialidad(
	@IdEspecialidad int,
	@Nombre  nvarchar (50),
	@Descripcion  nvarchar (700),
	@Mensaje varchar (500) output,
	@Resultado int output
 )
 as 
 begin
	SET @Resultado = 0
	IF Not exists (Select * from Especialidad
						where Nombre = @Nombre and IdEspecialidad != @IdEspecialidad)
begin 
	update top (1) Especialidad 
		set Nombre = @Nombre,
			Descripcion = @Descripcion
	
			where IdEspecialidad = @IdEspecialidad
			set @Resultado = 1
	end
	else
	set @Mensaje = 'la especialidad ya Existe'
end
go

Create procedure sp_Eliminar_Especialidad(
@IdEspecialidad  int  ,
@Mensaje varchar(500) output,
@Resultado bit output
)
as 
begin
	set @Resultado = 0
	if not exists (Select * from Especialista e
	inner join Especialidad es  on es.IdEspecialidad = e.IdEspecialidad
	where es.IdEspecialidad= @IdEspecialidad)
begin 
delete top (1) from Especialidad where IdEspecialidad = @IdEspecialidad
set @Resultado = 1
end
else 
set @Mensaje = 'La especialidad se encuentra relacionada con especialista'

end
GO




------mes

create PROCEDURE sp_Registrar_Mes(
	@IdMes  int,
	@Nombre nvarchar (30),
	@Mensaje varchar (500) output,
	@Resultado int output
	)
	as 
	begin
			SET @Resultado = 0

		IF Not exists (Select * from Mes where Nombre = @Nombre)
	begin 
			insert into Mes(Nombre)  values (@Nombre)

			set @Resultado = SCOPE_IDENTITY()
	end
		else
			set @Mensaje = 'La mes ya Existe'
	end
	go



		create PROCEDURE sp_Editar_Mes(
	@IdMes int,
	@Nombre  nvarchar (50),
	@Mensaje varchar (500) output,
	@Resultado int output
 )
 as 
 begin
	SET @Resultado = 0
	IF Not exists (Select * from Mes
						where Nombre = @Nombre and IdMes != @IdMes)
begin 
	update top (1) Mes 
		set Nombre = @Nombre
		
		
	
			where IdMes = @IdMes
			set @Resultado = 1
	end
	else
	set @Mensaje = 'El mes ya Existe'
end
go

Create  procedure sp_Eliminar_Mes(
@IdMes  int  ,
@Mensaje varchar(500) output,
@Resultado bit output
)
as 
begin
	set @Resultado = 0
	if not exists (Select * from PagoMensualidad p
	inner join Mes  e on e.IdMes= p.IdMes
	where p.IdMes= @IdMes)
begin 
delete top (1) from Mes where IdMes = @IdMes
set @Resultado = 1
end
else 
set @Mensaje = 'El mes se encuentra relacionada con un pago del paciente'

end
GO

-----Turno
Create PROCEDURE sp_Registrar_Turno(
	@Horario nvarchar (50),
	@Mensaje varchar (500) output,
	@Resultado int output
	)
	as 
	begin
			SET @Resultado = 0

		IF Not exists (Select * from Turno where Horario = @Horario)
	begin 
			insert into Turno(Horario)  values (@Horario)

			set @Resultado = SCOPE_IDENTITY()
	end
		else
			set @Mensaje = 'El horario ya existe ya Existe'
	end
	go

			create PROCEDURE sp_Editar_Turno(
	@NoTurno int,
	@Horario  nvarchar (50),
	@Mensaje varchar (500) output,
	@Resultado int output
 )
 as 
 begin
	SET @Resultado = 0
	IF Not exists (Select * from Turno
						where Horario = @Horario and NoTurno != @NoTurno)
begin 
	update top (1) Turno 
		set Horario = @Horario
		
		
	
			where NoTurno = @NoTurno
			set @Resultado = 1
	end
	else
	set @Mensaje = 'El turno ya Existe'
end
go

Create  procedure sp_Eliminar_Turno(
@NoTurno  int  ,
@Mensaje varchar(500) output,
@Resultado bit output
)
as 
begin
	set @Resultado = 0
	if not exists (Select * from Cita c
	inner join Turno t   on c.NoTurno = t.NoTurno
	where c.NoTurno=@NoTurno )
begin 
delete top (1) from Turno where NoTurno = @NoTurno
set @Resultado = 1
end
else 
set @Mensaje = 'El turno se encuentra relacionada con una cita de un paciente'

end
GO

-------Estado 

Create PROCEDURE sp_Registrar_Estado(
	@Descripcion nvarchar (100),
	@Mensaje varchar (500) output,
	@Resultado int output
	)
	as 
	begin
			SET @Resultado = 0

		IF Not exists (Select * from Estado where Descripcion = @Descripcion)
	begin 
			insert into Estado(Descripcion)  values (@Descripcion)

			set @Resultado = SCOPE_IDENTITY()
	end
		else
			set @Mensaje = 'El estado ya existe ya Existe'
	end
	go


	create PROCEDURE sp_Editar_Estado(
	@IdEstado int,
	@Descripcion  nvarchar (100),
	@Mensaje varchar (500) output,
	@Resultado int output
 )
 as 
 begin
	SET @Resultado = 0
	IF Not exists (Select * from Estado
						where Descripcion = @Descripcion and IdEstado != @IdEstado)
begin 
	update top (1) Estado 
		set Descripcion = @Descripcion
		
		
	
			where IdEstado = @IdEstado
			set @Resultado = 1
	end
	else
	set @Mensaje = 'El estado ya Existe'
end
go


Create  procedure sp_Eliminar_Estado(
@IdEstado  int  ,
@Mensaje varchar(500) output,
@Resultado bit output
)
as 
begin
	set @Resultado = 0
	if not exists (Select * from Cita c
	inner join Estado e   on c.IdEstado = e.IdEstado
	where c.IdEstado=@IdEstado )
begin 
delete top (1) from Estado where IdEstado = @IdEstado
set @Resultado = 1
end
else 
set @Mensaje = 'El estado se encuentra relacionada con una cita de un paciente'

end
GO

-----Especialistas
Create PROCEDURE sp_Registrar_Especialista(
	@Nombre  nvarchar (50),
		@Apellido  nvarchar (50),
			@IdEspecialidad int,
	@Mensaje varchar (500) output,
	@Resultado int output
	)
	as 
	begin
			SET @Resultado = 0

		
	 
			insert into Especialista(Nombre,Apellido,IdEspecialidad)  values (@Nombre,@Apellido,@IdEspecialidad)

			set @Resultado = SCOPE_IDENTITY()

	end
	go

		create PROCEDURE sp_Editar_Especialista(
	@IdEspecialista int ,
	@Nombre  nvarchar (50),
		@Apellido  nvarchar (50),
			@IdEspecialidad int,
	@Mensaje varchar (500) output,
	@Resultado int output
 )
 as 
 begin
	SET @Resultado = 0
	IF Not exists (Select * from Especialista
						where Nombre = @Nombre and IdEspecialista != @IdEspecialista)
begin 
	update top (1) Especialista 
		set Nombre = @Nombre,
			Apellido = @Apellido,
			IdEspecialidad= @IdEspecialidad

			where IdEspecialista = @IdEspecialista
			set @Resultado = 1
	end
	else
	set @Mensaje = 'El Especialista ya Existe'
end
go




Create  procedure sp_Eliminar_Especialista(
@IdEspecialista  int  ,
@Mensaje varchar(500) output,
@Resultado bit output
)
as 
begin
	set @Resultado = 0
	if not exists (Select * from Cita c
	inner join Especialista e   on c.IdEspecialista = e.IdEspecialista
	where c.IdEspecialista=@IdEspecialista )
begin 
delete top (1) from Especialista where IdEspecialista = @IdEspecialista
set @Resultado = 1
end
else 
set @Mensaje = 'El Esepecialista se encuentra relacionada con una cita de un paciente'

end
go
--------- Enfermeros
Create PROCEDURE sp_Registrar_Enfermero(

	@Nombre nvarchar (50),
		@Apellido nvarchar (50),
			@CodigoConstancia int,
				@EstudiosRealizados nvarchar (500),
	@Mensaje varchar (500) output,
	@Resultado int output
	)
	as 
	begin
			SET @Resultado = 0

		
			insert into Enfermero(Nombre,Apellido,CodigoConstancia,EstudiosRealizados)  values (@Nombre,@Apellido,@CodigoConstancia,@EstudiosRealizados)

			set @Resultado = SCOPE_IDENTITY()
	
	end
	go



		Create PROCEDURE sp_Editar_Enfermero(
		@IdEnfermero int,
     @Nombre nvarchar (50),
	@Apellido nvarchar (50),
	@CondigoConstancia int,
	@EstudiosRealizados nvarchar (500),
	@Mensaje varchar (500) output,
	@Resultado int output
 )
 as 
 begin
	SET @Resultado = 0
 
	update top (1) Enfermero  
		set Nombre = @Nombre,
			Apellido =@Apellido,
			CodigoConstancia = @CondigoConstancia,
			EstudiosRealizados = @EstudiosRealizados

		
		
	
			where IdEnfermero  = @IdEnfermero
			set @Resultado = 1
	
end
go






Create  procedure sp_Eliminar_Enfermero(
@IdEnfermero int  ,
@Mensaje varchar(500) output,
@Resultado bit output
)
as 
begin
	set @Resultado = 0
	if not exists (Select * from Cita c
	inner join Enfermero e   on c.IdEnfermero = e.IdEnfermero
	where c.IdEnfermero=@IdEnfermero )
begin 
delete top (1) from Enfermero where IdEnfermero = @IdEnfermero
set @Resultado = 1
end
else 
set @Mensaje = 'El Enfermero se encuentra relacionada con una cita de un paciente'

end
GO


------Fundacion


Create PROCEDURE sp_Registrar_Fundacion(

	@Nombre nvarchar (50),
	@Direccion nvarchar (500),
	@Descripcion nvarchar (500),
	@Mensaje varchar (500) output,
	@Resultado int output
	)
	as 
	begin
			SET @Resultado = 0

		
			insert into Fundacion(Nombre,Direccion,Descripcion)  values (@Nombre,@Direccion,@Descripcion)

			set @Resultado = SCOPE_IDENTITY()
	
	end
	go




Create PROCEDURE sp_Editar_Fundacion(
	@IdFundacion int,
    @Nombre nvarchar (50),
	@Direccion nvarchar (500),
	@Descripcion nvarchar (500),
	@Mensaje varchar (500) output,
	@Resultado int output
 )
 as 
 begin
	SET @Resultado = 0
 
	update top (1) Fundacion  
		set Nombre = @Nombre,
			Direccion =@Direccion,
			Descripcion = @Descripcion

		
		
	
			where IdFundacion  = @IdFundacion
			set @Resultado = 1
	
end
go


Create  procedure sp_Eliminar_Fundacion(
@IdFundacion int  ,
@Mensaje varchar(500) output,
@Resultado bit output
)
as 
begin
	set @Resultado = 0
	if not exists (Select * from GastoFundacion g
	inner join Fundacion f  on g.IdFundacion = f.IdFundacion
	where g.IdFundacion=@IdFundacion )
begin 
delete top (1) from Fundacion where IdFundacion = @IdFundacion
set @Resultado = 1
end
else 
set @Mensaje = 'La fundacion se encuentra relacionada tiene gastos, no se puede eliminar'

end
GO



-------Gastos 
Create PROCEDURE sp_Registrar_Gasto(

	@Nombre nvarchar (40),
	@Monto decimal (10,2),
	@Descripcion nvarchar (500),
	@Mensaje varchar (500) output,
	@Resultado int output
	)
	as 
	begin
			SET @Resultado = 0

		
			insert into Gasto(Nombre,Monto,Descripcion)  values (@Nombre,@Monto,@Descripcion)

			set @Resultado = SCOPE_IDENTITY()
	
	end
	go


Create PROCEDURE sp_Editar_Gasto(
	@IdGasto int,
	@Nombre nvarchar (40),
	@Monto decimal (10,2),
	@Descripcion nvarchar (500),
	@Mensaje varchar (500) output,
	@Resultado int output
 )
 as 
 begin
	SET @Resultado = 0
 
	update top (1) Gasto  
		set Nombre = @Nombre,
			Monto =@Monto,
			Descripcion = @Descripcion
		where IdGasto  =@IdGasto
		set @Resultado = 1
	
end
go


Create  procedure sp_Eliminar_Gasto(
@IdGasto int  ,
@Mensaje varchar(500) output,
@Resultado bit output
)
as 
begin
	set @Resultado = 0
	if not exists (Select * from GastoFundacion gf
	inner join Gasto g  on gf.IdGasto = g.IdGasto
	where gf.IdGasto=@IdGasto )
begin 
delete top (1) from Gasto where IdGasto = @IdGasto
set @Resultado = 1
end
else 
set @Mensaje = 'El gasto lo a hecho la fundacion, no se puede eliminar'

end
GO


--CREATE PROCEDURE  buscarEspecialidad 
--@Consulta nvarchar (50),
--@Cantidad int
--as
--begin 
--	Set nocount on;
	
--	select top (@Cantidad)
--	IdEspecialidad,
--	Nombre,
--	Descripcion
--	from Especialidad
--	where Nombre like '%'+ @Consulta +'%'

--end 
--go
-----Gastos de la fundacion 
Create PROCEDURE sp_Registrar_GastosFundacion(
	@IdFundacion  int ,
	@IdGasto  int,
	@Mensaje varchar (500) output,
	@Resultado int output
	)
	as 
	begin
			SET @Resultado = 0

		
	 
			insert into GastoFundacion (IdFundacion,IdGasto)  values (@IdFundacion,@IdGasto)

			set @Resultado = SCOPE_IDENTITY()

	end
	go

		Create PROCEDURE sp_Editar_GastosFundacion(
	@NoGasto int, 
	@IdFundacion int ,
	@IdGasto  int ,

	@Mensaje varchar (500) output,
	@Resultado int output
 )
 as 
 begin
	SET @Resultado = 0

	update top (1) GastoFundacion 
		set IdFundacion = @IdFundacion,
			IdGasto = @IdGasto

			where NoGasto = @NoGasto
			set @Resultado = 1
	
end
go




Create  procedure sp_Eliminar_GastoFundacion(
@NoGasto  int  ,
@Mensaje varchar(500) output,
@Resultado bit output
)
as 
begin
	set @Resultado = 0

delete top (1) from GastoFundacion where NoGasto = @NoGasto
set @Resultado = 1

end
go




---------buscarPacinte 


alter procedure SP_Buscar_Paciente (
@IdCita int
)
AS
Begin 
select c.IdCita,CONCAT(P.Nombre, ' ', P.Apellido)Nombre,
c.Cintomas,c.Resultados,c.Observaciones
 from Cita c
 Inner join Paciente P on p.NoPaciente = c.NoPaciente
 where c.IdCita = @IdCita

 end
 go 


 -----buscarFicha
 create procedure SP_Buscar_Ficha ( 
@IdCita int
)
AS
Begin 
select c.IdCita,c.FechaRegistro,c.Cintomas, CONCAT(es.Nombre, ' ', es.Apellido,' -> ',esp.Nombre)Especialista, 
CONCAT(P.Nombre, ' ', P.Apellido)Paciente,
c.Resultados,
	 ( SELECT    d.nombre+', ' 

	 FROM Gastos_Medicos  gm
	 inner join DescripcionCita d  on gm.IdDescripcionCita = d.IdDescripcionCita
	 WHERE      gm.IdCita = @IdCita
	 order by d.Idtipo asc
	 FOR XML PATH ('') ) as MedicamentosExamanes,
	 c.Observaciones
 from Cita c
 Inner join Paciente P on p.NoPaciente = c.NoPaciente
 Inner join Especialista es on c.IdEspecialista=es.IdEspecialista
 inner join Especialidad esp on es.IdEspecialidad = esp.IdEspecialidad
 where c.IdCita = @IdCita

 end
 go



 



 --------Paciente


 
Create PROCEDURE sp_Registrar_Paciente(

	@Dpi int,
	@Nombre nvarchar (50),
	@Apellido nvarchar (60),
	@Enfermedad nvarchar (80),
	@edad  int,
	@Correo nvarchar (50),
	@Mensaje varchar (500) output,
	@Resultado int output
	)
	as 
	begin
			SET @Resultado = 0

		
			insert into Paciente (Dpi,Nombre,Apellido,Enfermedad,edad,Correo)  values (@Dpi,@Nombre,@Apellido,@Enfermedad,@edad,@Correo)

			set @Resultado = SCOPE_IDENTITY()
	
	end
	go




Create PROCEDURE sp_Editar_Paciente(
	@NoPaciente int,
	@Dpi int,
	@Nombre nvarchar (50),
	@Apellido nvarchar (60),
	@Enfermedad nvarchar (80),
	@edad  int,
	@Correo nvarchar (50),
	@Mensaje varchar (500) output,
	@Resultado int output
 )
 as 
 begin
	SET @Resultado = 0
 
	update top (1) Paciente  
		set Dpi = @Dpi,
			Nombre =@Nombre,
			Apellido = @Apellido,
			Enfermedad = @Enfermedad,
			edad = @edad,
			Correo = @Correo


		
	
			where NoPaciente  = @NoPaciente
			set @Resultado = 1
	
end
go


Create  procedure sp_Eliminar_Paciente(
@NoPaciente int  ,
@Mensaje varchar(500) output,
@Resultado bit output
)
as 
begin
	set @Resultado = 0
	if not exists (Select * from Cita c
	inner join Paciente p  on c.NoPaciente= p.NoPaciente
	where c.NoPaciente=@NoPaciente )
begin 
delete top (1) from Paciente where NoPaciente = @NoPaciente
set @Resultado = 1
end
else 
set @Mensaje = 'La paciente se encuentra relacionada con una cita'

end
GO
------Cita


create PROCEDURE sp_Registrar_Cita(

	@IdMedico Int ,
	@NoPaciente Int,
	@Cintomas Nvarchar (80) ,
	@IdEspecialista Int ,
	@IdEnfermero Int ,
	@PrecioCita decimal (10,2),
	@IdEstado int,
	@NoTurno int,
	@Mensaje varchar (500) output,
	@Resultado int output
	)
	as 
	begin
			SET @Resultado = 0

		
			insert into Cita(IdMedico,NoPaciente,Cintomas,IdEspecialista,IdEnfermero,PrecioCita,IdEstado,NoTurno)  
			values (@IdMedico,@NoPaciente,@Cintomas,@IdEspecialista,@IdEnfermero,@PrecioCita,@IdEstado,@NoTurno)

			set @Resultado = SCOPE_IDENTITY()
	
	end
	go




Create PROCEDURE sp_Editar_Cita(
	@IdCita int,
	@IdMedico Int ,
	@NoPaciente Int,
	@Cintomas Nvarchar (80) ,
	@IdEspecialista Int ,
	@IdEnfermero Int ,
	@PrecioCita decimal (10,2),
	@IdEstado int,
	@Mensaje varchar (500) output,
	@Resultado int output
 )
 as 
 begin
	SET @Resultado = 0
 
	update top (1) Cita  
		set IdMedico = @IdMedico,
			NoPaciente =@NoPaciente,
			Cintomas = @Cintomas,
			IdEspecialista = @IdEspecialista,
			IdEnfermero = @IdEnfermero,
			PrecioCita = @PrecioCita,
			IdEstado = @IdEstado


		
	
			where IdCita  = @IdCita
			set @Resultado = 1
	
end
go


Create  procedure sp_Eliminar_Cita(
@IdCita int  ,
@Mensaje varchar(500) output,
@Resultado bit output
)
as 
begin
	set @Resultado = 0
	if not exists (Select * from Gastos_Medicos  gm
	inner join Cita c  on  c.IdCita = gm.IdCita
	where gm.IdCita=@IdCita )
begin 
delete top (1) from Cita where IdCita = @IdCita
set @Resultado = 1
end
else 
set @Mensaje = 'Tienes gastos medicos no se puede eliminar'

end
GO




-------adignacion de horario

Create PROCEDURE sp_Asignacion_Horarios(
	@IdCita int,
	@NoTurno int,
	@IdEstado int,
	@Mensaje varchar (500) output,
	@Resultado int output
 )
 as 
 begin
	SET @Resultado = 0
 
	update top (1) Cita  
		set 
			NoTurno= @NoTurno,
			IdEstado = @IdEstado
			where IdCita  = @IdCita
			set @Resultado = 1
	
end
go
-----examanes
create PROCEDURE sp_Registrar_Examen(

	@nombre nvarchar (40),
	@precio decimal (10,2),
	@descripcion nvarchar (500),
	@Idtipo int,
	@Mensaje varchar (500) output,
	@Resultado int output
	)
	as 
	begin
			SET @Resultado = 0


		
			insert into DescripcionCita (nombre,precio,descripcion,Idtipo)  
			values (@nombre,@precio,@descripcion,@Idtipo)

			set @Resultado = SCOPE_IDENTITY()
	
	end
go


create	 PROCEDURE sp_Editar_Examen(
	@IdDescripcionCita int,
	@nombre nvarchar (40),
	@precio decimal (10,2),
	@descripcion nvarchar (500),
	@Mensaje varchar (500) output,
	@Resultado int output
 )
 as 
 begin
	SET @Resultado = 0
 
	update top (1) DescripcionCita  
		set nombre = @nombre,
			precio =@precio,
			descripcion = @descripcion
			where IdDescripcionCita  = @IdDescripcionCita
			set @Resultado = 1
	
end
go


Create  procedure sp_Eliminar_Examen(
@IdDescripcionCita int  ,
@Mensaje varchar(500) output,
@Resultado bit output
)
as 
begin
	set @Resultado = 0
	if not exists (Select * from Gastos_Medicos  dm
	inner join DescripcionCita dc on  dm.IdDescripcionCita = dc.IdDescripcionCita
	where dm.IdDescripcionCita=@IdDescripcionCita )
begin 
delete top (1) from DescripcionCita where IdDescripcionCita = @IdDescripcionCita
set @Resultado = 1
end
else 
set @Mensaje = 'el examen esta relacionado con una cita'

end
GO
-------medicamento
create PROCEDURE sp_Registrar_Medicamento(

	@nombre nvarchar (40),
	@precio decimal (10,2),
	@descripcion nvarchar (500),
	@Idtipo int,
	@Mensaje varchar (500) output,
	@Resultado int output
	)
	as 
	begin
			SET @Resultado = 0


		
			insert into DescripcionCita (nombre,precio,descripcion,Idtipo)  
			values (@nombre,@precio,@descripcion,@Idtipo)

			set @Resultado = SCOPE_IDENTITY()
	
	end
go

create	 PROCEDURE sp_Editar_Medicamento(
	@IdDescripcionCita int,
	@nombre nvarchar (40),
	@precio decimal (10,2),
	@descripcion nvarchar (500),
	@Mensaje varchar (500) output,
	@Resultado int output
 )
 as 
 begin
	SET @Resultado = 0
 
	update top (1) DescripcionCita  
		set nombre = @nombre,
			precio =@precio,
			descripcion = @descripcion
			where IdDescripcionCita  = @IdDescripcionCita
			set @Resultado = 1
	
end
go


Create  procedure sp_Eliminar_Medicamento(
@IdDescripcionCita int  ,
@Mensaje varchar(500) output,
@Resultado bit output
)
as 
begin
	set @Resultado = 0
	if not exists (Select * from Gastos_Medicos  dm
	inner join DescripcionCita dc on  dm.IdDescripcionCita = dc.IdDescripcionCita
	where dm.IdDescripcionCita=@IdDescripcionCita )
begin 
delete top (1) from DescripcionCita where IdDescripcionCita = @IdDescripcionCita
set @Resultado = 1
end
else 
set @Mensaje = 'el medicamento esta relacionado con una cita'

end
GO

----descripcion de la cita
create PROCEDURE sp_Registrar_Gastos_Medicos(

	@IdCita int,
	@IdDescripcionCita int,
	@Cantidad int,
	@Mensaje varchar (500) output,
	@Resultado int output
	)
	as 
	begin
			SET @Resultado = 0


		
			insert into Gastos_Medicos(IdCita,IdDescripcionCita,Cantidad)  
			values (@IdCita,@IdDescripcionCita,@Cantidad)

			set @Resultado = SCOPE_IDENTITY()
	
	end
go

 create procedure SP_Mostrar_Gasto(
 @IdCita int

 )
as
begin
	select gm.IdCita,d.IdDescripcionCita, d.nombre,d.descripcion from Gastos_Medicos gm
	inner join DescripcionCita d on gm.IdDescripcionCita=d.IdDescripcionCita
	where gm.IdCita=2 and d.Idtipo = 1

end

go

 create procedure SP_Mostrar_Medicamentos(
 @IdCita int

 )
as
begin
select  gm.IdCita,d.IdDescripcionCita, d.nombre,d.descripcion from Gastos_Medicos gm
inner join DescripcionCita d on gm.IdDescripcionCita=d.IdDescripcionCita
where gm.IdCita=@IdCita and d.Idtipo = 2

end

go

----Agenda del especialista
create  procedure Agenda (
@IdEspecialidad int
)
as
begin
	Select c.IdCita, CONCAT(p.Nombre,' ',p.Apellido) [Paciente],
			esp.Nombre[Especialidad], t.Horario
	from   Cita c
	Inner join Paciente p on c.NoPaciente =  p.NoPaciente
	inner join Especialista es on c.IdEspecialista = es.IdEspecialista
	inner join Especialidad esp on es.IdEspecialidad = esp.IdEspecialidad
	inner join Turno t on c.NoTurno = t.NoTurno
	where t.NoTurno !=1 and esp.IdEspecialidad=@IdEspecialidad

end
go

----Dar resultados

create procedure SP_Dar_Resultados(
@IdCita int,
@Resultados nvarchar (500),
@Mensaje varchar (500) output,
@Resultado int output
)
As
Begin
SET @Resultado = 0
	update Cita set Resultados = @Resultados
	Where IdCita = @IdCita
	SET @Resultado = 1

End
go

----Dar Observaciones

create procedure SP_Dar_Observaciones(
@IdCita int,
@Observaciones nvarchar (800),
@Mensaje varchar (500) output,
@Resultado int output
)
As
Begin
SET @Resultado = 0
	update Cita set Observaciones = @Observaciones
	Where IdCita = @IdCita
	SET @Resultado = 1

End
go

----actualizar estado

Create procedure SP_Actulizar_Estado_Cita(
@IdCita int,
@IdEstado int,
@Mensaje varchar (500) output,
@Resultado int output
)
As
Begin
SET @Resultado = 0
	update Cita set IdEstado =@IdEstado
	Where IdCita = @IdCita
	SET @Resultado = 1

End
go


----- Listar Cita
create procedure SP_Detalle_Cita(
@IdCita int
)
as
begin
 select c.IdCita, d.nombre[Descripcion], d.precio[Precio],g.Cantidad[Cantidad],g.Cantidad *d.precio as [SubTotal]
 from Gastos_Medicos  g inner join DescripcionCita d on g.IdDescripcionCita = d.IdDescripcionCita
 inner join Cita c on c.IdCita = g.IdCita
 where c.IdCita=@IdCita
 union  all
 select c.IdCita, 'Cita' [Descripcion] ,c.PrecioCita [Precio] ,1 [Cantidad],c.PrecioCita * 1 as [SubTotal]
 from cita c 
 where c.IdCita =@IdCita

 end
 go



-----total
create  procedure SP_Calcular_Total(
@IdCita int
)
as
begin
	select (Sum (g.Cantidad * d.precio) )+ c.PrecioCita +0[Total]
	from Gastos_Medicos  g inner join DescripcionCita d on g.IdDescripcionCita = d.IdDescripcionCita
	inner join Cita c on c.IdCita = g.IdCita
	 where g.IdCita=@IdCita
	 group by c.PrecioCita

end
go

------SP_cita
create  procedure SP_Cita(
@IdCita int
)
as
begin
	 select  CONCAT(p.Nombre,' ',p.Apellido) [Paciente], p.Correo ,p.Dpi,CONCAT(esp.Nombre,' ',esp.Apellido,' especialista en ', es.Nombre)[Especialista] 
	 from Cita  c inner join Paciente p on c.NoPaciente = p.NoPaciente
	 inner join Especialista esp on esp.IdEspecialista = c.IdEspecialista
	 inner join Especialidad es on es.IdEspecialidad = esp.IdEspecialidad
	
	 where c.IdCita=@IdCita

 end
 go
 ------sp pago de mensualidad

 create PROCEDURE sp_Registrar_Pago_Mesaulidad(

	@NoPaciente int,
	@PrecioMensualidad decimal,
	@IdMes int,
	@Mensaje varchar (500) output,
	@Resultado int output
	)
	as 
	begin
			SET @Resultado = 0


		
			insert into PagoMensualidad(NoPaciente,PrecioMensualidad,IdMes)  
			values (@NoPaciente,@PrecioMensualidad,@IdMes)

			set @Resultado = SCOPE_IDENTITY()
	
	end
go


		Create PROCEDURE sp_Editar_pago(
	@IdPago int,
	@NoPaciente int,
	@PrecioMensualidad decimal,
	@IdMes int,
	@Mensaje varchar (500) output,
	@Resultado int output
 )
 as 
 begin
	SET @Resultado = 0
 
	update top (1) PagoMensualidad  
		set NoPaciente = @NoPaciente,
			PrecioMensualidad =@PrecioMensualidad,
			IdMes = @IdMes
			where IdPago  = @IdPago
			set @Resultado = 1
	
end
go

Create  procedure sp_Eliminar_Pago_Mensualidad(
@IdPago int  ,
@Mensaje varchar(500) output,
@Resultado bit output
)
as 
begin

delete top (1) from PagoMensualidad where IdPago = @IdPago
set @Resultado = 1
end
GO

select pg.IdPago, p.NoPaciente,p.Nombre[nomPaciente],p.Apellido,
m.IdMes,m.Nombre [nomMes],pg.PrecioMensualidad, pg.FechaPago
from PagoMensualidad pg
inner join Paciente p on p.NoPaciente = pg.NoPaciente
inner join Mes m on m.IdMes = pg.IdMes

-----donacion
 create PROCEDURE sp_Registrar_Donacion(

	@Dondate nvarchar(30) ,
	@Cantidad decimal (10,2),
	@IdFundacion int ,
	@Mensaje varchar (500) output,
	@Resultado int output
	)
	as 
	begin
			SET @Resultado = 0


		
			insert into Donacion (Dondate,Cantidad,IdFundacion)  
			values (@Dondate,@Cantidad,@IdFundacion)

			set @Resultado = SCOPE_IDENTITY()
	
	end
go

Create PROCEDURE sp_Editar_Donacion(
	@IdDonacion int,
	@Dondate nvarchar(30) ,
	@Cantidad decimal (10,2),
	@IdFundacion int ,
	@Mensaje varchar (500) output,
	@Resultado int output
 )
 as 
 begin
	SET @Resultado = 0
 
	update top (1) Donacion  
		set Dondate = @Dondate,
			Cantidad =@Cantidad,
			IdFundacion = @IdFundacion
			where IdDonacion  = @IdDonacion
			set @Resultado = 1
	
end
go

Create  procedure sp_Eliminar_Donacion(
@IdDonacion int  ,
@Mensaje varchar(500) output,
@Resultado bit output
)
as 
begin

delete top (1) from Donacion where IdDonacion = @IdDonacion
set @Resultado = 1
end
GO
--reportes 
create procedure SP_Reporte3(
@fechaDeInicio varchar (10),
@fechaDeFin varchar (10)
)
as
begin
set dateformat dmy;
SELECT CONVERT(char(10),c.FechaRegistro,103) As [Fecha], concat( p.Nombre,' ',p.Apellido) Paciente ,(Sum (g.Cantidad * d.precio) )+ c.PrecioCita +0[Total], 'Por medicamentos, examanes y por cita' as Descripcion
	from Gastos_Medicos  g inner join DescripcionCita d on g.IdDescripcionCita = d.IdDescripcionCita
	inner join Cita c on c.IdCita = g.IdCita
	inner join Paciente p on p.NoPaciente = c.NoPaciente

	where convert(date, c.FechaRegistro) between @fechaDeInicio and @fechaDeFin
	 group by c.PrecioCita,p.Nombre,p.Apellido,C.FechaRegistro


 end
 go



 create procedure SP_Reporte2 
 as
 begin
	select  c.IdCita, CONCAT( p.Nombre ,' ' , p.Apellido) Paciente , c.Cintomas,
	 (SELECT    d.nombre+', ' 

	 FROM Gastos_Medicos  gm
	 inner join DescripcionCita d  on gm.IdDescripcionCita = d.IdDescripcionCita
	 WHERE   d.Idtipo =2  and  gm.IdCita = c.IdCita
	 FOR XML PATH ('')) as Medicamentos,
	 (SELECT    d.nombre+', ' 
	 FROM Gastos_Medicos  gm
	 inner join DescripcionCita d  on gm.IdDescripcionCita = d.IdDescripcionCita
	 WHERE   d.Idtipo =1  and  gm.IdCita = c.IdCita
	 FOR XML PATH ('')) as Examanes
	from cita  c
	inner join Paciente p on p.NoPaciente = c.NoPaciente
	order by c.IdCita desc
end 
go

 create procedure SP_Reporte4
 as
 begin
	select pm.IdPago, CONCAT(p.Nombre,' ',p.Apellido) Paciente,
			pm.PrecioMensualidad,CONVERT(char(10),pm.FechaPago,103) Fecha,
			'Pago de Mesualidad' Descripcion
	from PagoMensualidad pm
	inner join Mes m on  m.IdMes = pm.IdMes
	inner join Paciente p on p.NoPaciente = pm.NoPaciente
end 
go

 create  procedure SP_Reporte5
 as
 begin

	Select CONVERT(char(10),d.FechaDonacion,103) As [Fecha],	d.Dondate as Persona,d.Cantidad,'Donacion' Descripcion
	From Donacion d 
	union  all
	select CONVERT(char(10),c.FechaRegistro ,103) As [Fecha] ,CONCAT(p.Nombre,' ',p.Apellido) as Persona,   (Sum (gm.Cantidad * d.precio) ) + c.PrecioCita as Cantidad,
		'Cobro por gastos medicos y  cita' Descripcion
	 from Gastos_Medicos   gm
	 inner join DescripcionCita d on gm.IdDescripcionCita= d.IdDescripcionCita
	 inner join Cita c on gm.IdCita = c.IdCita
	 inner join Paciente p on p.NoPaciente = c.NoPaciente
	 group by gm.IdCita,c.PrecioCita ,c.IdCita,p.Nombre,p.Apellido,c.FechaRegistro
	 union all
	 select CONVERT(char(10),pm.FechaPago,103) As [Fecha],CONCAT(p.Nombre,' ',p.Apellido) as Persona,pm.PrecioMensualidad  Cantidad,'Cobro de mensaulidad' Descripcion
	 from PagoMensualidad pm inner join Paciente p on p.NoPaciente = pm.NoPaciente



end 
go

exec SP_Reporte6

 create  procedure SP_Reporte6
 as
 begin

	 select c.IdCita,Concat (  p.Nombre,' ' , p.Apellido ) as Paciente,
	 (select count( gm.IdDescripcionCita)
	 from Gastos_Medicos  gm
	 inner join DescripcionCita d  on gm.IdDescripcionCita = d.IdDescripcionCita
	 where d.Idtipo =1  and  gm.IdCita = c.IdCita
	 ) as cantidad,
	 (SELECT    d.nombre+', ' 
	 FROM Gastos_Medicos  gm
	 inner join DescripcionCita d  on gm.IdDescripcionCita = d.IdDescripcionCita
	 WHERE   d.Idtipo =1  and  gm.IdCita = c.IdCita
	 FOR XML PATH ('')) as Examanes
	 from Cita c inner join Paciente p on c.NoPaciente =p.NoPaciente

end 
go



 create   procedure SP_Reporte7
 as
 begin

	 select c.IdCita,Concat (  p.Nombre,' ' , p.Apellido ) as Paciente,
	 (select count( gm.IdDescripcionCita)
	 from Gastos_Medicos  gm
	 inner join DescripcionCita d  on gm.IdDescripcionCita = d.IdDescripcionCita
	 where d.Idtipo =2  and  gm.IdCita = c.IdCita
	 ) as cantidad,
	 (SELECT    d.nombre+', ' 
	 FROM Gastos_Medicos  gm
	 inner join DescripcionCita d  on gm.IdDescripcionCita = d.IdDescripcionCita
	 WHERE   d.Idtipo =2  and  gm.IdCita = c.IdCita
	 FOR XML PATH ('')) as Medicamentos
	 from Cita c inner join Paciente p on c.NoPaciente =p.NoPaciente

end 
go 

 ------llenado de obligatorio

 insert into TipoDescripcionCita (Nombre) values ('Examen')
insert into TipoDescripcionCita (Nombre) values ('Medicamento')

insert into Turno (Horario) values ('NO TIENE HORARIO')
------


select * from DescripcionCita
 select *  from Paciente
 select *  from cita
 select * from Turno

exec SP_Calcular_Total @IdCita =34



select * from Gastos_Medicos where IdCita=7


exec Agenda @IdEspecialidad=1






delete top (1) from Gastos_Medicos where IdCita=7 and IdDescripcionCita=1



select gm.IdCita,d.IdDescripcionCita, d.nombre,d.descripcion from Gastos_Medicos gm
inner join DescripcionCita d on gm.IdDescripcionCita=d.IdDescripcionCita

select IdDescripcionCita,nombre,precio,descripcion from DescripcionCita  





insert into TipoDescripcionCita (Nombre) values ('Examen')
insert into TipoDescripcionCita (Nombre) values ('Medicamento')


select * from TipoDescripcionCita


insert into DescripcionCita (nombre,precio,descripcion,Idtipo) values ('Examen cardio',389,'espara exa,¿minar el corazon',1)

select * from DescripcionCita

select c.IdCita,CONCAT(p.Nombre,' ',p.Apellido)Paciente,
esp.Nombre[Especialidad],e.IdEstado, e.Descripcion[Estado],t.NoTurno, t.Horario
from cita c
inner join Paciente p on p.NoPaciente = c.NoPaciente
inner join Especialista es on  es.IdEspecialista = c.IdEspecialista
inner join Especialidad esp on esp.IdEspecialidad = es.IdEspecialidad
inner join Estado e on e.IdEstado= c.IdEstado
left  join Turno t on t.NoTurno = c.NoTurno


delete cita where NoTurno = 1

select * from Turno
select * from cita where NoTurno = 1

Select c.IdCita,c.FechaRegistro,m.IdMedico,m.Nombre[Medico],m.Apellido[apMedico],
p.NoPaciente,p.Nombre[Paciente],p.Apellido, c.Cintomas, e.IdEspecialista,e.Nombre,e.Apellido[apEspecialista],
en.IdEnfermero,en.Nombre[Enfermero],en.Apellido[apEnfermero],  c.PrecioCita,  es.IdEstado,es.Descripcion[Estado]
from cita c
Inner join Medico m on m.IdMedico = c.IdMedico
inner join Paciente p on p.NoPaciente = c.NoPaciente
inner join Especialista e on e.IdEspecialista = c.IdEspecialista
inner join Enfermero en on en.IdEnfermero = c.IdEnfermero
inner join Estado es on  es.IdEstado = c.IdEstado
order by c.IdCita desc


Select NoPaciente,Dpi,Nombre, Apellido,Enfermedad,edad,Correo From  Paciente

select * from Cita

 Select gf.NoGasto,f.IdFundacion, f.Nombre[Fundacion],
g.IdGasto,g.Nombre[Gasto],g.Monto,g.Descripcion,gf.FechaRegistro
from GastoFundacion gf 
inner join Fundacion f on f.IdFundacion = gf.IdFundacion
Inner join Gasto g on g.IdGasto = gf.IdGasto
order by  gf.NoGasto desc

 insert into Paciente (Dpi,Nombre,Apellido,Enfermedad,Correo) Values (12235,'Greson','sEGURA','LOCUARA','GMAIL.COM')

select c.IdCita,P.Dpi, P.Nombre,
c.Cintomas,c.Resultados
 from Cita c
 Inner join Paciente P on c.Dpi = c.Dpi


 exec SP_Buscar_Paciente @IdCita = 1
 

 select * from Cita
 select * from Usuario

 select *  from Especialista


 Insert into Usuario (Nombre,Apellido,Correo,Contraseña,rol) values ('Gerson','Segura','admi@gmail.com',12,6)
  Insert into Usuario (Nombre,Apellido,Correo,Contraseña,rol) values ('Gerson','Segura','medico@gmail.com',12,1)
    Insert into Usuario (Nombre,Apellido,Correo,Contraseña,rol) values ('Gerson','Segura','horario@gmail.com',12,2)
  Insert into Usuario (Nombre,Apellido,Correo,Contraseña,rol) values ('Gerson','Segura','medico2@gmail.com',12,6)

 INSERT INTO  Cita (Dpi,Cintomas,Resultados) values (12235,'Dolor de corazon',null)
  INSERT INTO  Cita (Dpi,Cintomas,Resultados) values (12235,'Dolor de pecho','cancer')
    INSERT INTO  Cita (Dpi,Cintomas,Resultados) values (11111,'Dolores en la cabeza y dolor en los pulmones','Vasa los examanes tien sirocis')

  Insert into Paciente (Dpi,Nombre,Apellido,Enfermedad,Correo)  values  (11111,'Davis','Lima','Mucho toma el maje','davisLima@gmail.com')






	create PROCEDURE Prueb_error(

	@IdCita int,
	@IdDescripcionCita int,
	@Cantidad int,
	@Mensaje varchar (500) output,
	@Resultado int output
	)
	as 
	begin
		begin try
			SET @Resultado = 0
	

		
			insert into Gastos_Medicos(IdCita,IdDescripcionCita,Cantidad)  
			values (@IdCita,@IdDescripcionCita,@Cantidad)

			set @Resultado = SCOPE_IDENTITY()
			end try
		begin catch
		print 'errro'
		end catch

	
	end
go

exec Prueb_error @IdCita=7,@IdDescripcionCita=1,@Cantidad ='dfgdfh',@Mensaje='vcbffg',@Resultado=1








	Select CONVERT(char(10),d.FechaDonacion,103) As [Fecha],	d.Dondate as Persona,d.Cantidad,'Donacion' Descripcion
	From Donacion d 
	union  all
	select CONVERT(char(10),c.FechaRegistro ,103) As [Fecha] ,CONCAT(p.Nombre,' ',p.Apellido) as Persona,   (Sum (gm.Cantidad * d.precio) ) + c.PrecioCita as Cantidad,
		'Cobro por gastos medicos y  cita' Descripcion
	 from Gastos_Medicos   gm
	 inner join DescripcionCita d on gm.IdDescripcionCita= d.IdDescripcionCita
	 inner join Cita c on gm.IdCita = c.IdCita
	 inner join Paciente p on p.NoPaciente = c.NoPaciente
	 group by gm.IdCita,c.PrecioCita ,c.IdCita,p.Nombre,p.Apellido,c.FechaRegistro
	 union all
	 select CONVERT(char(10),pm.FechaPago,103) As [Fecha],CONCAT(p.Nombre,' ',p.Apellido) as Persona,pm.PrecioMensualidad  Cantidad,'Cobro de mensaulidad' Descripcion
	 from PagoMensualidad pm inner join Paciente p on p.NoPaciente = pm.NoPaciente


	 
	 select pm.NoPaciente, CONCAT(p.Nombre,' ',p.Apellido) as Persona,
	
	 
	(select   SUM(pm.PrecioMensualidad)
	 from PagoMensualidad pm 
	where pm.NoPaciente =2
	 group by pm.NoPaciente) Cantidad,
	 
	 'Cobro de mensaulidad' Descripcion
	 from PagoMensualidad pm inner join Paciente p on p.NoPaciente = pm.NoPaciente

	 group by pm.NoPaciente,p.Nombre,p.Apellido


