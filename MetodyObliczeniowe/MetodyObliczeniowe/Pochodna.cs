using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MetodyObliczeniowe
{
    public class Pochodna
    {
        public static Wielomian Wielomianu(Wielomian wielomian)
        {
            Wielomian tmp = new Wielomian(wielomian.PodX, wielomian.RownanieWielomianu.Count);
            tmp.RownanieWielomianu = new List<Wezel>();
            wielomian.RownanieWielomianu.ForEach(x =>
            {
                if (x.Potega <= 0) return;
                Wezel a = (Wezel)x.Clone();
                a.WspolczynnikPomocniczy = x.Potega * x.WspolczynnikPomocniczy;
                a.Potega--;
                tmp.RownanieWielomianu.Add(a);
            });

            return tmp;
        }
    }
}
