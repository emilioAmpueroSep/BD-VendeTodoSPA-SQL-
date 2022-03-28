CREATE TABLE categoria (
    id_categoria     NUMBER NOT NULL,
    nombre_categoria VARCHAR2(60)
);

ALTER TABLE categoria ADD CONSTRAINT categoria_pk PRIMARY KEY ( id_categoria );

CREATE TABLE ciudad (
    id_ciudad        NUMBER NOT NULL,
    nombre_ciudad    VARCHAR2(60),
    region_id_region NUMBER NOT NULL
);

ALTER TABLE ciudad ADD CONSTRAINT ciudad_pk PRIMARY KEY ( id_ciudad );

CREATE TABLE cliente (
    rut_cliente      VARCHAR2(12) NOT NULL,
    nombre_empresa   VARCHAR2(60),
    nombre_contacto  VARCHAR2(60),
    email            VARCHAR2(60),
    direccion        VARCHAR2(60),
    cod_postal       NUMBER,
    telefono         NUMBER,
    ciudad_id_ciudad NUMBER NOT NULL
);

ALTER TABLE cliente ADD CONSTRAINT cliente_pk PRIMARY KEY ( rut_cliente );

CREATE TABLE "cliente-despachadores" (
    cliente_rut_cliente           VARCHAR2(12) NOT NULL,
    despachadores_rut_despachador VARCHAR2(12) NOT NULL
);

ALTER TABLE "cliente-despachadores" ADD CONSTRAINT "cliente-despachadores_PK" PRIMARY KEY ( cliente_rut_cliente,
                                                                                            despachadores_rut_despachador );

CREATE TABLE despachadores (
    rut_despachador  VARCHAR2(12) NOT NULL,
    nombre           VARCHAR2(60),
    telefono_empresa NUMBER
);

ALTER TABLE despachadores ADD CONSTRAINT despachadores_pk PRIMARY KEY ( rut_despachador );

CREATE TABLE detalle_orden_compra (
    id_detalle_compra            NUMBER NOT NULL,
    orden_compra_id_orden_compra NUMBER NOT NULL,
    producto_id_producto         NUMBER NOT NULL,
    cantidad_producto            NUMBER,
    descuento                    NUMBER,
    precio_venta_unidad          NUMBER
);

ALTER TABLE detalle_orden_compra ADD CONSTRAINT detalle_orden_compra_pk PRIMARY KEY ( id_detalle_compra );

CREATE TABLE empleado (
    rut_empleado     VARCHAR2(12) NOT NULL,
    nombre           VARCHAR2(60),
    apellido         VARCHAR2(60),
    fecha_nacimiento DATE,
    direccion        VARCHAR2(60),
    telefono         NUMBER,
    cargo            VARCHAR2(60),
    ciudad_id_ciudad NUMBER NOT NULL
);

ALTER TABLE empleado ADD CONSTRAINT empleado_pk PRIMARY KEY ( rut_empleado );

CREATE TABLE orden_compra (
    id_orden_compra               NUMBER NOT NULL,
    cliente_rut_cliente           VARCHAR2(12) NOT NULL,
    fecha_requerimiento           DATE,
    fecha_envio                   DATE,
    nombre_destinatario           VARCHAR2(60),
    direccion                     VARCHAR2(60),
    cod_postal                    NUMBER,
    via_envio                     VARCHAR2(60),
    ciudad_id_ciudad              NUMBER NOT NULL,
    despachadores_rut_despachador VARCHAR2(12) NOT NULL,
    empleado_rut_empleado         VARCHAR2(12) NOT NULL
);

ALTER TABLE orden_compra ADD CONSTRAINT orden_compra_pk PRIMARY KEY ( id_orden_compra );

CREATE TABLE pais (
    id_pais     NUMBER NOT NULL,
    nombre_pais VARCHAR2(60)
);

ALTER TABLE pais ADD CONSTRAINT pais_pk PRIMARY KEY ( id_pais );

CREATE TABLE producto (
    id_producto               NUMBER NOT NULL,
    nombre                    VARCHAR2(60),
    precio_compra             NUMBER,
    stock                     NUMBER,
    descontinuado             VARCHAR2(2),
    categoria_id_categoria    NUMBER NOT NULL,
    proveedores_rut_proveedor VARCHAR2(12) NOT NULL
);

ALTER TABLE producto ADD CONSTRAINT producto_pk PRIMARY KEY ( id_producto );

