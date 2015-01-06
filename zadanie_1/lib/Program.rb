require 'optparse'
require_relative './Wezel'
require_relative './Wielomian'
require_relative './Rownanie'
require_relative './WczytajDane'

def MetodyEulera
	puts "Metody eulera"
end

def WyznaczanieWielomianu
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
end

parser = ['-e', '-w', '-h', '--euler', '--wielomian', '--help']
if !parser.include? ARGV[0] || ARGV.length != 1
  ARGV[0] = '-h'
end

options = {}
optparse = OptionParser.new do |opts|
  opts.banner = "Uzycie: program.rb [metoda]"
  opts.on('-e', '--euler', 'Metody Eulera i punktu srodkowego rozwiazania zagadnienia rozniczkowego') { MetodyEulera() }
  opts.on('-w', '--wielomian', 'Wyznaczanie wielomianu stopnia n na podstawia pochodnych') { WyznaczanieWielomianu() }
  opts.on('-h', '--help', 'Wyswietl pomoc') do 
      puts opts
  end
end.parse!
