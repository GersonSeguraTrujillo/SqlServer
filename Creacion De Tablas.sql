Create database AsiloDeAncianos 
go

Create table Medico (
IdMedico Int Identity (1,1)Primary Key NOT NULL,
Nombre Nvarchar (50) null,
Apellido Nvarchar (50) null,
Correo Nvarchar(50)null,
)
go

Create Table Paciente (
NoPaciente int identity (1,1) primary key not null,
Dpi Int null,
Nombre Nvarchar (50) NULL,
Apellido Nvarchar (60) NULL,
Enfermedad Nvarchar(80)  NULL,
edad int,
Correo Nvarchar(50) Null
)
go




Create Table Especialidad (
IdEspecialidad Int    Identity (1,1) Primary Key NOT NULL,
Nombre Nvarchar (50) NULL,
Descripcion Nvarchar (700) NULL
)
go

Create Table Especialista (
IdEspecialista Int   Identity (1,1)  Primary Key NOT NULL,
Nombre Nvarchar (50) NULL,
Apellido Nvarchar (50) NULL,
IdEspecialidad int NULL

Foreign Key References Especialidad (IdEspecialidad)
)
go

Create Table Enfermero(
IdEnfermero Int Identity (1,1) Primary Key NOT NULL,
Nombre Nvarchar (50),
Apellido Nvarchar (50),
CodigoConstancia int ,
EstudiosRealizados nvarchar (500)

)
go

Create Table Turno (
NoTurno Int Identity (1,1)  Primary Key NOT NULL,
Horario Nvarchar (50)
)
go


Create Table Estado (
IdEstado Int Identity (1,1) Primary Key Not Null,
Descripcion Nvarchar (100) Null,

)
go
select * from cita 
Create Table Cita (
IdCita Int Identity (1,1) Primary Key NOT NULL,
FechaRegistro datetime default getdate(),
IdMedico Int  NULL,
NoPaciente Int  NULL,
Cintomas Nvarchar (80) NULL,
IdEspecialista Int  NULL,
IdEnfermero Int  NULL,
PrecioCita decimal (10,2) null,
NoTurno Int  NULL,
IdEstado int Null,
Resultados Nvarchar (500) NULL,
 Observaciones nvarchar (800) null
---- Creando llaves forameas
 Constraint  FK_IdMedico Foreign Key (IdMedico) References Medico ( IdMedico),
 Constraint FK_Dpi Foreign Key (NoPaciente) References Paciente (NoPaciente),
 Constraint FK_IdEspecialista Foreign Key (IdEspecialista) References Especialista (IdEspecialista),
 Constraint FK_IdEnfermero Foreign Key (IdEnfermero) References Enfermero (IdEnfermero),
 Constraint FK_NoTurno Foreign Key (NoTurno) References Turno (NoTurno),
 Constraint FK_IdEstado Foreign Key (IdEstado) References Estado (IdEstado)
)
go


--Create Table Examen(
--IdExamen Int Identity (1,1) Primary Key  NOT NULL,
--Nombre Nvarchar (30),
--Precio Decimal (10,2),
--Descripcion Nvarchar (500),

--)
--go

--Create Table Medicamento (
--IdMedicamento Int Identity (1,1) Primary Key NOT NULL,
--Nombre Nvarchar (30),
--Precio Decimal(10,2),
--Descripcion Nvarchar (500)
--)
--Go
Create Table TipoDescripcionCita(
Idtipo Int Identity (1,1) Primary Key Not NUll,
Nombre Nvarchar (30) Null,
)
go

Create Table DescripcionCita(
IdDescripcionCita int identity (1,1) primary  key not null,
nombre nvarchar (40) null,
precio decimal (10,2) null,
descripcion nvarchar (500) null,
Idtipo int null
 Constraint FK_Idtipo Foreign  Key (Idtipo) References TipoDescripcionCita (Idtipo)

)
go 


Create  Table Gastos_Medicos (
IdCita Int NOT NULL,
IdDescripcionCita int,
--IdExamen Int ,
--IdMedicamento Int NULL,
--PrecioConsulta Decimal (10,2),
Cantidad int,

----Creando llaves forraneas
	Constraint FK_IdCita foreign Key (IdCita) References Cita (IdCita),
	Constraint FK_IdDescripcionCita foreign Key (IdDescripcionCita) References DescripcionCita (IdDescripcionCita),
	--Constraint FK_IdExamen foreign Key (IdExamen) References Examen (IdExamen),
	--Constraint FK_IdMedicamento foreign Key (IdMedicamento) References Medicamento (IdMedicamento),

)
go



Create table Fundacion(
IdFundacion Int Identity (1,1) Primary key Not null,
Nombre Nvarchar(50) null,
Direccion Nvarchar(500) null,
Descripcion Nvarchar (500) null
)

Create table Gasto(
IdGasto Int Identity (1,1) Primary Key Not null,
Nombre Nvarchar (40) null,
Monto Decimal(10,2) null,
Descripcion Nvarchar (500)  null
)

create table Donacion(
IdDonacion int identity (1,1) primary key not null,
Dondate nvarchar(30) not null,
Cantidad decimal (10,2),
IdFundacion int null,
FechaDonacion datetime default getdate()
Constraint FK_IdFundacionParaDonacion Foreign Key (IdFundacion) References Fundacion (IdFundacion),

)

Create Table GastoFundacion (
NoGasto int identity (1,1) primary key not null,
IdFundacion int null,
IdGasto int null,
FechaRegistro datetime default getdate()

Constraint FK_IdFundacion Foreign Key (IdFundacion) References Fundacion (IdFundacion),
Constraint FK_IdGasto Foreign Key (IdGasto) References Gasto(IdGasto)
)

create table Mes(
IdMes int  Identity (1,1) Primary key not null,
Nombre Nvarchar (30) null
)
Create table PagoMensualidad (
IdPago Int Identity (1,1) Primary Key Not Null,
NoPaciente int null,
PrecioMensualidad Decimal (10,2) null,
IdMes int null,
FechaPago datetime default getdate()

constraint FK_dpii Foreign key (NoPaciente) references  Paciente (NoPaciente),
constraint FK_IdMes Foreign key (IdMes) references  Mes (IdMes)
)


Create table Usuario(
IdUsuario int identity (1,1) primary key not null,
Nombre Nvarchar (40) null,
Apellido Nvarchar (40) null,
Correo nvarchar (50) null,
Contraseña Nvarchar (600) null,
rol int null
)

 
drop table GastoFundacion


insert into Usuario ( Nombre,Apellido,Correo,Contraseña , rol)  values ('Gerson','segura','admin@gmail.com',12,6)

insert into Usuario ( Nombre,Apellido,Correo,Contraseña , rol)  values ('Gerson','segua','gersonsegura@gmail.com',12,1)
insert into Usuario ( Nombre,Apellido,Correo,Contraseña , rol)  values ('Gerson','segua','gerson@gmail.com',12,2)


select * from Usuario

select IdUsuario,Nombre,Apellido,Correo,Contraseña, rol from  Usuario

select * from Turno


select d.IdDonacion,d.Dondate,d.Cantidad,f.IdFundacion, f.Nombre,d.FechaDonacion
from Donacion d
inner join Fundacion f on f.IdFundacion = d.IdFundacion