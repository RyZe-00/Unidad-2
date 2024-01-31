module TiendaOnline
  class Cliente
    attr_accessor :dni, :nombre, :apellidos

    def initialize(dni, nombre, apellidos)
      @dni = dni
      @nombre = nombre
      @apellidos = apellidos
    end
  end
end
