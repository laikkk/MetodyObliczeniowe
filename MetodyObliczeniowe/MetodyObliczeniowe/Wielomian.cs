using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MetodyObliczeniowe
{
    public class Wielomian : ICloneable
    {
        //P(x)
        public string PodX { get; set; }
        // a0 + a1x0 +a2x0^2 + a3x0^3
        public List<Wezel> rownanieWielomianu;

        public Wielomian(string peOdX, int iloscWspolczynnikow)
        {
            PodX = peOdX;
            rownanieWielomianu = new List<Wezel>(iloscWspolczynnikow);
            for (int i = 0; i < iloscWspolczynnikow; i++)
            {
                rownanieWielomianu.Add(new Wezel(i, peOdX));
            }
        }

        public void PostacOgolna()
        {
            PodX = "x";
            foreach (var wezel in rownanieWielomianu)
            {
                wezel.X = "x";
            }
        }

        public override string ToString()
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("P(" + PodX + ") = ");
            rownanieWielomianu.ForEach(wezel => sb.Append(wezel.ToString()));
            return sb.ToString();
        }

        public Wielomian LiczPochodna(Wielomian rownanie)
        {
            Wielomian tmp = rownanie;
            tmp.rownanieWielomianu = new List<Wezel>();
            rownanie.rownanieWielomianu.ForEach(x =>
                {
                    if (x.Potega <= 0) return;
                    x.WspolczynnikPomocniczy = (x.Potega * x.WspolczynnikPomocniczy);
                    x.Potega--;
                    tmp.rownanieWielomianu.Add(x);
                });
            return tmp;
        }

        public void PodstawAn(Dictionary<string, double> Ans)
        {
            rownanieWielomianu.ForEach(wezel =>
            {
                if (Ans.Keys.Contains(wezel.Wspolczynnik))
                {
                    wezel.Wspolczynnik = " " + Ans[wezel.Wspolczynnik].ToString();
                }
            });
        }

        public void WyliczGdzieSieDa()
        {
            rownanieWielomianu.ForEach(wezel =>
                {
                    if (wezel.ToString().Contains("a")) return;
                    wezel.WartoscWezla = Convert.ToDouble(wezel.WspolczynnikPomocniczy) * Convert.ToDouble(wezel.Wspolczynnik) * Math.Pow(Convert.ToDouble(wezel.X), Convert.ToDouble(wezel.Potega));
                });
        }

        public string Calka(string a, string b)
        {
            var qb = (Wielomian)this.Clone();
            foreach (var wezel in rownanieWielomianu)
            {
                wezel.Potega += 1;
                wezel.Wspolczynnik = a;
                wezel.Wspolczynnik = wezel.Wspolczynnik + " /" + wezel.Potega.ToString();
            }
            foreach (var wezel in qb.rownanieWielomianu)
            {
                wezel.Potega += 1;
                wezel.Wspolczynnik = b;
                wezel.Wspolczynnik = wezel.Wspolczynnik + " /" + wezel.Potega.ToString();
            }
            return string.Format("( {0} ) - ( {1} )", qb, this);
        }

        public string An()
        {
            return rownanieWielomianu.First().Wspolczynnik;
        }

        public double toCoStoiPrzyA()
        {
            return rownanieWielomianu.First().WspolczynnikPomocniczy;
        }

        public object Clone()
        {
            return this.MemberwiseClone();
        }
    }
}