CREATE TABLE proveedores (
    rut_proveedor    VARCHAR2(12) NOT NULL,
    nombre_compania  VARCHAR2(60),
    nombre_contacto  VARCHAR2(60),
    direccion        VARCHAR2(60),
    telefono         NUMBER,
    ciudad_id_ciudad NUMBER NOT NULL
);

ALTER TABLE proveedores ADD CONSTRAINT proveedores_pk PRIMARY KEY ( rut_proveedor );

CREATE TABLE region (
    id_region     NUMBER NOT NULL,
    nombre_region VARCHAR2(60),
    pais_id_pais  NUMBER NOT NULL
);

ALTER TABLE region ADD CONSTRAINT region_pk PRIMARY KEY ( id_region );

ALTER TABLE ciudad
    ADD CONSTRAINT ciudad_region_fk FOREIGN KEY ( region_id_region )
        REFERENCES region ( id_region );

ALTER TABLE cliente
    ADD CONSTRAINT cliente_ciudad_fk FOREIGN KEY ( ciudad_id_ciudad )
        REFERENCES ciudad ( id_ciudad );


ALTER TABLE "cliente-despachadores"
    ADD CONSTRAINT "cliente-despachadores_cliente_FK" FOREIGN KEY ( cliente_rut_cliente )
        REFERENCES cliente ( rut_cliente );

ALTER TABLE "cliente-despachadores"
    ADD CONSTRAINT "cliente-despachadores_despachadores_FK" FOREIGN KEY ( despachadores_rut_despachador )
        REFERENCES despachadores ( rut_despachador );

ALTER TABLE detalle_orden_compra
    ADD CONSTRAINT detalle_orden_compra_orden_compra_fk FOREIGN KEY ( orden_compra_id_orden_compra )
        REFERENCES orden_compra ( id_orden_compra );

ALTER TABLE detalle_orden_compra
    ADD CONSTRAINT detalle_orden_compra_producto_fk FOREIGN KEY ( producto_id_producto )
        REFERENCES producto ( id_producto );

ALTER TABLE empleado
    ADD CONSTRAINT empleado_ciudad_fk FOREIGN KEY ( ciudad_id_ciudad )
        REFERENCES ciudad ( id_ciudad );

ALTER TABLE orden_compra
    ADD CONSTRAINT orden_compra_ciudad_fk FOREIGN KEY ( ciudad_id_ciudad )
        REFERENCES ciudad ( id_ciudad );

ALTER TABLE orden_compra
    ADD CONSTRAINT orden_compra_cliente_fk FOREIGN KEY ( cliente_rut_cliente )
        REFERENCES cliente ( rut_cliente );

ALTER TABLE orden_compra
    ADD CONSTRAINT orden_compra_despachadores_fk FOREIGN KEY ( despachadores_rut_despachador )
        REFERENCES despachadores ( rut_despachador );

ALTER TABLE orden_compra
    ADD CONSTRAINT orden_compra_empleado_fk FOREIGN KEY ( empleado_rut_empleado )
        REFERENCES empleado ( rut_empleado );

ALTER TABLE producto
    ADD CONSTRAINT producto_categoria_fk FOREIGN KEY ( categoria_id_categoria )
        REFERENCES categoria ( id_categoria );

ALTER TABLE producto
    ADD CONSTRAINT producto_proveedores_fk FOREIGN KEY ( proveedores_rut_proveedor )
        REFERENCES proveedores ( rut_proveedor );

ALTER TABLE proveedores
    ADD CONSTRAINT proveedores_ciudad_fk FOREIGN KEY ( ciudad_id_ciudad )
        REFERENCES ciudad ( id_ciudad );

ALTER TABLE region
    ADD CONSTRAINT region_pais_fk FOREIGN KEY ( pais_id_pais )
        REFERENCES pais ( id_pais );
