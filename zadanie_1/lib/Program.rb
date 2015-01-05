require_relative './Wezel'
require_relative './Wielomian'
require_relative './Rownanie'
require_relative './WczytajDane'

dane = WczytajDane.new
dane.Wczytaj
wielomian = Wielomian.new(dane.x0.to_s, dane.ygreks.count);     
rownanie = Rownanie.new
ukladRownan = rownanie.UtworzUkladRownan(dane.ygreks, wielomian);     
tabAn = rownanie.RozwiazUkladRownan(ukladRownan)

puts "Wielomian w postaci ogolnej\n"
wielomian.PodstawAn(tabAn)
wielomian.PostacOgolna
puts wielomian.ToString

wielomian.WyznaczCalke();
puts "\nWartosc calki oznaczonej == #{wielomian.PoliczCalke(dane.a, dane.b)}\n\n"

puts "Koniec programu"