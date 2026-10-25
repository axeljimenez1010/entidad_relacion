-- =====================================================================
-- Códigos SQL de los Ejercicios propuestos
-- Asignatura: Base de Datos 
-- Estudiante: Axel Joao Jiménez Palta
-- =====================================================================


-- EJEMPLO 1: SISTEMA DE BIBLIOTECA

create database if not exists ejemplo1_biblioteca;
use ejemplo1_biblioteca;

create table Autor (
    id_autor varchar(10) PRIMARY KEY
);

create table Libro (
    id_libro varchar(10) PRIMARY KEY
);

create table Socio (
    id_socio varchar(10) PRIMARY KEY
);

create table Escribe (
    id_autor varchar(10) not null,
    id_libro varchar(10) not null,
    PRIMARY KEY (id_autor, id_libro),
    FOREIGN KEY (id_autor) references Autor(id_autor),
    FOREIGN KEY (id_libro) references Libro(id_libro)
);

create table Prestamo (
    id_socio varchar(10) not null,
    id_libro varchar(10) not null,
    fecha_retiro date not null,
    fecha_devolucion date,
    PRIMARY KEY (id_socio, id_libro, fecha_retiro),
    FOREIGN KEY (id_socio) references Socio(id_socio),
    FOREIGN KEY (id_libro) references Libro(id_libro)
);


-- EJEMPLO 2: PEDIDOS DE RESTAURANTE

create database if not exists ejemplo2_restaurante;
use ejemplo2_restaurante;

create table Cliente (
    id_cliente varchar(10) PRIMARY KEY
);

create table Categoria (
    id_categoria varchar(10) PRIMARY KEY
);

create table Mesero (
    id_mesero varchar(10) PRIMARY KEY
);

create table Plato (
    id_plato varchar(10) PRIMARY KEY,
    precio decimal(10,2) not null,
    id_categoria varchar(10) not null,
    FOREIGN KEY (id_categoria) references Categoria(id_categoria)
);

create table Pedido (
    id_pedido varchar(10) PRIMARY KEY,
    id_cliente varchar(10) not null,
    id_mesero varchar(10) not null,
    FOREIGN KEY (id_cliente) references Cliente(id_cliente),
    FOREIGN KEY (id_mesero) references Mesero(id_mesero)
);

create table Detalle_pedido (
    id_pedido varchar(10) not null,
    id_plato varchar(10) not null,
    cantidad int not null,
    precio_pedido decimal(10,2) not null,
    PRIMARY KEY (id_pedido, id_plato),
    FOREIGN KEY (id_pedido) references Pedido(id_pedido),
    FOREIGN KEY (id_plato) references Plato(id_plato)
);


-- EJEMPLO 3: CLÍNICA MÉDICA

create database if not exists ejemplo3_clinica;
use ejemplo3_clinica;

create table Especialidad (
    id_especialidad varchar(10) PRIMARY KEY
);

create table Medico (
    id_medico varchar(10) PRIMARY KEY,
    id_especialidad varchar(10) not null,
    FOREIGN KEY (id_especialidad) references Especialidad(id_especialidad)
);

create table Paciente (
    id_paciente varchar(10) PRIMARY KEY
);

create table Cita (
    id_cita varchar(10) PRIMARY KEY,
    fecha date not null,
    hora time not null,
    consultorio varchar(20) not null,
    id_paciente varchar(10) not null,
    id_medico varchar(10) not null,
    FOREIGN KEY (id_paciente) references Paciente(id_paciente),
    FOREIGN KEY (id_medico) references Medico(id_medico)
);

create table Receta (
    id_receta varchar(10) PRIMARY KEY,
    dosis varchar(50) not null,
    duracion varchar(50) not null,
    id_cita varchar(10) not null unique,
    FOREIGN KEY (id_cita) references Cita(id_cita)
);

create table Medicamento (
    id_medicamento varchar(10) PRIMARY KEY
);

create table Incluye (
    id_receta varchar(10) not null,
    id_medicamento varchar(10) not null,
    PRIMARY KEY (id_receta, id_medicamento),
    FOREIGN KEY (id_receta) references Receta(id_receta),
    FOREIGN KEY (id_medicamento) references Medicamento(id_medicamento)
);


