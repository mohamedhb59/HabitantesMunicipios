CREATE TABLE Municipios (
    Codigo_Municipio INT Auto_Increment,
    Nombre VARCHAR(100) NOT NULL,
    Provincia VARCHAR(50),
    PRIMARY KEY (Codigo_Municipio)
);

CREATE TABLE Viviendas (
    Codigo_Vivienda INT Auto_Increment,
    Direccion VARCHAR(100),
    CodigoPostal INT,
    MetrosCuadrados FLOAT,
    DNI_Titular VARCHAR(10),
    Codigo_Municipio INT,
    PRIMARY KEY (Codigo_Vivienda),
    FOREIGN KEY (Codigo_Municipio) REFERENCES Municipios(Codigo_Municipio)
);

CREATE TABLE Personas (
    DNI VARCHAR(10),
    Nombre VARCHAR(100),
    Telefono INT,
    CabezaDeFamilia VARCHAR(100),
    Codigo_DelMunicipio INT,
    Codigo_Vivienda INT,
    PRIMARY KEY (DNI),
    FOREIGN KEY (Codigo_DelMunicipio) REFERENCES Municipios (Codigo_Municipio),
    FOREIGN KEY (Codigo_Vivienda) REFERENCES Viviendas (Codigo_Vivienda)
);

CREATE TABLE Personas_Viviendas (
    CodigoVivienda INT,
    DNI_Persona VARCHAR(10),
    PRIMARY KEY (CodigoVivienda, DNI_Persona),
    FOREIGN KEY (CodigoVivienda) REFERENCES Viviendas (Codigo_Vivienda),
    FOREIGN KEY (DNI_Persona) REFERENCES Personas (DNI)
);


Insert into Municipios (Nombre,Provincia)
Values ('Luarca','Asturias'),
('Valdes','Asturias'),
('Navia','Asturias'),
('Aviles','Asturias');


Insert into Personas (DNI,Nombre,Telefono,CabezaDeFamilia,Codigo_DelMunicipio,Codigo_Vivienda)
Values ('789543129A','Eustaquio Lopez Alvarez','0','Diego Lopez Lama','1'),
('213448744B','Diego Lopez Lama','675892343','0','1'),
('984984164C','Rodrigo Gonzalez Lopez','645645789','Gonzalo Perez Fernandez','3','4865'),
('546213132D','Gonzalo Perez Fernandez','648878889','0','3');

Insert into Personas (DNI,Nombre,Telefono,CabezaDeFamilia,Codigo_DelMunicipio,Codigo_Vivienda)
Values ('456789123M','Paula Toribio','645332156','Lucia Rodriguez Toribio','4'),
('242231597F','Lucia Rodriguez Toribio','656657753','0','4','3345');

Insert into Personas (DNI,Nombre,Telefono,CabezaDeFamilia,Codigo_DelMunicipio,Codigo_Vivienda)
Values ('315311456F','Juan Fernandez','666546448','0','2'),
('0','Pepito Fernandez','0','Juan Fernandez','2');

Insert into Personas (DNI,Nombre,Telefono,CabezaDeFamilia,Codigo_DelMunicipio,Codigo_Vivienda)
Values ('123456789V','Juan Carlos Sierra','662526558','0','3','2547'),
('456789123H','Daniel Sierra','0','Juan Carlos Sierra','3');

Insert into Viviendas (Codigo_Vivienda,Direccion,CodigoPostal,MetrosCuadrados,DNI_Titular,Codigo_Municipio)
Values ('2547','Calle Lorenzo Quintanilla 2','33007','140.5','123456789V','3'),
('4865','Calle Uria Centro 5','33011','65.5','984984164C','3');

Insert into Personas_Viviendas (CodigoVivienda,DNI_Persona)
Values ('2547','123456789V'),
('4865','984984164C');

Insert into Viviendas (Codigo_Vivienda,Direccion,CodigoPostal,MetrosCuadrados,DNI_Titular,Codigo_Municipio)
Values ('3345','Calle Manolin Reverte 65 Bajo Izq','44321','65','242231597F','4');


//Ejercicio1.Nombre y telefono de los habitantes de Luarca.//

Select Nombre,Telefono
From Personas
Where Codigo_DelMunicipio='1';

//Ejercicio2.Nombre y telefono de los habitantes del municipio de Valdes.//

Select Nombre,Telefono
From Personas
Where Codigo_DelMunicipio='2';

//Ejercicio3.Direccion y metros cuadrados de las viviendas del municipio de Navia.//

Select Direccion,MetrosCuadrados
From Viviendas
Where Codigo_Municipio='3';

//Ejercicio4.Nombre y telefono de aquellas personas que poseen una vivienda en Navia.//

Select Nombre,Telefono
From Personas INNER JOIN Viviendas
ON Codigo_Municipio='3';

//Ejercicio5.De todas las viviendas del municipio de Aviles, su direccion, localidad y nombre del propietario.//

Select 



//Ejercicio6.Nombre, direccion y telefono de todos los cabeza de familia empadronados en el municipio de Tineo.//




//Ejercicio7.Direccion completa de todas las viviendas del municipio de Oviedo y nombre y telefono de su propietario para todas aquellas que superan los 150 m2.//