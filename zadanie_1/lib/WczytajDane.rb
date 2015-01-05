class WczytajDane
  attr_accessor :a
  attr_accessor :b
  attr_accessor :x0
  attr_accessor :ygreks
  attr_accessor :isValidData
  def initialize
    @ygreks = Array.new
  end

  def Wczytaj
    @isValidData = true
    puts "Podaj y'greki oddzielone spacjami"
    a = gets.chomp
    a = a.split(' ')
    a.each { |value|
      if (!value.is_f?)
        @isValidData = false
        puts "Wartosc #{value} jest nieprawna!"
      else
        ygreks << value.to_f
      end
    }
    
    if(@isValidData)
      @x0 = WczytajLiczbe("x0")
    end
    
    if(@isValidData)
      @a = WczytajLiczbe("a")
    end
    
    if(@isValidData)
      @b = WczytajLiczbe("b")
    end
  end

  private
  def WczytajLiczbe(liczba)
    print "Podaj #{liczba}: "
    pom = gets.chomp
    if (!pom.is_f?) 
      @isValidData = false
      puts "Wartosc #{pom} jest nieprawna dla #{liczba}!"
    else
      return pom.to_f
    end
  end
end

class String
    def is_f?
       # /\A[-+]?\d+\z/ === self
      # /^[-+]?[0-9]\d{0,4}(\.\d*)?$/ === self
      /^[-+]?[0-9]*(\.\d*)?$/ === self
    end
end