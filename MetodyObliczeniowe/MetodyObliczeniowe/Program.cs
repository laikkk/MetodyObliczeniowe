using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MetodyObliczeniowe
{
    public class Program
    {
        public static void Main(string[] args)
        {
            List<double> ygreks = WczytajDane();
            double x0 = 1;
            #region inicjalizacja
            //double y0 = 1, y1 = 3, y2 = 4, y3 = 2;
            //ygreks.Add(y0);
            //ygreks.Add(y1);
            //ygreks.Add(y2);
            //ygreks.Add(y3); 
            #endregion

            Wielomian wielomian = new Wielomian(x0.ToString(), ygreks.Count);
            Console.WriteLine(wielomian);

            Rownanie[] ukladRownan = UtworzUkladRownan(ygreks, wielomian);
            Dictionary<string, double> tabAn = RozwiazUkladRownan(ukladRownan);

            Console.WriteLine("Wielomian w postaci ogolnej");
            wielomian.PodstawAn(tabAn);
            wielomian.PostacOgolna();
            Console.WriteLine(wielomian);

            Console.WriteLine(wielomian.Calka("a", "b"));

            Console.ReadLine();
        }

        public static List<double> WczytajDane()
        {
            Console.WriteLine("Podaj y'greki oddzielone spacjami");
            return Console.ReadLine().Split(' ').Select(Double.Parse).ToList();
        }

        public static Dictionary<string, double> RozwiazUkladRownan(Rownanie[] ukladRownan)
        {
            Dictionary<string, double> tabAn = new Dictionary<string, double>();

            foreach (Rownanie rownanie in ukladRownan.Reverse())
            {
                rownanie.lewaStrona.PodstawAn(tabAn);
                rownanie.lewaStrona.WyliczGdzieSieDa();
                var obliczenia = rownanie.Wylicz(); //an
                tabAn.Add(obliczenia.Key, obliczenia.Value);
            }

            return tabAn;
        }

        private static Rownanie[] UtworzUkladRownan(List<double> ygreks, Wielomian wielomian)
        {
            Rownanie[] ukladRownan = new Rownanie[ygreks.Count];
            for (int i = 0; i < ygreks.Count; i++)
            {
                var _wielomian = wielomian;
                for (int j = 0; j < i; j++)
                {
                    _wielomian = Pochodna.Wielomianu(_wielomian);
                }
                ukladRownan[i] = new Rownanie { lewaStrona = _wielomian, prawaStrona = ygreks[i] };
            }
            return ukladRownan;
        }
    }
}
