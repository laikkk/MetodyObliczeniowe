using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MetodyObliczeniowe
{
	public class Wezel : ICloneable
	{
		#region public Properties

		public int Potega { get; set; }
		public string Wspolczynnik { get; set; } //An
		public int WspolczynnikPomocniczy = 1;
		public string X { get; set; }
		public double WartoscWezla { get; set; } //Trzyma obliczona juz wartosc wezla

		#endregion

		#region Method

		public Wezel(int potega, string x = "x")
		{
			X = x;
			Potega = potega;
			Wspolczynnik = "a" + Potega;
		}

		public override string ToString()
		{
			if (WspolczynnikPomocniczy == 0 || Wspolczynnik.Equals("0"))
			{
				return "";
			}
			double wspolczynnik = 0.0;
			if (!Wspolczynnik.Contains("a"))
				Double.TryParse(Wspolczynnik, out wspolczynnik);

			string rownianie = string.Format("{0}", Wspolczynnik.Contains("a") ? Wspolczynnik : Math.Round(wspolczynnik, 2).ToString());

			if (WspolczynnikPomocniczy != 1)
				rownianie += string.Format("*{0}", WspolczynnikPomocniczy);

			rownianie += string.Format("*{0}^{1}", X, Potega);

			return rownianie;
		}

		public object Clone()
		{
			return this.MemberwiseClone();
		}

		#endregion Method
	}
}
