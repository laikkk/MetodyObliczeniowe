require_relative './Wezel'
require_relative './Wielomian'

class Rownanie
	attr_accessor :LewaStrona
	attr_accessor :PrawaStrona

	# def initialize(wielomian, ygreks)
	# 	if(IsValidParameters(wielomian, ygreks))
	# 		@LewaStrona = wielomian
	# 		@PrawaStrona = ygreks
	# 	else
	# 		raise "Invalid argument"
 #    	end
	# end

	def ToString
		return "#{@LewaStrona.ToString} = #{@PrawaStrona}"
	end

	def Wylicz()
        a = @LewaStrona.An()
        wynik = 0.0
        if (@PrawaStrona != 0)
            liczbaZLewejStronyRownania = @LewaStrona.ToCoStoiPrzyA
            sumaPozostalychWezlow = 0.0
            @LewaStrona.RownanieWielomianu.each { |wezel| 
            	sumaPozostalychWezlow = (sumaPozostalychWezlow + wezel.WartoscWezla) * -1 }

            sumaPozostalychWezlow.round(14)
            wynik = (@PrawaStrona + sumaPozostalychWezlow) / liczbaZLewejStronyRownania
        end

        return { a => wynik }
	end

	def UtworzUkladRownan(ygreks, wielomian)
		ukladRownan = Array.new(ygreks.count)
		for i in 0..ygreks.count - 1
			pom = wielomian	
			for j in 0..i - 1
				pom = PochodnaWielomianu(pom)
			end

			rownanie = Rownanie.new
			rownanie.LewaStrona = pom
			rownanie.PrawaStrona = ygreks[i]
			ukladRownan[i] = rownanie
		end

		return ukladRownan
	end

	def RozwiazUkladRownan(ukladRownan)
		tabAn = Hash.new
		ukladRownan.reverse_each { |rownanie|
			rownanie.LewaStrona.PodstawAn(tabAn)
			rownanie.LewaStrona.WyliczGdzieSieDa()
			obliczenia = rownanie.Wylicz()
			tabAn.merge!(obliczenia)
		}

		return tabAn
	end


	private 
	def IsValidParameters(wielomian, ygreks)
		isValid = true
		
		if(!wielomian.is_a? Wielomian)
			isValid = false
		end

		if(!ygreks.is_a? Float)
			isValid = false
		end

		return isValid
	end
	
	# Metoda obliczajaca pochodna z wielomianu, nie potrzeba wyliczania wartosci!
	def PochodnaWielomianu(wielomian)
        tmp = Wielomian.new(wielomian.PodX, wielomian.RownanieWielomianu.count)
        tmp.RownanieWielomianu = Array.new
        wielomian.RownanieWielomianu.each { |x|
        	if(x.Potega > 0) 
	        	a = x.clone
	        	a.WspolczynnikPomocniczy = x.Potega * x.WspolczynnikPomocniczy
	        	a.Potega -= 1
	        	tmp.RownanieWielomianu << a
        	end
        }
        return tmp
	end
end

# wielomian = Wielomian.new("X", 2)
# puts wielomian.ToString

# pochodna = wielomian.PochodnaWielomianu(Wielomian.new("X", 2))

# puts pochodna.ToString
