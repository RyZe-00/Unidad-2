module TiendaOnline
  class Cliente
    attr_accessor :dni, :nombre, :apellidos

    def initialize(dni, nombre, apellidos)
      begin
        validar_dni(dni)
      rescue StandardError => e
        puts "Error: #{e.message}"
        print "Ingrese el DNI nuevamente: "
        dni = gets.chomp
        retry # Intentar nuevamente
      end

      @dni = dni
      @nombre = nombre
      @apellidos = apellidos
    end

    private

    def validar_dni(dni)
      raise ArgumentError, 'DNI no válido' unless dni.match?(/^\d{8}$/)
    end
  end
end