-- EJEMPLO 4: SISTEMA DE AEROLÍNEA

create database if not exists ejemplo4_aerolinea;
use ejemplo4_aerolinea;

create table Avion (
    id_avion varchar(10) PRIMARY KEY
);

create table Pasajero (
    id_pasajero varchar(10) PRIMARY KEY
);

create table Vuelo (
    id_vuelo varchar(10) PRIMARY KEY,
    numero varchar(10) not null,
    fecha date not null,
    origen varchar(60) not null,
    destino varchar(60) not null,
    id_avion varchar(10) not null,
    FOREIGN KEY (id_avion) references Avion(id_avion)
);

create table Reserva (
    id_reserva varchar(10) PRIMARY KEY,
    asiento varchar(5) not null,
    tarifa decimal(10,2) not null,
    id_pasajero varchar(10) not null,
    id_vuelo varchar(10) not null,
    FOREIGN KEY (id_pasajero) references Pasajero(id_pasajero),
    FOREIGN KEY (id_vuelo) references Vuelo(id_vuelo)
);


-- EJERCICIO 5: EMPRESA DISCOGRÁFICA

create database if not exists ejercicio5_discografica;
use ejercicio5_discografica;

create table Manager (
    id_manager varchar(10) PRIMARY KEY,
    nombre varchar(100) not null
);

create table Artista (
    nif varchar(15) PRIMARY KEY,
    nombre_completo varchar(150) not null,
    id_manager varchar(10) not null,
    FOREIGN KEY (id_manager) references Manager(id_manager)
);

create table Evento_Promocion (
    id_evento varchar(10) PRIMARY KEY,
    fecha_celebracion date not null,
    numero_asistentes int not null
);

create table Participa (
    nif varchar(15) not null,
    id_evento varchar(10) not null,
    PRIMARY KEY (nif, id_evento),
    FOREIGN KEY (nif) references Artista(nif),
    FOREIGN KEY (id_evento) references Evento_Promocion(id_evento)
);


-- EJERCICIO 6: TIENDA INFORMÁTICA

create database if not exists ejercicio6_tienda;
use ejercicio6_tienda;

create table Producto (
    codigo varchar(10) PRIMARY KEY,
    descripcion varchar(150) not null,
    precio decimal(10,2) not null,
    existencias int not null
);

create table Cliente (
    codigo varchar(10) PRIMARY KEY,
    nombre varchar(60) not null,
    apellidos varchar(60) not null,
    direccion varchar(120),
    telefono varchar(15)
);

create table Proveedor (
    codigo varchar(10) PRIMARY KEY,
    nombres varchar(60) not null,
    apellidos varchar(60) not null,
    direccion varchar(120),
    provincia varchar(60),
    telefono varchar(15)
);

create table Compra (
    codigo_cliente varchar(10) not null,
    codigo_producto varchar(10) not null,
    fecha date not null,
    PRIMARY KEY (codigo_cliente, codigo_producto, fecha),
    FOREIGN KEY (codigo_cliente) references Cliente(codigo),
    FOREIGN KEY (codigo_producto) references Producto(codigo)
);

create table Suministra (
    codigo_proveedor varchar(10) not null,
    codigo_producto varchar(10) not null,
    PRIMARY KEY (codigo_proveedor, codigo_producto),
    FOREIGN KEY (codigo_proveedor) references Proveedor(codigo),
    FOREIGN KEY (codigo_producto) references Producto(codigo)
);

-- EJERCICIO 7: DISCOS MUSICALES

create database if not exists ejercicio7_discos;
use ejercicio7_discos;

create table Genero (
    id_genero varchar(10) PRIMARY KEY
);

create table Cantante (
    nombre varchar(100) PRIMARY KEY,
    pais varchar(60) not null
);

create table Disco (
    titulo varchar(150) PRIMARY KEY,
    precio decimal(10,2) not null,
    id_genero varchar(10) not null,
    nombre_cantante varchar(100) not null,
    FOREIGN KEY (id_genero) references Genero(id_genero),
    FOREIGN KEY (nombre_cantante) references Cantante(nombre)
);

