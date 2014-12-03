using System;
using System.Collections.Generic;
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

		#endregion

		#region Method

		/// <summary>
		/// Funkcja wczytująca parametry
		/// </summary>
		/// <returns>Zwraca wartość true lub false w zależności czy dane zostały wczytane poprawnie</returns>
		public bool ReadParameters()
		{
			bool isValid = true;

			Console.Write("Podaj epsilon: ");
			if (!Double.TryParse(Console.ReadLine(), out _epsilon))
			{
				Console.WriteLine("Niepoprawny format epsilon. Musi być więszy od 0 i mniejszy od 1");
				isValid = false;
			}

			if (isValid)
				if (_epsilon < 0 || _epsilon > 1)
				{
					Console.WriteLine("Epsilon musi być większy od 0 i mniejszy od 1");
					isValid = false;
				}

			if (isValid)
			{
				Console.Write("Podaj a: ");
				if (!Double.TryParse(Console.ReadLine(), out _a))
				{
					Console.WriteLine("Podano nieprawdidłową wartość parametru a");
					isValid = false;
				}
			}

			if (isValid)
			{
				Console.Write("Podaj b: ");
				if (!Double.TryParse(Console.ReadLine(), out _b))
				{
					Console.WriteLine("Podano nieprawdidłową wartość parametru b");
					isValid = false;
				}
			}

			if (isValid)
			{
				Console.Write("Podaj ilość kroków które wykonać: ");
				if (!Int32.TryParse(Console.ReadLine(), out _userCounter))
				{
					Console.WriteLine("Podano nieprawdidłową wartość parametru kroków");
					isValid = false;
				}
				else if (_userCounter <= 0)
				{
					Console.WriteLine("Ilość kroków nie może być mniejsza od 0");
					isValid = false;
				}
			}

			return isValid;
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
