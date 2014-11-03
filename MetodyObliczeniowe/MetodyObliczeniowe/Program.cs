using System;
using System.CodeDom.Compiler;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Linq.Expressions;
using System.Security.Cryptography.X509Certificates;
using System.Text;
using System.Threading.Tasks;

namespace MetodyObliczeniowe
{
	public class Program
	{

		#region Public Method

		public static void Main(string[] args)
		{
			double a, b, x0;
			a = b = x0 = 0;
			List<double> ygreks = WczytajY();

			WczytajLiczby(ref a, ref b, ref x0);

			Console.WriteLine();
			Wielomian wielomian = new Wielomian(x0.ToString(), ygreks.Count);
			Console.WriteLine("Wielomian P({0})", x0);
			Console.WriteLine(wielomian);
			Console.WriteLine();
			Rownanie[] ukladRownan = UtworzUkladRownan(ygreks, wielomian);
			Dictionary<string, double> tabAn = RozwiazUkladRownan(ukladRownan);

			Console.WriteLine("Wielomian w postaci ogolnej");
			wielomian.PodstawAn(tabAn);
			wielomian.PostacOgolna();
			Console.WriteLine(wielomian);
			Console.WriteLine();

			Console.WriteLine("Wartość całki oznaczonej P({0}) == {1}", x0, wielomian.PoliczCalke(a, b));
			Console.ReadLine();
		}

		#endregion

		#region Private method

		private static void WczytajLiczby(ref double a, ref double b, ref double x0)
		{
			Console.Write("Podaj x0: ");
			Double.TryParse(Console.ReadLine(), out x0);
			Console.WriteLine();

			Console.Write("Podaj a ");
			Double.TryParse(Console.ReadLine(), out a);
			Console.WriteLine();

			Console.Write("Podaj b ");
			Double.TryParse(Console.ReadLine(), out b);
			Console.WriteLine();
		}

		private static List<double> WczytajY()
		{
			Console.WriteLine("Podaj y'greki oddzielone spacjami");
			try
			{
				return Console.ReadLine().Split(' ').Select(Double.Parse).ToList();
			}
			catch (FormatException ex)
			{
				Console.WriteLine("Podane dane sa w złym formacie!");
				Console.ReadLine();
				System.Environment.Exit(1);
				return new List<double>();
			}
		}

		private static Dictionary<string, double> RozwiazUkladRownan(Rownanie[] ukladRownan)
		{
			Dictionary<string, double> tabAn = new Dictionary<string, double>();

			foreach (Rownanie rownanie in ukladRownan.Reverse())
			{
				rownanie.LewaStrona.PodstawAn(tabAn);
				rownanie.LewaStrona.WyliczGdzieSieDa();
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
				ukladRownan[i] = new Rownanie { LewaStrona = _wielomian, PrawaStrona = ygreks[i] };
			}
			return ukladRownan;
		}

		#endregion
	}
}
