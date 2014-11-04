using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MetodyObliczeniowe
{
	public class Wielomian : ICloneable
	{
		#region Public properites

		//P(x)
		public string PodX { get; set; }
		// a0 + a1x0 +a2x0^2 + a3x0^3
		public List<Wezel> RownanieWielomianu;
		public List<Wezel> CalkowanyWielominan;

		#endregion

		#region public method

		public Wielomian(string peOdX, int iloscWspolczynnikow)
		{
			PodX = peOdX;
			RownanieWielomianu = new List<Wezel>(iloscWspolczynnikow);
			for (int i = 0; i < iloscWspolczynnikow; i++)
			{
				RownanieWielomianu.Add(new Wezel(i, peOdX));
			}
		}

		public void PostacOgolna()
		{
			PodX = "x";
			foreach (var wezel in RownanieWielomianu)
			{
				wezel.X = "x";
			}
		}

		public override string ToString()
		{
			StringBuilder sb = new StringBuilder();
			sb.Append("P(" + PodX + ") = ");
			var rownaniePomocnicze = new List<Wezel>(RownanieWielomianu);
			sb.Append(rownaniePomocnicze.First().ToString());
			rownaniePomocnicze.Remove(rownaniePomocnicze.First());
			rownaniePomocnicze.ForEach(wezel =>
			{
				string textWezel = wezel.ToString();
				if (!string.IsNullOrEmpty(textWezel))
					sb.Append(string.Format(" + {0}", textWezel));
			});
			return sb.ToString();
		}

		public void PodstawAn(Dictionary<string, double> Ans)
		{
			RownanieWielomianu.ForEach(wezel =>
			{
				if (Ans.Keys.Contains(wezel.Wspolczynnik))
				{
					wezel.Wspolczynnik = Ans[wezel.Wspolczynnik].ToString();
				}
			});
		}

		public void WyliczGdzieSieDa()
		{
			RownanieWielomianu.ForEach(wezel =>
				{
					if (wezel.ToString().Contains("a")) return;
					wezel.WartoscWezla = Convert.ToDouble(wezel.WspolczynnikPomocniczy) * Convert.ToDouble(wezel.Wspolczynnik) * Math.Pow(Convert.ToDouble(wezel.X), Convert.ToDouble(wezel.Potega));
				});
		}

		public double PoliczCalke(double a, double b)
		{
			return b > a ? Math.Round(PoliczWartoscWielomianuWPunkcie(b) - PoliczWartoscWielomianuWPunkcie(a), 4) : Math.Round(PoliczWartoscWielomianuWPunkcie(a) - PoliczWartoscWielomianuWPunkcie(b), 4);
		}

		public void WyznaczCalke()
		{
			CalkowanyWielominan = new List<Wezel>();

			foreach (var wezel in RownanieWielomianu)
			{
				double wspolczynnik;
				double.TryParse(wezel.Wspolczynnik, out wspolczynnik);
				int newPotega = wezel.Potega + 1;
				wspolczynnik /= newPotega;
				CalkowanyWielominan.Add(new Wezel(newPotega, wspolczynnik.ToString(), wezel.WspolczynnikPomocniczy));
			}
		}

		public string An()
		{
			return RownanieWielomianu.First().Wspolczynnik;
		}

		public double ToCoStoiPrzyA()
		{
			return RownanieWielomianu.First().WspolczynnikPomocniczy;
		}

		public object Clone()
		{
			return this.MemberwiseClone();
		}

		#endregion

		#region private method

		private double PoliczWartoscWielomianuWPunkcie(double p)
		{
			double suma = 0.0;
			foreach (var wezel in CalkowanyWielominan)
			{
				double wspolczynnik;
				Double.TryParse(wezel.Wspolczynnik, out wspolczynnik);
				suma += wspolczynnik * wezel.WspolczynnikPomocniczy * Math.Pow(p, wezel.Potega);
			}
			return suma;
		}

		#endregion
	}
}
