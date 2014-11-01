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
            Wielomian tmp = new Wielomian(wielomian.PodX, wielomian.rownanieWielomianu.Count);
            tmp.rownanieWielomianu = new List<Wezel>();
            wielomian.rownanieWielomianu.ForEach(x =>
            {
                if (x.Potega <= 0) return;
                Wezel a = (Wezel)x.Clone();
                a.WspolczynnikPomocniczy = x.Potega * x.WspolczynnikPomocniczy;
                a.Potega--;
                tmp.rownanieWielomianu.Add(a);
            });

            return tmp;
        }
    }
}