create table Cancion (
    id_cancion varchar(10) PRIMARY KEY,
    titulo varchar(150) not null
);

create table Disco_Cancion (
    titulo_disco varchar(150) not null,
    id_cancion varchar(10) not null,
    posicion int not null,
    PRIMARY KEY (titulo_disco, id_cancion),
    FOREIGN KEY (titulo_disco) references Disco(titulo),
    FOREIGN KEY (id_cancion) references Cancion(id_cancion)
);

-- EJERCICIO 8: CAMIONES

create database if not exists ejercicio8_camiones;
use ejercicio8_camiones;

create table Camionero (
    cedula varchar(10) PRIMARY KEY,
    nombre varchar(100) not null,
    telefono varchar(15),
    direccion varchar(120),
    salario decimal(10,2),
    poblacion varchar(60)
);

create table Provincia (
    codigo_provincia varchar(10) PRIMARY KEY,
    nombre varchar(60) not null
);

create table Paquete (
    codigo_paquete varchar(10) PRIMARY KEY,
    descripcion varchar(150),
    destinatario varchar(100) not null,
    direccion_destinatario varchar(150) not null,
    cedula_camionero varchar(10) not null,
    codigo_provincia varchar(10) not null,
    FOREIGN KEY (cedula_camionero) references Camionero(cedula),
    FOREIGN KEY (codigo_provincia) references Provincia(codigo_provincia)
);

create table Camion (
    matricula varchar(10) PRIMARY KEY,
    modelo varchar(60),
    tipo varchar(60),
    potencia int
);

create table Conduce (
    cedula varchar(10) not null,
    matricula varchar(10) not null,
    fecha date not null,
    PRIMARY KEY (cedula, matricula, fecha),
    FOREIGN KEY (cedula) references Camionero(cedula),
    FOREIGN KEY (matricula) references Camion(matricula)
);

-- EJERCICIO 9: VETERINARIA

create database if not exists ejercicio9_veterinaria;
use ejercicio9_veterinaria;

create table Propietario (
    cedula varchar(10) PRIMARY KEY,
    apellidos varchar(60) not null,
    nombres varchar(60) not null,
    direccion varchar(120)
);

create table Telefono_propietario (
    cedula varchar(10) not null,
    telefono varchar(15) not null,
    PRIMARY KEY (cedula, telefono),
    FOREIGN KEY (cedula) references Propietario(cedula) 
);

create table Familiar_contacto (
    cedula varchar(10) PRIMARY KEY,
    nombre varchar(100) not null,
    telefono varchar(15),
    cedula_propietario varchar(10) not null unique,
    FOREIGN KEY (cedula_propietario) references Propietario(cedula) 
);

create table Mascota (
    identificador varchar(10) PRIMARY KEY,
    nombre varchar(60) not null,
    fecha_nacimiento date,
    tipo varchar(40),
    cedula_propietario varchar(10) not null,
    FOREIGN KEY (cedula_propietario) references Propietario(cedula)
);

create table Personal (
    codigo varchar(10) PRIMARY KEY,
    cedula varchar(10) not null,
    nombre varchar(100) not null
);

create table Veterinario (
    codigo varchar(10) PRIMARY KEY,
    fecha_alta date not null,
    especialidad varchar(80),
    FOREIGN KEY (codigo) references Personal(codigo)
);

create table Auxiliar (
    codigo varchar(10) PRIMARY KEY,
    base_cotizacion decimal(10,2),
    FOREIGN KEY (codigo) references Personal(codigo)
);

create table Consulta (
    identificador_mascota varchar(10) not null,
    codigo_veterinario varchar(10) not null,
    fecha date not null,
    diagnostico varchar(255),
    PRIMARY KEY (identificador_mascota, codigo_veterinario, fecha),
    FOREIGN KEY (identificador_mascota) references Mascota(identificador),
    FOREIGN KEY (codigo_veterinario) references Veterinario(codigo)
);
