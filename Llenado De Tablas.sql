----Llenando tablas medico
Insert  Into Medico (Nombre,Apellido,Correo)Values  ('Sandra','Monrroy', 'Sandra@gmail.com') ;

---- Llenando Tabla Enfermero
Insert Into Enfermero (Nombre,Apellido) Values ('Oseas','Trujillo');

-----Llenando Tabla Especialidad
Insert Into Especialidad (Nombre,Descripcion) Values ('Cardiaologo','Revisa todo lo que tenga que ver con el corazon');

----Llenando Tabla Especialista
Insert Into Especialista (Nombre,Apellido, IdEspecialidad) Values ('Candida','Toraya ',1);

----Llenado tabla Paciente
Insert Into Paciente (Dpi,Nombre,Apellido,Enfermedad) Values (123678,'Remigo','Oajaca','Dolores de huevos y Diabetes');

----Llenado tabla Turno
Insert Into Turno (Horario) Values ('8:00 AM - 9:00 AM');
Insert Into Turno (Horario) Values ('9:00 AM - 10:00 AM');
Insert Into Turno (Horario) Values ('10:00 AM - 11:00 AM');
Insert Into Turno (Horario) Values ('11:00 AM - 12:00 PM');
Insert Into Turno (Horario) Values ('1:00 PM  - 2:00 PM');
Insert Into Turno (Horario) Values ('2:00 PM - 3:00 PM');
Insert Into Turno (Horario) Values ('4:00 PM - 5:00 PM');
Insert Into Turno (Horario) Values ('5:00 PM - 6:00 PM');
Insert Into Turno (Horario) Values ('7:00 PM - 8:00 PM');

---llenado tabla estado
Insert Into Estado (Descripcion)  Values ('Sin turno asignado')
Insert Into Estado (Descripcion)  Values ('Turno asignado')
Insert Into Estado (Descripcion)  Values ('En espera de resultado')
Insert Into Estado (Descripcion)  Values ('Cita Cerrada');
go
----llenando tabla examen
insert into Examen (Nombre,Precio,Descripcion) values ('Eces',200,'sirve para calcular cosas del corazon')
insert into Examen (Nombre,Precio,Descripcion) values ('electrocardiograma ',500,'Prueba de esfuerzo cardíaco con ejercicio.')
--- llenando tabla medicamento
insert into Medicamento (Nombre,Precio,Descripcion) values ('Paracetamol',45,'medicamento para el corazon')
insert into Medicamento (Nombre,Precio,Descripcion) values ('digoxina ',45,'ayudar a incrementar la fuerza de bombeo del corazón .')
insert into Medicamento (Nombre,Precio,Descripcion) values ('hidralazina ',45,'para abrir las arterias y ayudar a que el miocardio bombee mejor.')
insert into Medicamento (Nombre,Precio,Descripcion) values ('Heparina ',45,'Disminuye la capacidad de coagulación de la sangre. ')
go
---llemado de tabla tipoDescripcion
Insert into TipoDescripcionCita (Nombre) values ('Examen')
Insert into TipoDescripcionCita (Nombre) values ('Medicamento')
go
----Llenado tabla descripcioncita
Insert Into DescripcionCita (nombre,precio,descripcion,Idtipo) values ('Eces',200,'sirve para calcular cosas del corazon',1)
Insert Into DescripcionCita (nombre,precio,descripcion,Idtipo) values ('electrocardiograma ',500,'Prueba de esfuerzo cardíaco con ejercicio.',1)
Insert Into DescripcionCita (nombre,precio,descripcion,Idtipo) values ('Paracetamol',45,'medicamento para el corazon',2)
Insert Into DescripcionCita (nombre,precio,descripcion,Idtipo) values ('hidralazina ',45,'para abrir las arterias y ayudar a que el miocardio bombee mejor.',2)
Insert Into DescripcionCita (nombre,precio,descripcion,Idtipo) values ('digoxina ',45,'ayudar a incrementar la fuerza de bombeo del corazón .',2)
Insert Into DescripcionCita (nombre,precio,descripcion,Idtipo) values ('Heparina ',45,'Disminuye la capacidad de coagulación de la sangre. ',2)



----solictud de cita 
select * from Cita
Insert Into Cita (IdMedico,Dpi,Cintomas,IdEspecialista,IdEnfermero,PrecioCita,IdEstado) values (1,123678,'Dolor en el corazon',1,1,300,1)


go
Delete Cita where IdCita = 1
select c.IdCita,c.FechaRegistro,c.IdMedico,c.Dpi,c.Cintomas,c.IdEspecialista,c.IdEnfermero,c.PrecioCita,c.NoTurno,e.Descripcion
from Cita c inner join Estado e on c.IdEstado = e.IdEstado

----asignar turno fundacion
update Cita set cita.NoTurno = 1, cita.IdEstado = 2
Where IdCita = 1

--- Especialista
--ver agenda
select c.IdCita,p.Nombre,c.Cintomas,t.NoTurno,t.Horario 
from Cita c inner join Paciente p  on c.Dpi = p.Dpi
			inner join Turno t on c.NoTurno = t.NoTurno
---examenes

Select c.IdCita,p.Nombre,c.Cintomas,c.Resultados
from Cita c inner join Paciente p on c.Dpi = p.Dpi
where c.IdCita = 1

select * from DescripcionCita

Insert into Gastos_Medicos (IdCita,IdDescripcionCita,Cantidad) values (1,1,1)
Insert into Gastos_Medicos (IdCita,IdDescripcionCita,Cantidad) values (1,2,1)


---medicamentos 
Insert into Gastos_Medicos (IdCita,IdDescripcionCita,Cantidad) values (1,3,5)
Insert into Gastos_Medicos (IdCita,IdDescripcionCita,Cantidad) values (1,4,8)



GO

SELECT * FROM Gastos_Medicos

select e.Nombre,e.Precio,e.Descripcion
from Gastos_Medicos g inner join DescripcionCita e on g.IdDescripcionCita = e.IdDescripcionCita
where g.IdCita = 1
---laboratorio

select g.IdCita, e.Nombre

from Gastos_Medicos g  inner join DescripcionCita e on g.IdDescripcionCita = e.IdDescripcionCita
where e.Idtipo=1
go


update  Cita set Resultados = 'Elxamen de eces de detecto una bacteri y en el examen electrocardiogram no hay fuerza cardiaca' where IdCita = 1
update  Cita set Resultados = 'No hay fuerza cardiaca' where IdCita = 1


	
---asignar medicamentos 


select g.IdCita,e.Nombre[Examen],m.Nombre[Medicamento]
from Gastos_Medicos g full join Examen e on g.IdExamen = e.IdExamen
					full join Medicamento m  on g.IdMedicamento = m.IdMedicamento
					where g.IdCita = 1
go
update Gastos_Medicos  set IdMedicamento =1,Cantidad= 3 where IdCita= 1

select * from Cita
select * from Gastos_Medicos

select d.nombre,d.precio,g.Cantidad, d.precio * g.Cantidad SubTotal
from Gastos_Medicos g inner join DescripcionCita d on g.IdDescripcionCita = d.IdDescripcionCita

delete Gastos_Medicos where IdCita = 1
delete Cita where IdCita = 1

go


create procedure pruebaFactura
@id int
as
 select d.nombre, d.precio,g.Cantidad
 from Gastos_Medicos  g inner join DescripcionCita d on g.IdDescripcionCita = d.IdDescripcionCita
 where g.IdCita=@id
 union 
 select 'Cita',c.PrecioCita,1
 from cita c 
 where c.IdCita =@id
 

 EXECUTE  pruebaFactura @id =1




