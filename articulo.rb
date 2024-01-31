module TiendaOnline
  class Articulo
    attr_accessor :codigo, :denominacion, :precio

    def initialize(codigo, denominacion, precio)
      @codigo = codigo
      @denominacion = denominacion
      @precio = precio
    end
  end
end
