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
('Aviles','Asturias'),
('Tineo','Asurias');

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
Values ('3345','Calle Manolin Reverte 65 Bajo Izq','44321','65','242231597F','4'),
('1123','Calle La Perdicion n2','33768','180.75','869750455M','5');

Insert into Personas (DNI,Nombre,Telefono,CabezaDeFamilia,Codigo_DelMunicipio,Codigo_Vivienda)
Values ('231232567K','Pepe Gonzalez','984767534','Rodrigo Gonzalez','5','1123'),
('869750455M','Rodrigo Gonzalez','666079870','0','5','1123');

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

Select Viviendas.Nombre, Municipios.Nombre
From Viviendas
INNER JOIN Municipios ON Viviendas.Codigo_Municipio = Municipios.Codigo_Municipio
INNER JOIN Personas ON Viviendas.DNI_Titular = Personas.DNI
Where Municipios.Nombre = 'Aviles';

//Ejercicio6.Nombre, direccion y telefono de todos los cabeza de familia empadronados en el municipio de Tineo.//

Select Personas.Nombre, Viviendas.Direccion, Personas.Telefono
From Personas
INNER JOIN Viviendas ON Personas.Codigo_Vivienda = Viviendas.Codigo_Vivienda
INNER JOIN Municipios ON Viviendas.Codigo_Municipio = Municipios.Codigo_Municipio
Where Municipios.Nombre = 'Tineo';

//Ejercicio7.Direccion completa de todas las viviendas del municipio de Oviedo y nombre y telefono de su propietario para todas aquellas que superan los 150 m2.//

Select Viviendas.Direccion, Personas.Nombre AS Propietario, Personas.Telefono
FROM Viviendas
INNER JOIN Municipios ON Viviendas.Codigo_Municipio = Municipios.Codigo_Municipio
INNER JOIN Personas ON Viviendas.DNI_Titular = Personas.DNI
WHERE Municipios.Nombre = 'Oviedo' AND Viviendas.MetrosCuadrados > 150;

//Ejercicio8.Nombre de todos los municipios de Asturias en los que la superficie media de sus viviendas supera los 70 m2.//

Select Municipios.Nombre
FROM Municipios
INNER JOIN Viviendas ON Municipios.Codigo_Municipio = Viviendas.Codigo_Municipio
GROUP BY Municipios.Nombre
HAVING AVG(Viviendas.MetrosCuadrados) > 70;

//Ejercicio9.Nombre de cada municipio de Asturias y cantidad de viviendas en cada uno de ellos que supera los 300 m2//

Select Municipios.Nombre, COUNT(*) AS Cantidad_Viviendas
FROM Municipios
INNER JOIN Viviendas ON Municipios.Codigo_Municipio = Viviendas.Codigo_Municipio
WHERE Viviendas.MetrosCuadrados > 300
GROUP BY Municipios.Nombre;

//Ejercicio10.Número total de cabezas de familia empadronados en el municipio de Proaza.//

Select COUNT(*) AS Total_CabezasDeFamilia
FROM Personas
INNER JOIN Municipios ON Personas.Codigo_DelMunicipio = Municipios.Codigo_Municipio
WHERE Municipios.Nombre = 'Proaza';

//Ejercicio11.Número total de municipios en cada provincia junto con el nombre de la misma.//

Select Provincia, COUNT(*) AS Total_Municipios
FROM Municipios
GROUP BY Provincia;

//Ejercicio12.Cantidad total de personas a cargo de cada cabeza de familia de las localidades de Asturias cuyo nombre empieza o termina por la letra ‘s’.//

SELECT Personas.CabezaDeFamilia, COUNT(*) AS Total_Personas_A_Cargo
FROM Personas
INNER JOIN Municipios ON Personas.Codigo_DelMunicipio = Municipios.Codigo_Municipio
WHERE (Municipios.Nombre LIKE 's%' OR Municipios.Nombre LIKE '%s')
GROUP BY Personas.CabezaDeFamilia;

//Ejercicio13.Media de personas a cargo de un cabeza de familia en cada municipio de la provincia de Asturias.//

SELECT Municipios.Nombre 
FROM Municipios
LEFT JOIN Personas ON Municipios.Codigo_Municipio = Personas.Codigo_DelMunicipio
GROUP BY Municipios.Nombre;

//Ejercicio14.Tamaño medio en metros cuadrados de las viviendas de cada municipio de la provincia de Asturias.//

SELECT Municipios.Nombre, AVG(Viviendas.MetrosCuadrados) AS Tamaño_Medio_Viviendas
FROM Municipios
LEFT JOIN Viviendas ON Municipios.Codigo_Municipio = Viviendas.Codigo_Municipio
GROUP BY Municipios.Nombre;

//Ejercicio15.Nombre, dirección y teléfono del cabeza de familia responsable de la persona con el D.N.I.  11.421.124.//

SELECT Personas.Nombre, Viviendas.Direccion, Personas.Telefono
FROM Personas
INNER JOIN Viviendas ON Personas.Codigo_Vivienda = Viviendas.Codigo_Vivienda
WHERE Personas.DNI = '11421124';

//Ejercicio16.Nombre y número de viviendas que posee cada cabeza de familia empadronado en un municipio de Asturias.//

SELECT Personas.CabezaDeFamilia, COUNT(*) AS Numero_Viviendas
FROM Personas
INNER JOIN Municipios ON Personas.Codigo_DelMunicipio = Municipios.Codigo_Municipio
WHERE Municipios.Provincia = 'Asturias'
GROUP BY Personas.CabezaDeFamilia;

//Ejercicio17.Nombre, dirección y teléfono de aquellos cabezas de familia que no poseen una vivienda en el municipio en el que están empadronados.//

SELECT Personas.Nombre, Viviendas.Direccion, Personas.Telefono
FROM Personas
LEFT JOIN Viviendas ON Personas.Codigo_Vivienda = Viviendas.Codigo_Vivienda
WHERE Personas.CabezaDeFamilia != '0';

//Ejercicio18.Nombre, dirección y teléfono de las personas que están empadronadas o poseen una vivienda en el municipio de Colunga y cuyo nombre empieza por la letra ‘A’. 
La consulta incluirá una última columna en la que se mostrará el valor “empadronado” si la fila incluye datos de una persona empadronada o el valor “propietario” si la fila incluye datos de una persona que posee una vivienda en el municipio.//

Select
From
Where

//Ejercicio19.Dirección completa de la vivienda, junto con el nombre y teléfono de su propietario, de aquellas viviendas de Asturias cuya superficie sea mayor que la de todas las viviendas de Boal.//

SELECT Viviendas.Direccion, Personas.Nombre
FROM Viviendas
INNER JOIN Personas ON Viviendas.DNI_Titular = Personas.DNI
WHERE Viviendas.MetrosCuadrados > (SELECT MAX(MetrosCuadrados) FROM Viviendas WHERE Codigo_Municipio = (SELECT Codigo_Municipio FROM Municipios WHERE Nombre = 'Boal'));

//Ejercicio20.Nombre, dirección y teléfono de las personas cuyo nombre empieza por la letra ‘B’, que están empadronadas en Morcín y poseen viviendas en dicho municipio.//

SELECT Personas.Nombre, Viviendas.Direccion, Personas.Telefono
FROM Personas
INNER JOIN Viviendas ON Personas.Codigo_Vivienda = Viviendas.Codigo_Vivienda
INNER JOIN Municipios ON Personas.Codigo_DelMunicipio = Municipios.Codigo_Municipio
WHERE Personas.Nombre LIKE 'B%' AND Municipios.Nombre = 'Morcín';

/*----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/



