require_relative './Wezel'
require_relative './Wielomian'
require_relative './Rownanie'
# require_relative './WczytajDane'

# //Wezel wezel = new Wezel(22, "23");
	# //Console.WriteLine(wezel.ToString());
	# double a, b, x0;
	# a = b = x0 = 0;
	ygreks = Array.new [1, 2, 2, 2] #WczytajY();
	# WczytajLiczby(ref a, ref b, ref x0);
	a = 1.0
	b = 1.0
	x0 = 1.0
	# dane = WczytajDane.new
	# dane.Wczytaj
	wielomian = Wielomian.new(x0.to_s, ygreks.count);			
	rownanie = Rownanie.new
	ukladRownan = rownanie.UtworzUkladRownan(ygreks, wielomian);			
	tabAn = rownanie.RozwiazUkladRownan(ukladRownan)

	puts "Wielomian w postaci ogolnej\n"
	wielomian.PodstawAn(tabAn)
	wielomian.PostacOgolna
	puts wielomian.ToString

	wielomian.WyznaczCalke();
	puts "\nWartosc calki oznaczonej == #{wielomian.PoliczCalke(a, b)}\n\n"