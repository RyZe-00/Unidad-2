module TiendaOnline
  class Factura
    attr_accessor :numero, :cliente, :lineas

    def initialize(numero, cliente)
      @numero = numero
      @cliente = cliente
      @lineas = []
    end

    def agregar_linea(articulo, cantidad)
      @lineas << { articulo: articulo, cantidad: cantidad }
    end

    def eliminar_linea(articulo)
      @lineas.reject! { |linea| linea[:articulo] == articulo }
    end

    def imprimir_factura
      puts "Factura Nro: #{@numero}"
      puts "Cliente: #{@cliente.nombre} #{@cliente.apellidos} (DNI: #{@cliente.dni})"
      puts "%-15s %-25s %-10s %-10s %-10s" % ["Código", "Denominación", "Precio", "Cantidad", "Subtotal"]
      puts "-" * 80

      total_factura = 0

      @lineas.each do |linea|
        articulo = linea[:articulo]
        cantidad = linea[:cantidad]
        subtotal = articulo.precio * cantidad
        total_factura += subtotal

        puts "%-15s %-25s %-10.2f %-10d %-10.2f" % [articulo.codigo, articulo.denominacion, articulo.precio, cantidad, subtotal]
      end

      puts "-" * 80
      puts "Monto Total: $#{total_factura}"
    end
  end
end
