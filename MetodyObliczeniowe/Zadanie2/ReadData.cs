using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;

namespace Zadanie2
{
	/// <summary>
	/// Klasa pobierająca dane od użytkownika
	/// </summary>
	public class ReadData
	{
		#region Field

		private double _a;
		private double _b;
		private double _epsilon;
		private int _userCounter;
		private const int ReadSteps = 10;

		#endregion

		#region Properites

		/// <summary>
		/// Wartość epsilon
		/// </summary>
		public double Epsilon
		{
			get { return _epsilon; }
		}

		/// <summary>
		/// Wartość parametru a
		/// </summary>
		public double A
		{
			get { return _a; }
		}

		/// <summary>
		/// Wartość parametru b
		/// </summary>
		public double B
		{
			get { return _b; }
		}

		/// <summary>
		/// Ilość kroków do wykonania
		/// </summary>
		public int UserCounter
		{
			get { return _userCounter; }
		}

		public int DecimalNumbers
		{
			get
			{
				double pom = _epsilon;
				int i = 0;
				while (pom < 1)
				{
					pom = pom * 10;
					i++;
				}
				return i;
			}
		}

		#endregion

		#region Method

		/// <summary>
		/// Funkcja wczytująca parametry
		/// </summary>
		/// <returns>Zwraca wartość true lub false w zależności czy dane zostały wczytane poprawnie</returns>
		public bool ReadParameters()
		{
			bool isValid = false;
			int counter = 0;
			while (!isValid && counter < ReadSteps)
			{
				Console.Write("Podaj epsilon: ");

				if (Double.TryParse(Console.ReadLine(), out _epsilon))
				{
					if (_epsilon > Double.Epsilon && _epsilon < 1.0)
						isValid = true;
					else
						Console.WriteLine("Epsilon musi być większy od 0 i mniejszy od 1");
				}
				else
					Console.WriteLine("Niepoprawny format epsilon.");
				counter++;
			}

			if (counter == ReadSteps && !isValid)
				Console.WriteLine("{0} razy wprowadzono złe wartość epsilon!\n\nNastępuje koniec działa programu!!", counter);

			if (isValid)
			{
				isValid = false;
				counter = 0;

				while (!isValid && counter < ReadSteps)
				{
					isValid = ReadEndPoints();
					counter++;
				}

				if (counter == ReadSteps && !isValid)
					Console.WriteLine("{0} razy wprowadzono złe wartość punktów końcowych a i b!\n\nNastępuje koniec działa programu!!", counter);
			}

			if (isValid)
			{
				isValid = false;
				counter = 0;
				while (!isValid && counter < ReadSteps)
				{
					Console.Write("Podaj ilość kroków które wykonać: ");
					if (Int32.TryParse(Console.ReadLine(), out _userCounter))
					{
						if (_userCounter > 0)
							isValid = true;
						else
							Console.WriteLine("Ilość kroków nie może być mniejsza od 0");
					}
					else
					{
						Console.WriteLine("Podano nieprawdidłową wartość parametru kroków");
					}
					counter++;
				}
				if (counter == ReadSteps && !isValid)
					Console.WriteLine("{0} wprowadzono niepoprawną ilość kroków!\n\nNastępuje koniec działa programu!!", counter);
			}

			return isValid;
		}

		private bool ReadEndPoints()
		{
			Console.Write("Podaj a: ");
			if (!Double.TryParse(Console.ReadLine(), out _a))
			{
				Console.WriteLine("Podano nieprawdidłową wartość parametru a.");
				return false;
			}

			Console.Write("Podaj b: ");
			if (!Double.TryParse(Console.ReadLine(), out _b))
			{
				Console.WriteLine("Podano nieprawdidłową wartość parametru b.");
				return false;
			}

			var fa = Calculation.CalculateFx(_a);
			var fb = Calculation.CalculateFx(_b);
			if (fa * fb > 0)
			{
				Console.WriteLine("Warości funkcji w punktach a i b musi być przeciwnych znaków! Podaj nowe punkty!");
				return false;
			}

			return true;
		}

		#endregion

		#region static method

		public static int? ReadParameter()
		{
			int userCounter;
			Console.Write("Podaj ilość kroków które wykonać: ");

			if (!Int32.TryParse(Console.ReadLine(), out userCounter))
			{
				Console.WriteLine("Podano nieprawdidłową wartość parametru kroków");
				return null;
			}

			if (userCounter <= 0)
			{
				Console.WriteLine("Ilość kroków nie może być mniejsza od 0");
				return null;
			}

			return userCounter;
		}

		public static char ReadChar(int userCounter)
		{
			Console.Write("Wykonałem już {0}, kroków czy chesz kontynuować? T-tak, n-nie: ", userCounter);
			var key = Console.ReadKey().KeyChar;
			Console.WriteLine();
			return key;
		}

		#endregion
	}
}
