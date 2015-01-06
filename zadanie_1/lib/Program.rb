require 'optparse'
require_relative './Wezel'
require_relative './Wielomian'
require_relative './Rownanie'
require_relative './WczytajDane'
require_relative '../../zadanie 3/zad3.rb'

def MetodyEulera
    klasa = Euler.new
  klasa.getN
  klasa.getA
  klasa.calculate_xk
  klasa.calculate_euler
  klasa.calculate_midpoint
  klasa.calculate_accurate
  klasa.make_table
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

if ARGV.length != 1
  ARGV = ["-h"]
end

optparse = OptionParser.new do |opts|
  opts.banner = "Uzycie: program.rb [paramets]"
  opts.on('-e', 'Metody Eulera i punktu srodkowego rozwiazania zagadnienia rozniczkowego') { MetodyEulera() }
  opts.on('-w', 'Wyznaczanie wielomianu stopnia n na podstawia pochodnych') { WyznaczanieWielomianu() }
  opts.on('-h', 'Wyswietl pomoc') do 
      puts opts
  end

  help = opts.help
  begin
    opts.parse!
  rescue OptionParser::InvalidOption => e
    puts help
  end
end.parse!