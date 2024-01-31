require_relative 'cliente'
require_relative 'articulo'
require_relative 'factura'

module TiendaOnline
  class ProgramaTienda
    def initialize
      @clientes = []
      @articulos = []
      @facturas = []
    end

    def mostrar_lineas_factura(factura)
      puts "Líneas de la Factura:"
      factura.lineas.each_with_index do |linea, index|
        articulo = linea[:articulo]
        cantidad = linea[:cantidad]
        puts "#{index + 1}. #{articulo.denominacion} - Cantidad: #{cantidad}"
      end
    end

    def eliminar_linea_factura(factura)
      return if factura.nil? || factura.lineas.empty?

      puts "Selecciona una línea para eliminar:"
      mostrar_lineas_factura(factura)
      index = gets.chomp.to_i - 1

      if index >= 0 && index < factura.lineas.length
        linea_eliminar = factura.lineas[index]
        factura.eliminar_linea(linea_eliminar[:articulo])
        puts "Línea #{index + 1} eliminada correctamente."
      else
        puts "Índice no válido. La línea no fue eliminada."
      end
    end

    def ejecutar
      loop do
        mostrar_menu_principal
        opcion = obtener_opcion_usuario

        case opcion
        when 1
          system('clear') || system('cls')
          agregar_cliente
        when 2
          system('clear') || system('cls')
          agregar_articulo
        when 3
          system('clear') || system('cls')
          crear_factura
        when 4
          system('clear') || system('cls')
          mostrar_facturas
        when 5
          break
        else
          puts "Opción no válida. Inténtalo de nuevo."
        end
      end
    end

    private

    def mostrar_menu_principal
      puts "\n--- Tienda Online ---"
      puts "1. Agregar Cliente"
      puts "2. Agregar Artículo"
      puts "3. Crear Factura"
      puts "4. Mostrar Facturas"
      puts "5. Salir"
    end

    def obtener_opcion_usuario
      print "Ingrese su opción: "
      gets.chomp.to_i
    end

    def agregar_cliente
      print "Ingrese el DNI del cliente: "
      dni = gets.chomp
      print "Ingrese el nombre del cliente: "
      nombre = gets.chomp
      print "Ingrese los apellidos del cliente: "
      apellidos = gets.chomp

      cliente = Cliente.new(dni, nombre, apellidos)
      @clientes << cliente
      puts "Cliente agregado correctamente."
    end

    def agregar_articulo
      print "Ingrese el código del artículo: "
      codigo = gets.chomp
      print "Ingrese la denominación del artículo: "
      denominacion = gets.chomp
      print "Ingrese el precio del artículo: "
      precio = gets.chomp.to_f

      articulo = Articulo.new(codigo, denominacion, precio)
      @articulos << articulo
      puts "Artículo agregado correctamente."
    end

    def crear_factura
      if @clientes.empty? || @articulos.empty?
        puts "Debes tener al menos un cliente y un artículo para crear una factura."
        return
      end

      puts "Selecciona un cliente:"
      mostrar_lista_clientes
      cliente = seleccionar_cliente

      numero_factura = "F#{Time.now.strftime('%Y%m%d%H%M%S')}"

      factura = Factura.new(numero_factura, cliente)

      factura_confirmada = false

      loop do
        mostrar_lista_articulos
        articulo = seleccionar_articulo

        print "Ingrese la cantidad: "
        cantidad = gets.chomp.to_i

        factura.agregar_linea(articulo, cantidad)

        print "¿Agregar otro artículo a la factura? (S/N): "
        break unless gets.chomp.downcase == 's'
      end

      puts "\n¿Deseas confirmar la factura? (S/N): "
      confirmar = gets.chomp.downcase

      if confirmar != 's'
        loop do
          puts "Factura cancelada. ¿Deseas eliminar alguna línea de la factura? (S/N): "
          eliminar_linea = gets.chomp.downcase

          if eliminar_linea == 's'
            eliminar_linea_factura(factura)
            puts "Línea eliminada correctamente."
          else
            puts "Factura cancelada. No se ha agregado a la lista de facturas."
            return
          end

          puts "\n¿Deseas eliminar otra línea de la factura? (S/N): "
          break unless gets.chomp.downcase == 's'
        end
        @facturas << factura
        puts "Factura confirmada y agregada correctamente."
      else
        @facturas << factura
        puts "Factura confirmada y agregada correctamente."
      end

    end


    def mostrar_lista_clientes
      @clientes.each_with_index { |cliente, index| puts "#{index + 1}. #{cliente.nombre} #{cliente.apellidos}" }
    end

    def seleccionar_cliente
      index = gets.chomp.to_i - 1
      @clientes[index]
    end

    def mostrar_lista_articulos
      @articulos.each_with_index { |articulo, index| puts "#{index + 1}. #{articulo.denominacion}" }
    end

    def seleccionar_articulo
      index = gets.chomp.to_i - 1
      @articulos[index]
    end

    def mostrar_facturas
      if @facturas.empty?
        puts "No hay facturas para mostrar."
        return
      end

      @facturas.each do |factura|
        factura.imprimir_factura
        puts "-" * 80
      end
    end
  end
end

# Ejecutar el programa
TiendaOnline::ProgramaTienda.new.ejecutar
