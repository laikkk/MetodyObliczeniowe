using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MetodyObliczeniowe
{
    public class Rownanie
    {
        public Wielomian lewaStrona { get; set; }
        public double prawaStrona { get; set; }

        public override string ToString()
        {
            return string.Format("{0} = {1}", lewaStrona, prawaStrona);
        }

        public KeyValuePair<string, double> Wylicz()
        {
            string a = lewaStrona.An(); 
            double wynik = 0;
            if (prawaStrona != 0)
            {
                double liczbaZLewejStronyRownania = lewaStrona.toCoStoiPrzyA();
                double sumaPozostalychWezlow = Math.Round(lewaStrona.rownanieWielomianu.Sum(x => x.WartoscWezla), 14) * -1;
                wynik = (prawaStrona + sumaPozostalychWezlow) / liczbaZLewejStronyRownania;
            }

            return new KeyValuePair<string, double>(a, wynik);
        }
    }
}