INSERT INTO pais(id_pais, nombre_pais) VALUES (1,'Chile');
INSERT INTO pais(id_pais, nombre_pais) VALUES ((SELECT MAX(id_pais)+1 FROM pais),'Argentina');
INSERT INTO pais(id_pais, nombre_pais) VALUES ((SELECT MAX(id_pais)+1 FROM pais),'Colombia');
INSERT INTO pais(id_pais, nombre_pais) VALUES ((SELECT MAX(id_pais)+1 FROM pais),'Venezuela');
INSERT INTO pais(id_pais, nombre_pais) VALUES ((SELECT MAX(id_pais)+1 FROM pais),'Cuba');
INSERT INTO region(id_region, nombre_region, pais_id_pais) VALUES (1,'Metropolitana',1);
INSERT INTO region(id_region, nombre_region, pais_id_pais) VALUES ((SELECT MAX(id_region)+1 FROM region),'Bio-bio',1);
INSERT INTO region(id_region, nombre_region, pais_id_pais) VALUES ((SELECT MAX(id_region)+1 FROM region),'Valparaiso',1);
INSERT INTO region(id_region, nombre_region, pais_id_pais) VALUES ((SELECT MAX(id_region)+1 FROM region),'Atacama',1);
INSERT INTO region(id_region, nombre_region, pais_id_pais) VALUES ((SELECT MAX(id_region)+1 FROM region),'Aysen',1);
INSERT INTO region(id_region, nombre_region, pais_id_pais) VALUES ((SELECT MAX(id_region)+1 FROM region),'Buenos Aires',2);
INSERT INTO region(id_region, nombre_region, pais_id_pais) VALUES ((SELECT MAX(id_region)+1 FROM region),'La Plata',2);
INSERT INTO region(id_region, nombre_region, pais_id_pais) VALUES ((SELECT MAX(id_region)+1 FROM region),'Cordoba',2);
INSERT INTO region(id_region, nombre_region, pais_id_pais) VALUES ((SELECT MAX(id_region)+1 FROM region),'Misiones',2);
INSERT INTO region(id_region, nombre_region, pais_id_pais) VALUES ((SELECT MAX(id_region)+1 FROM region),'Mendoza',2);
INSERT INTO region(id_region, nombre_region, pais_id_pais) VALUES ((SELECT MAX(id_region)+1 FROM region),'Bogota DC',3);
INSERT INTO region(id_region, nombre_region, pais_id_pais) VALUES ((SELECT MAX(id_region)+1 FROM region),'Cauca',3);
INSERT INTO region(id_region, nombre_region, pais_id_pais) VALUES ((SELECT MAX(id_region)+1 FROM region),'Pasto',3);
INSERT INTO region(id_region, nombre_region, pais_id_pais) VALUES ((SELECT MAX(id_region)+1 FROM region),'Magdalena',3);
INSERT INTO region(id_region, nombre_region, pais_id_pais) VALUES ((SELECT MAX(id_region)+1 FROM region),'Antioquia',3);
INSERT INTO region(id_region, nombre_region, pais_id_pais) VALUES ((SELECT MAX(id_region)+1 FROM region),'Aragua',4);
INSERT INTO region(id_region, nombre_region, pais_id_pais) VALUES ((SELECT MAX(id_region)+1 FROM region),'Zulia',4);
INSERT INTO region(id_region, nombre_region, pais_id_pais) VALUES ((SELECT MAX(id_region)+1 FROM region),'Bolivar',4);
INSERT INTO region(id_region, nombre_region, pais_id_pais) VALUES ((SELECT MAX(id_region)+1 FROM region),'Los Llanos',4);
INSERT INTO region(id_region, nombre_region, pais_id_pais) VALUES ((SELECT MAX(id_region)+1 FROM region),'Monagas',4);
INSERT INTO region(id_region, nombre_region, pais_id_pais) VALUES ((SELECT MAX(id_region)+1 FROM region),'Occidental',5);
INSERT INTO region(id_region, nombre_region, pais_id_pais) VALUES ((SELECT MAX(id_region)+1 FROM region),'Central',5);
INSERT INTO region(id_region, nombre_region, pais_id_pais) VALUES ((SELECT MAX(id_region)+1 FROM region),'Oriental',5);
INSERT INTO ciudad(id_ciudad, nombre_ciudad, region_id_region) VALUES (1,'Santiago',1);
INSERT INTO ciudad(id_ciudad, nombre_ciudad, region_id_region) VALUES ((SELECT MAX(id_ciudad)+1 FROM ciudad),'Concepcion',2);
INSERT INTO ciudad(id_ciudad, nombre_ciudad, region_id_region) VALUES ((SELECT MAX(id_ciudad)+1 FROM ciudad),'Valparaiso',3);
INSERT INTO ciudad(id_ciudad, nombre_ciudad, region_id_region) VALUES ((SELECT MAX(id_ciudad)+1 FROM ciudad),'Calama',4);
INSERT INTO ciudad(id_ciudad, nombre_ciudad, region_id_region) VALUES ((SELECT MAX(id_ciudad)+1 FROM ciudad),'Coihaique',5);
INSERT INTO ciudad(id_ciudad, nombre_ciudad, region_id_region) VALUES ((SELECT MAX(id_ciudad)+1 FROM ciudad),'Buenos Aires',6);
INSERT INTO ciudad(id_ciudad, nombre_ciudad, region_id_region) VALUES ((SELECT MAX(id_ciudad)+1 FROM ciudad),'La Plata',7);
INSERT INTO ciudad(id_ciudad, nombre_ciudad, region_id_region) VALUES ((SELECT MAX(id_ciudad)+1 FROM ciudad),'Cordoba',8);
INSERT INTO ciudad(id_ciudad, nombre_ciudad, region_id_region) VALUES ((SELECT MAX(id_ciudad)+1 FROM ciudad),'Formoza',9);
INSERT INTO ciudad(id_ciudad, nombre_ciudad, region_id_region) VALUES ((SELECT MAX(id_ciudad)+1 FROM ciudad),'Mendoza ciudad',10);
INSERT INTO ciudad(id_ciudad, nombre_ciudad, region_id_region) VALUES ((SELECT MAX(id_ciudad)+1 FROM ciudad),'Santa Fe de Bogota',11);
INSERT INTO ciudad(id_ciudad, nombre_ciudad, region_id_region) VALUES ((SELECT MAX(id_ciudad)+1 FROM ciudad),'Cali',12);
INSERT INTO ciudad(id_ciudad, nombre_ciudad, region_id_region) VALUES ((SELECT MAX(id_ciudad)+1 FROM ciudad),'Neiva',13);
INSERT INTO ciudad(id_ciudad, nombre_ciudad, region_id_region) VALUES ((SELECT MAX(id_ciudad)+1 FROM ciudad),'Santa Marta',14);
INSERT INTO ciudad(id_ciudad, nombre_ciudad, region_id_region) VALUES ((SELECT MAX(id_ciudad)+1 FROM ciudad),'Medellin',15);
INSERT INTO ciudad(id_ciudad, nombre_ciudad, region_id_region) VALUES ((SELECT MAX(id_ciudad)+1 FROM ciudad),'Aragua',16);
INSERT INTO ciudad(id_ciudad, nombre_ciudad, region_id_region) VALUES ((SELECT MAX(id_ciudad)+1 FROM ciudad),'Maracaibo',17);
INSERT INTO ciudad(id_ciudad, nombre_ciudad, region_id_region) VALUES ((SELECT MAX(id_ciudad)+1 FROM ciudad),'Ciudad Bolivar',18);
INSERT INTO ciudad(id_ciudad, nombre_ciudad, region_id_region) VALUES ((SELECT MAX(id_ciudad)+1 FROM ciudad),'Barinas',19);
INSERT INTO ciudad(id_ciudad, nombre_ciudad, region_id_region) VALUES ((SELECT MAX(id_ciudad)+1 FROM ciudad),'Maturin',20);
INSERT INTO ciudad(id_ciudad, nombre_ciudad, region_id_region) VALUES ((SELECT MAX(id_ciudad)+1 FROM ciudad),'La Havana',18);
INSERT INTO ciudad(id_ciudad, nombre_ciudad, region_id_region) VALUES ((SELECT MAX(id_ciudad)+1 FROM ciudad),'Moron',19);
INSERT INTO ciudad(id_ciudad, nombre_ciudad, region_id_region) VALUES ((SELECT MAX(id_ciudad)+1 FROM ciudad),'Bayamo',20);
INSERT INTO cliente (rut_cliente, nombre_empresa, nombre_contacto, email, direccion, cod_postal, telefono, ciudad_id_ciudad) VALUES ('99.102.124-k', 'IBM','Andres Riveros','andres.riveros@ibm.com', 'pje. 5 norte 1002', 201541, 952148752,1);
INSERT INTO cliente (rut_cliente, nombre_empresa, nombre_contacto, email, direccion, cod_postal, telefono, ciudad_id_ciudad) VALUES ('88.330.007-0', 'Coca-Cola Company','Pablo Ramirez','pablo.ramirez@cocacola.com', 'pje. Los Pelicanos 988', 200547, 974854715,13);
INSERT INTO cliente (rut_cliente, nombre_empresa, nombre_contacto, email, direccion, cod_postal, telefono, ciudad_id_ciudad) VALUES ('84.777.897-2', 'Derco','Julian Parra','julian.parra@derco.com', 'Av. Padre Hurtado 1009', 205847, 912748572,3);
INSERT INTO cliente (rut_cliente, nombre_empresa, nombre_contacto, email, direccion, cod_postal, telefono, ciudad_id_ciudad) VALUES ('97.502.669-4', 'Walmart','Josefa Rios','josefa.rios@walmart.com', 'Los Nogales 1445', 200222, 963335874,6);
INSERT INTO cliente (rut_cliente, nombre_empresa, nombre_contacto, email, direccion, cod_postal, telefono, ciudad_id_ciudad) VALUES ('55.002.855-6', 'Nike Companies','Patrick Smith','p.smith@nike.com', 'Nido de aguilas 1225', 222547, 965858541,2);
INSERT INTO cliente (rut_cliente, nombre_empresa, nombre_contacto, email, direccion, cod_postal, telefono, ciudad_id_ciudad) VALUES ('76.114.744-8', 'Banco de Chile','Maritza Pinto','maritza.pinto@bancochile.com', 'pje. Rio Baker 370', 201588, 954754825,2);
INSERT INTO cliente (rut_cliente, nombre_empresa, nombre_contacto, email, direccion, cod_postal, telefono, ciudad_id_ciudad) VALUES ('75.001.636-1', 'Banco Estado','Mariangel Perez','mariangel.perez@bancoestado.cl', 'Av. Eliodoro Yañez 20025', 201441, 97441241,9);
INSERT INTO cliente (rut_cliente, nombre_empresa, nombre_contacto, email, direccion, cod_postal, telefono, ciudad_id_ciudad) VALUES ('80.000.777-3', 'Ampuero Intelligence','Marianella Castaneda','m.castaneda@ibm.com', 'pje. Simon Bolivar 1024', 204552, 988545242,1);
INSERT INTO cliente (rut_cliente, nombre_empresa, nombre_contacto, email, direccion, cod_postal, telefono, ciudad_id_ciudad) VALUES ('89.996.228-5', 'Inalco','Ivan Torres','ivan.torres@inalco.com', 'Los Aviadores 88', 201445, 974562414,15);
INSERT INTO cliente (rut_cliente, nombre_empresa, nombre_contacto, email, direccion, cod_postal, telefono, ciudad_id_ciudad) VALUES ('79.857.712-7', 'Capitol Punishment','Luisa Polanco','luisa.polanco@cpunishment.com', 'Av. Las Rejas 9665', 202000, 988741145,18);
INSERT INTO empleado (rut_empleado, nombre, apellido, fecha_nacimiento, direccion, telefono, cargo, ciudad_id_ciudad) VALUES ('16.254.778-7', 'Franco','Castillo',  TO_DATE('1970-06-10 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Av. El Salto 220', 925457444, 'Vendedor', 1);
INSERT INTO empleado (rut_empleado, nombre, apellido, fecha_nacimiento, direccion, telefono, cargo, ciudad_id_ciudad) VALUES ('13.000.232-8', 'Lorena','Harper',  TO_DATE('1975-02-13 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Av. Principe de Gales 2335', 978457415, 'Vendedor', 2);
INSERT INTO empleado (rut_empleado, nombre, apellido, fecha_nacimiento, direccion, telefono, cargo, ciudad_id_ciudad) VALUES ('15.999.232-9', 'Hamilton','Vasquez',  TO_DATE('1981-10-23 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Pje Los Lagos 10025', 925415410, 'Vendedor', 1);
INSERT INTO empleado (rut_empleado, nombre, apellido, fecha_nacimiento, direccion, telefono, cargo, ciudad_id_ciudad) VALUES ('12.000.452-8', 'Isabel','Arce',  TO_DATE('1992-04-05 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Pje Gala 1002', 989647841, 'Jefe de Ventas', 1);
INSERT INTO empleado (rut_empleado, nombre, apellido, fecha_nacimiento, direccion, telefono, cargo, ciudad_id_ciudad) VALUES ('10.700.298-k', 'Ximena','Urrutia',  TO_DATE('1973-12-15 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Pje La Plata', 978774144, 'Vendedor', 2);
INSERT INTO categoria (id_categoria, nombre_categoria) VALUES (1,'Aseo');
INSERT INTO categoria (id_categoria, nombre_categoria) VALUES ((SELECT MAX(id_categoria)+1 FROM categoria),'Oficina');
INSERT INTO categoria (id_categoria, nombre_categoria) VALUES ((SELECT MAX(id_categoria)+1 FROM categoria),'Cafeteria');
INSERT INTO categoria (id_categoria, nombre_categoria) VALUES ((SELECT MAX(id_categoria)+1 FROM categoria),'Tecnologia');
INSERT INTO categoria (id_categoria, nombre_categoria) VALUES ((SELECT MAX(id_categoria)+1 FROM categoria),'Abarrotes');
INSERT INTO proveedores (rut_proveedor, nombre_compania, nombre_contacto, direccion, telefono, ciudad_id_ciudad) VALUES ('88.021.124-7','Palmolive', 'Jeremias Pereira', 'Av. Suiza 7002', 963528402, 1);
INSERT INTO proveedores (rut_proveedor, nombre_compania, nombre_contacto, direccion, telefono, ciudad_id_ciudad) VALUES ('89.000.337-k','Artel SA', 'Genaro Gajardo', 'Av. Camino a Melipella 10221', 936521475, 2);
INSERT INTO proveedores (rut_proveedor, nombre_compania, nombre_contacto, direccion, telefono, ciudad_id_ciudad) VALUES ('77.369.475-0','Cruzeiro SA', 'Jonas Melo', 'Av. Lo espejo 10025', 936251407, 1);
INSERT INTO proveedores (rut_proveedor, nombre_compania, nombre_contacto, direccion, telefono, ciudad_id_ciudad) VALUES ('99.552.008-6','Kensington', 'Giovanna Lopez', 'Camino La Vara 374', 987415214, 3);
INSERT INTO proveedores (rut_proveedor, nombre_compania, nombre_contacto, direccion, telefono, ciudad_id_ciudad) VALUES ('93.087.125-5','Carozzi spa', 'Ariel Poblete', 'Av. Nos 10024', 925417415, 1);
INSERT INTO producto (id_producto, nombre, precio_compra, stock, descontinuado, categoria_id_categoria, proveedores_rut_proveedor) VALUES (1000,'Cloro', 120, 100, 'no', 1, '88.021.124-7');
INSERT INTO producto (id_producto, nombre, precio_compra, stock, descontinuado, categoria_id_categoria, proveedores_rut_proveedor) VALUES ((SELECT MAX(id_producto)+1 FROM producto ),'Lavaloza', 500, 200, 'no', 1, '88.021.124-7');
INSERT INTO producto (id_producto, nombre, precio_compra, stock, descontinuado, categoria_id_categoria, proveedores_rut_proveedor) VALUES ((SELECT MAX(id_producto)+1 FROM producto ),'Teclado', 3000, 50, 'no', 4, '99.552.008-6');
INSERT INTO producto (id_producto, nombre, precio_compra, stock, descontinuado, categoria_id_categoria, proveedores_rut_proveedor) VALUES ((SELECT MAX(id_producto)+1 FROM producto ),'Tacos de papel', 100, 0, 'si', 2, '89.000.337-k');
INSERT INTO producto (id_producto, nombre, precio_compra, stock, descontinuado, categoria_id_categoria, proveedores_rut_proveedor) VALUES ((SELECT MAX(id_producto)+1 FROM producto ),'Cafe Nescafe', 800, 350, 'no', 3, '77.369.475-0');
INSERT INTO producto (id_producto, nombre, precio_compra, stock, descontinuado, categoria_id_categoria, proveedores_rut_proveedor) VALUES ((SELECT MAX(id_producto)+1 FROM producto ),'Monitor Gamer', 60000, 115, 'no', 4, '99.552.008-6');
INSERT INTO producto (id_producto, nombre, precio_compra, stock, descontinuado, categoria_id_categoria, proveedores_rut_proveedor) VALUES ((SELECT MAX(id_producto)+1 FROM producto ),'Spaghetti', 150, 1000, 'no', 5, '93.087.125-5');
INSERT INTO producto (id_producto, nombre, precio_compra, stock, descontinuado, categoria_id_categoria, proveedores_rut_proveedor) VALUES ((SELECT MAX(id_producto)+1 FROM producto ),'Lapiz Tinta Gel', 75, 658, 'no', 2, '89.000.337-k');
INSERT INTO producto (id_producto, nombre, precio_compra, stock, descontinuado, categoria_id_categoria, proveedores_rut_proveedor) VALUES ((SELECT MAX(id_producto)+1 FROM producto ),'Silla Ergonomica', 100000, 99, 'no', 4, '99.552.008-6');
INSERT INTO producto (id_producto, nombre, precio_compra, stock, descontinuado, categoria_id_categoria, proveedores_rut_proveedor) VALUES ((SELECT MAX(id_producto)+1 FROM producto ),'Arroz', 300, 752, 'no', 5, '93.087.125-5');
INSERT INTO producto (id_producto, nombre, precio_compra, stock, descontinuado, categoria_id_categoria, proveedores_rut_proveedor) VALUES ((SELECT MAX(id_producto)+1 FROM producto ),'Alcohol Gel', 600, 509, 'no', 1, '88.021.124-7');
INSERT INTO producto (id_producto, nombre, precio_compra, stock, descontinuado, categoria_id_categoria, proveedores_rut_proveedor) VALUES ((SELECT MAX(id_producto)+1 FROM producto ),'Te con Canela', 500, 600, 'no', 3, '77.369.475-0');
INSERT INTO producto (id_producto, nombre, precio_compra, stock, descontinuado, categoria_id_categoria, proveedores_rut_proveedor) VALUES ((SELECT MAX(id_producto)+1 FROM producto ),'Auriculares', 2000, 500, 'no', 4, '99.552.008-6');
INSERT INTO producto (id_producto, nombre, precio_compra, stock, descontinuado, categoria_id_categoria, proveedores_rut_proveedor) VALUES ((SELECT MAX(id_producto)+1 FROM producto ),'Cuaderno', 400, 1000, 'no', 2, '89.000.337-k');
INSERT INTO despachadores (rut_despachador, nombre, telefono_empresa) VALUES ('98.124.322-7', 'Fedex', 965564571);
INSERT INTO despachadores (rut_despachador, nombre, telefono_empresa) VALUES ('98.222.333-1', 'TNT', 974521425);
INSERT INTO despachadores (rut_despachador, nombre, telefono_empresa) VALUES ('96.283.097-2', 'DHL', 932656547);
INSERT INTO despachadores (rut_despachador, nombre, telefono_empresa) VALUES ('92.458.321-k', 'Starken', 965180464);
INSERT INTO despachadores (rut_despachador, nombre, telefono_empresa) VALUES ('95.502.328-1', 'Correos de Chile', 974251408);
INSERT INTO orden_compra (id_orden_compra, cliente_rut_cliente, fecha_requerimiento, fecha_envio, nombre_destinatario, direccion, cod_postal, via_envio, ciudad_id_ciudad, despachadores_rut_despachador, empleado_rut_empleado) VALUES (7000, '88.330.007-0',  TO_DATE('2021-05-05 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2021-05-20 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),'Sara Prado', 'pje. Los Pelicanos 988', 200547, 'Aerea',13,'96.283.097-2', '13.000.232-8');
INSERT INTO orden_compra (id_orden_compra, cliente_rut_cliente, fecha_requerimiento, fecha_envio, nombre_destinatario, direccion, cod_postal, via_envio, ciudad_id_ciudad, despachadores_rut_despachador, empleado_rut_empleado) VALUES ((SELECT MAX(id_orden_compra)+1 FROM orden_compra), '97.502.669-4',  TO_DATE('2021-03-10 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2021-03-25 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),'Josefa Rios', 'Los Nogales 1445', 200222, 'Aerea',6,'98.222.333-1', '16.254.778-7');
INSERT INTO orden_compra (id_orden_compra, cliente_rut_cliente, fecha_requerimiento, fecha_envio, nombre_destinatario, direccion, cod_postal, via_envio, ciudad_id_ciudad, despachadores_rut_despachador, empleado_rut_empleado) VALUES ((SELECT MAX(id_orden_compra)+1 FROM orden_compra), '76.114.744-8',  TO_DATE('2021-03-15 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2021-03-19 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),'Maritza Pinto', 'pje. Rio Baker 370', 201588, 'Terrestre',2,'92.458.321-k', '10.700.298-k');
INSERT INTO orden_compra (id_orden_compra, cliente_rut_cliente, fecha_requerimiento, fecha_envio, nombre_destinatario, direccion, cod_postal, via_envio, ciudad_id_ciudad, despachadores_rut_despachador, empleado_rut_empleado) VALUES ((SELECT MAX(id_orden_compra)+1 FROM orden_compra), '80.000.777-3',  TO_DATE('2021-07-20 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2021-07-22 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),'Marianella Castaneda', 'pje. Simon Bolivar 1024', 204552, 'Terrestre',1,'96.283.097-2', '13.000.232-8');
INSERT INTO orden_compra (id_orden_compra, cliente_rut_cliente, fecha_requerimiento, fecha_envio, nombre_destinatario, direccion, cod_postal, via_envio, ciudad_id_ciudad, despachadores_rut_despachador, empleado_rut_empleado) VALUES ((SELECT MAX(id_orden_compra)+1 FROM orden_compra), '79.857.712-7',  TO_DATE('2022-01-15 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2022-01-24 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),'Luisa Polanco', 'Av. Las Rejas 9665', 202000, 'Aerea',18,'98.124.322-7', '12.000.452-8');
INSERT INTO detalle_orden_compra (id_detalle_compra, orden_compra_id_orden_compra, producto_id_producto, cantidad_producto, descuento, precio_venta_unidad) VALUES (10002300, 7000, 1001, 3, 0, 1050);
INSERT INTO detalle_orden_compra (id_detalle_compra, orden_compra_id_orden_compra, producto_id_producto, cantidad_producto, descuento, precio_venta_unidad) VALUES ((SELECT MAX(id_detalle_compra)+1 FROM detalle_orden_compra ), 7000, 1000, 4, 0, 300);
INSERT INTO detalle_orden_compra (id_detalle_compra, orden_compra_id_orden_compra, producto_id_producto, cantidad_producto, descuento, precio_venta_unidad) VALUES ((SELECT MAX(id_detalle_compra)+1 FROM detalle_orden_compra ), 7000, 1004, 6, 500, 2000);
INSERT INTO detalle_orden_compra (id_detalle_compra, orden_compra_id_orden_compra, producto_id_producto, cantidad_producto, descuento, precio_venta_unidad) VALUES ((SELECT MAX(id_detalle_compra)+1 FROM detalle_orden_compra ), 7000, 1002, 1, 0, 9890);
INSERT INTO detalle_orden_compra (id_detalle_compra, orden_compra_id_orden_compra, producto_id_producto, cantidad_producto, descuento, precio_venta_unidad) VALUES ((SELECT MAX(id_detalle_compra)+1 FROM detalle_orden_compra ), 7001, 1002, 1, 0, 9890);
INSERT INTO detalle_orden_compra (id_detalle_compra, orden_compra_id_orden_compra, producto_id_producto, cantidad_producto, descuento, precio_venta_unidad) VALUES ((SELECT MAX(id_detalle_compra)+1 FROM detalle_orden_compra ), 7001, 1013, 10, 0, 800);
INSERT INTO detalle_orden_compra (id_detalle_compra, orden_compra_id_orden_compra, producto_id_producto, cantidad_producto, descuento, precio_venta_unidad) VALUES ((SELECT MAX(id_detalle_compra)+1 FROM detalle_orden_compra ), 7001, 1010, 5, 0, 1000);
INSERT INTO detalle_orden_compra (id_detalle_compra, orden_compra_id_orden_compra, producto_id_producto, cantidad_producto, descuento, precio_venta_unidad) VALUES ((SELECT MAX(id_detalle_compra)+1 FROM detalle_orden_compra ), 7002, 1011, 10, 500, 1000);
INSERT INTO detalle_orden_compra (id_detalle_compra, orden_compra_id_orden_compra, producto_id_producto, cantidad_producto, descuento, precio_venta_unidad) VALUES ((SELECT MAX(id_detalle_compra)+1 FROM detalle_orden_compra ), 7002, 1001, 7, 0, 1050);
INSERT INTO detalle_orden_compra (id_detalle_compra, orden_compra_id_orden_compra, producto_id_producto, cantidad_producto, descuento, precio_venta_unidad) VALUES ((SELECT MAX(id_detalle_compra)+1 FROM detalle_orden_compra ), 7003, 1005, 4, 0, 220000);
INSERT INTO detalle_orden_compra (id_detalle_compra, orden_compra_id_orden_compra, producto_id_producto, cantidad_producto, descuento, precio_venta_unidad) VALUES ((SELECT MAX(id_detalle_compra)+1 FROM detalle_orden_compra ), 7003, 1008, 4, 0, 180000);
INSERT INTO detalle_orden_compra (id_detalle_compra, orden_compra_id_orden_compra, producto_id_producto, cantidad_producto, descuento, precio_venta_unidad) VALUES ((SELECT MAX(id_detalle_compra)+1 FROM detalle_orden_compra ), 7004, 1012, 10, 1000, 5000);
INSERT INTO detalle_orden_compra (id_detalle_compra, orden_compra_id_orden_compra, producto_id_producto, cantidad_producto, descuento, precio_venta_unidad) VALUES ((SELECT MAX(id_detalle_compra)+1 FROM detalle_orden_compra ), 7004, 1013, 20, 0, 800);
INSERT INTO detalle_orden_compra (id_detalle_compra, orden_compra_id_orden_compra, producto_id_producto, cantidad_producto, descuento, precio_venta_unidad) VALUES ((SELECT MAX(id_detalle_compra)+1 FROM detalle_orden_compra ), 7004, 1011, 15, 0, 1000);