using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MetodyObliczeniowe
{
    public class Wezel : ICloneable
    {
        public int Potega { get; set; }
        public string Wspolczynnik { get; set; } //An
        public int WspolczynnikPomocniczy = 1;
        public string X { get; set; }
        public double WartoscWezla { get; set; } //Trzyma obliczona juz wartosc wezla

        public Wezel(int potega, string x = "x")
        {
            X = x;
            Potega = potega;
            Wspolczynnik = "a" + Potega;
        }

        public override string ToString()
        {
            if (WspolczynnikPomocniczy == 0)
            {
                return "    ";
            }
            if (WspolczynnikPomocniczy == 1)
            {
                return string.Format(" + {0} {1}^{2}", Wspolczynnik, X, Potega);
            }
            else
            {
                return string.Format(" + {0} {1} {2}^{3}", WspolczynnikPomocniczy, Wspolczynnik, X, Potega);
            }
        }

        public object Clone()
        {
            return this.MemberwiseClone();
        }
    }
}
