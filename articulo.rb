module TiendaOnline
  class Articulo
    attr_accessor :codigo, :denominacion, :precio

    def initialize(codigo, denominacion, precio)
      begin
        validar_precio(precio)
      rescue StandardError => e
        puts "Error: #{e.message}"
        print "Ingrese el precio nuevamente: "
        precio = gets.chomp.to_f
        retry # Intentar nuevamente
      end
      @codigo = codigo
      @denominacion = denominacion
      @precio = precio
    end

    private

    def validar_precio(precio)
      raise ArgumentError, 'Precio debe ser un número positivo' unless precio.to_f.positive?
    end

  end
end
