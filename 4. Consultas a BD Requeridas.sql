/*Determinar cuál o cuáles son los clientes con las compras más altas y a qué ciudad corresponden los mismos. Esto permitirá en un futuro que VendeTodo
SPA pueda buscar convenios con algunas empresas despachadoras.*/

SELECT  cliente.nombre_empresa, ciudad.nombre_ciudad AS ciudad, oc.id_orden_compra AS num_factura, 
SUM((detalle.precio_venta_unidad - detalle.descuento)*cantidad_producto) AS monto_total_compra
FROM detalle_orden_compra detalle
LEFT JOIN orden_compra oc
ON (detalle.orden_compra_id_orden_compra = oc.id_orden_compra)
LEFT JOIN cliente
ON (oc.cliente_rut_cliente = cliente.rut_cliente)
LEFT JOIN ciudad
ON (cliente.ciudad_id_ciudad = ciudad.id_ciudad)
GROUP BY detalle.orden_compra_id_orden_compra, cliente.nombre_empresa, ciudad.nombre_ciudad, oc.id_orden_compra
ORDER BY monto_total_compra DESC;


/*Se necesita saber los nombre de los distribuidores de los productos más vendidos, esto permitirá evaluar comprar por volumen. Solo es necesario que
se listen los nombres de todos los registros que cumplan con la solicitud 

(EL TERMINO "distribuidores" DEL EJERCICIO LO ENCUENTRO AMBIGUO, YA QUE PUEDE SER UN PROVEEDOR O UN DESPACHADOR; POR LO TANTO, HICE 3 QUERIES DISTINTAS 
PARA EL EJERCICIO PEDIDO)*/


SELECT DISTINCT proveedores.nombre_compania AS empresa_proveedora, producto.nombre ,SUM(detalle.cantidad_producto) AS total_prod_vendidos
FROM detalle_orden_compra detalle
INNER JOIN producto
ON detalle.producto_id_producto = producto.id_producto
INNER JOIN proveedores
ON producto.proveedores_rut_proveedor = proveedores.rut_proveedor 
GROUP BY producto.nombre, proveedores.nombre_compania 
ORDER BY total_prod_vendidos DESC;


SELECT DISTINCT despachadores.nombre AS empresa_despachadora, producto.nombre,  SUM(detalle.cantidad_producto) AS total_prod_despachados
FROM despachadores
INNER JOIN orden_compra oc
ON despachadores.rut_despachador = oc.despachadores_rut_despachador
INNER JOIN detalle_orden_compra detalle
ON oc.id_orden_compra = detalle.orden_compra_id_orden_compra
INNER JOIN producto 
ON detalle.producto_id_producto = producto.id_producto 
GROUP BY producto.nombre, despachadores.nombre 
ORDER BY total_prod_despachados DESC;


SELECT despachadores.nombre AS empresa_distribuidora, SUM(detalle.cantidad_producto) AS productos_totales_enviados_vendidos
FROM despachadores
INNER JOIN orden_compra oc
ON (despachadores.rut_despachador = oc.despachadores_rut_despachador)
INNER JOIN detalle_orden_compra detalle
ON (oc.id_orden_compra = detalle.orden_compra_id_orden_compra)
GROUP BY despachadores.nombre
ORDER BY productos_totales_enviados_vendidos DESC;



