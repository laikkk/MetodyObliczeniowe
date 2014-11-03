using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MetodyObliczeniowe
{
    public class Rownanie
    {
		#region Public properties

        public Wielomian LewaStrona { get; set; }
        public double PrawaStrona { get; set; }

		#endregion

		#region Public Method

        public override string ToString()
        {
            return string.Format("{0} = {1}", LewaStrona, PrawaStrona);
        }

        public KeyValuePair<string, double> Wylicz()
        {
            string a = LewaStrona.An(); 
            double wynik = 0;
            if (PrawaStrona != 0)
            {
                double liczbaZLewejStronyRownania = LewaStrona.ToCoStoiPrzyA();
                double sumaPozostalychWezlow = Math.Round(LewaStrona.RownanieWielomianu.Sum(x => x.WartoscWezla), 14) * -1;
                wynik = (PrawaStrona + sumaPozostalychWezlow) / liczbaZLewejStronyRownania;
            }

            return new KeyValuePair<string, double>(a, wynik);
        }

		#endregion
    }
}
