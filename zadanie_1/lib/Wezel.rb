class Wezel
  attr_accessor :Potega
  attr_accessor :Wspolczynnik
  attr_accessor :WspolczynnikPomocniczy
  attr_accessor :X
  attr_accessor :WartoscWezla

  def initialize(potega, x = "x", wspolczynnik = "", wspPom = 1.0) 
    if(IsValidParameters(potega, x, wspolczynnik, wspPom))
      @Potega = potega
      @X = x
      @WspolczynnikPomocniczy = wspPom
      @WartoscWezla = 0
      if(wspolczynnik == "")
        @Wspolczynnik = "a#{@Potega}"
      else
        @Wspolczynnik = wspolczynnik
      end
    else
      raise "Invalid argument"
    end
  end

  def ToString 
    if (@WspolczynnikPomocniczy == 0.0 || @Wspolczynnik == "0.0")
      return
    end

    if(@Wspolczynnik.to_s.include? "a")
      rownianie = "#{@Wspolczynnik}"
    else
      wynik = @Wspolczynnik.to_f
      rownianie = "#{wynik.round(2)}"
    end

    if(@WspolczynnikPomocniczy != 1)
      rownianie += "*#{@WspolczynnikPomocniczy}"
    end

    rownianie += "*#{@X}^#{@Potega}"
  end

  private
  
    def IsValidParameters(potega, x, wspolczynnik, wspPom)
      isValid = true
    
      if(!potega.is_a? Fixnum)
        isValid = false
      end

      if(!x.is_a? String)
        isValid = false
      end
    
      if(!wspolczynnik.is_a? String)
        isValid = false
      end

      if(!wspPom.is_a? Float)
        isValid = false
      end

      return isValid
    end
end