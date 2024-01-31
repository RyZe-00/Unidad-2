require_relative 'cliente'
require_relative 'articulo'
require_relative 'factura'

include TiendaOnline

cliente1 = Cliente.new("123456789", "Juan", "Perez")

articulo1 = Articulo.new("A001", "Camiseta", 20.0)
articulo2 = Articulo.new("A002", "Pantalón", 30.0)

factura = Factura.new("F001", cliente1)

factura.agregar_linea(articulo1, 2)
factura.agregar_linea(articulo2, 1)

factura.imprimir_factura
