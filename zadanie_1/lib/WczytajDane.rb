class WczytajDane
  attr_accessor :a
  attr_accessor :b
  attr_accessor :x0
  attr_accessor :ygreks
  @isValidData

  def initialize
    @ygreks = [1, 3, 4, 2]
    @a = 1.0
    @b = 2.0
    @x0 = 1.0
  end

  def Wczytaj
    @isValidData = true
    puts "Podaj y'greki oddzielone spacjami"
    a = gets.chomp
    
    tmp = SprawdzWczytaneY(a)
    x0 = WczytajLiczbe("x0")
    a = WczytajLiczbe("a")
    b = WczytajLiczbe("b")

    if(@isValidData)
      @ygreks = tmp
      @a = a
      @b = b
      @x0 = x0
    else
      puts "\n! - Zostana uzyte domyslne wartosci! - !\n\n"
    end
  end

  private
  def WczytajLiczbe(liczba)
    print "Podaj #{liczba}: "
    pom = gets.chomp
    if (pom.empty? || !pom.is_f?) 
      @isValidData = false
      puts "Wartosc #{pom} jest nieprawna dla #{liczba}!"
    else
      return pom.to_f
    end
  end

  def SprawdzWczytaneY(a)
    pom = []
    if(!a.empty?)
      a = a.split(' ')
      a.each { |value|
        if (value.empty? || !value.is_f?)
          @isValidData = false
          puts "Wartosc #{value} jest nieprawna!"
        else
          pom << value.to_f
        end
      }
    else
      puts "Nie wprowadzono wartosci!"
      @isValidData = false
    end
    return pom
  end
    
end

class String
    def is_f?
       # /\A[-+]?\d+\z/ === self
      # /^[-+]?[0-9]\d{0,4}(\.\d*)?$/ === self
      /^[-+]?[0-9]*(\.\d*)?$/ === self
    end
end