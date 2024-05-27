drop database hoteles;
create database hoteles;
use hoteles;

create table fechas (
	lugar varchar(50),
    fecha_inicial date,
    constraint pk_fechas primary key (lugar)
    );

create table empleados (
	dni varchar(9) not null,
    nombre varchar(50) not null,
    constraint pk_empleados primary key (dni)
    );
   
create table cadenas_hoteleras (
	id_cadena int auto_increment,
	cif varchar(9) not null,
    nombre varchar(50) not null,
    direccion_fiscal varchar(50),
    constraint pk_cadenas_hoteleras primary key (id_cadena)
    );
   
create table ciudades (
id_ciudad int auto_increment,
    nombre varchar(50) not null,
    constraint pk_ciudades primary key (id_ciudad)
    );
   
create table actividades (
	id_actividad int auto_increment,
    nombre varchar(50) not null,
    constraint pk_actividades primary key (id_actividad)
    );
   
create table meses (
    nombre varchar(50),
    constraint pk_meses primary key (nombre)
    );

create table agencia_viajes (
id_agencia int auto_increment,
    nombre varchar(50) not null,
    direccion varchar(50) not null,
    ciudad varchar(50) not null,
    constraint pk_agencia_viajes primary key (id_agencia)
    );
     
create table hoteles (
    nombre varchar(50) not null,
    id_ciudad int not null,
    numero_estrellas float,
    direccion varchar(50),
    telefono varchar(9),
    id_cadenas int,
    constraint pk_hoteles primary key (nombre, id_ciudad),
    constraint fk_hoteles_cadenas_hoteleras foreign key (id_cadenas) references cadenas_hoteleras(id_cadena),
    constraint fk_hoteles_ciudades foreign key (id_ciudad) references ciudades(id_ciudad),
    check (numero_estrellas<=5)
    );
   
create table hotel_playa (
    nombre varchar(50) not null,
    id_ciudad int,
    playa_privada boolean,
    lugar_embarcacion varchar(50),
    constraint pk_hoteles primary key (nombre, id_ciudad),
    constraint fk_hotel_playa_ciudades foreign key (id_ciudad) references ciudades(id_ciudad),
	constraint fk_hotel_playa_hoteles foreign key (nombre) references hoteles(nombre)
    );
    
create table hotel_montana (
    nombre varchar(50) not null,
    id_ciudad int,
    piscina boolean,
    constraint pk_hoteles primary key (nombre, id_ciudad),
    constraint fk_hotel_montana_ciudades foreign key (id_ciudad) references ciudades(id_ciudad),
	constraint fk_hotel_montana_hoteles foreign key (nombre) references hoteles(nombre)
    );
    
create table delegado (
	id_delegado int auto_increment not null,
    id_ciudad int,
    id_agencia int not null,
    constraint pk_delegado primary key (id_delegado, id_agencia),
    constraint fk_delegado_ciudades foreign key (id_ciudad) references ciudades(id_ciudad),
	constraint fk_delegado_agencia_viajes foreign key (id_agencia) references agencia_viajes(id_agencia)
    );
    
create table equivalente (
	nombre_hotel varchar(50),
    id_ciudad_hotel int,
    nombre_equivalente varchar(50),
    id_ciudad_equivalente int,
    constraint pk_equivalente primary key (nombre_hotel, id_ciudad_hotel, nombre_equivalente, id_ciudad_equivalente),
    constraint fk_equivalente_hoteles foreign key (nombre_hotel, id_ciudad_hotel) references hoteles(nombre, id_ciudad),
	constraint fk_equivalente foreign key (nombre_equivalente, id_ciudad_equivalente) references hoteles(nombre, id_ciudad)
    );
    
create table organizan (
	nombre_hotel_montana varchar(50),
	id_actividad int,
    calidad_actividad int,
    constraint pk_organizan primary key (nombre_hotel_montana, id_actividad),
    constraint fk_organizan_hotel_montana foreign key (nombre_hotel_montana) references hotel_montana(nombre),
	constraint fk_organizan_actividades foreign key (id_actividad) references actividades(id_actividad),
    check (calidad_actividad <= 10)
    );
    
create table asignar_turistas (
	nombre_mes varchar(50),
	id_agencia int,
    nombre_hotel varchar(50),
    numero_turistas int not null,
    constraint pk_asignar_turistas primary key (nombre_mes, id_agencia, nombre_hotel),
    constraint fk_asignar_turistas_meses foreign key (nombre_mes) references meses(nombre),
    constraint fk_asignar_turistas_agencia_viajes foreign key (id_agencia) references agencia_viajes(id_agencia),
	constraint fk_asignar_turistas_hoteles foreign key (nombre_hotel) references hoteles(nombre)
    );
    
create table contratar (
    lugar varchar(50),
    dni_empleado varchar(9),
    id_cadena int,
	fecha_final date,
    constraint pk_contratar primary key (lugar, dni_empleado),
    constraint fk_contratar_fechas foreign key (lugar) references fechas(lugar),
	constraint fk_contratar_empleados foreign key (dni_empleado) references empleados(dni),
	constraint fk_contratar_cadenas_hoteleras foreign key (id_cadena) references cadenas_hoteleras(id_cadena)
    );
    
create table trabajar (
    lugar varchar(50),
    dni_empleado varchar(9),
    fecha_final date,
    constraint pk_trabajar primary key (lugar, dni_empleado),
    constraint fk_trabajar_fechas foreign key (lugar) references fechas(lugar),
	constraint fk_trabajar_empleados foreign key (dni_empleado) references empleados(dni)
    );