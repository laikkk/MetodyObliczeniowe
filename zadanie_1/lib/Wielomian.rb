require_relative './Wezel'

class Wielomian
  attr_accessor :PodX
  attr_accessor :RownanieWielomianu
  attr_accessor :CalkowanyWielominan

  def initialize(peOdX, iloscWspolczynnikow)
    if(IsValidParameters(peOdX, iloscWspolczynnikow))
      @PodX = peOdX
      @RownanieWielomianu = Array.new
      for i in 0..iloscWspolczynnikow - 1
        @RownanieWielomianu << Wezel.new(i, peOdX)
      end
    else
      raise "Invalid argument"
    end
  end

  def PostacOgolna()  
    @PodX = "x"
    @RownanieWielomianu.each { |wezel| 
      wezel.X = "x"
    } 
  end

  def ToString()
      sb = String.new
      sb += "P(#{@PodX}) = "

      rownaniePomocnicze = Array.new
      @RownanieWielomianu.each { |wezel| rownaniePomocnicze << wezel}
      sb += rownaniePomocnicze.first.ToString
      rownaniePomocnicze.shift

      rownaniePomocnicze.each { |wezel| 
        txt = wezel.ToString
        if (!txt.empty?)
          sb += " + #{txt}"
        end
      }

      return sb
  end

  # podstawia wartosci zamiast an 
  def PodstawAn(ans)  
    @RownanieWielomianu.each{ |wezel|  
      if(ans.key?(wezel.Wspolczynnik))
        wezel.Wspolczynnik = ans[wezel.Wspolczynnik]
      end
    }
  end
  
  def WyliczGdzieSieDa()
    @RownanieWielomianu.each { |wezel|
      if(!wezel.ToString.include? "a")
        wezel.WartoscWezla = wezel.Wspolczynnik.to_f * wezel.WspolczynnikPomocniczy.to_f * (wezel.X.to_f ** wezel.Potega.to_f)
      end
    }
  end

  def PoliczCalke(a, b)
    if(b > a)
      return (PoliczWartoscWielomianuWPunkcie(b) - PoliczWartoscWielomianuWPunkcie(a)).round(4)
    else
      return (PoliczWartoscWielomianuWPunkcie(a) - PoliczWartoscWielomianuWPunkcie(b)).round(4)
    end
  end
  
  def WyznaczCalke()
    @CalkowanyWielominan = Array.new
    @RownanieWielomianu.each { |wezel| 
      wspolczynnik = wezel.Wspolczynnik.to_f
      nowaPotega = wezel.Potega + 1
      wspolczynnik = wspolczynnik / nowaPotega
      @CalkowanyWielominan << Wezel.new(nowaPotega, "x", wspolczynnik.to_s, wezel.WspolczynnikPomocniczy)
    }
  end

  # zwraca wartosc wspolczynnika ktory nie zostal jeszcze obliczony, tzn zwraca an..a1
  def An()
    return @RownanieWielomianu.first.Wspolczynnik
  end
  
  # zwraca wartosc tego co stoi przy an..a1, jako wspolczynnik pomocniczy
  def ToCoStoiPrzyA()
    return @RownanieWielomianu.first.WspolczynnikPomocniczy
  end

  private
 
  def IsValidParameters(peOdX, iloscWspolczynnikow)
    isValid = true
  
    if(!peOdX.is_a? String)
      isValid = false
    end

    if(!iloscWspolczynnikow.is_a? Fixnum)
      isValid = false
    end

    return isValid
  end

  def PoliczWartoscWielomianuWPunkcie(p)
    suma = 0.0;
      @CalkowanyWielominan.each { |wezel|
        wspolczynnik = wezel.Wspolczynnik.to_f
        suma += wspolczynnik * wezel.WspolczynnikPomocniczy * (p ** wezel.Potega)
      }
    return suma
  end
end