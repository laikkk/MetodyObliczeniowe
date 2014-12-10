using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Zadanie2
{
	class Program
	{
		static void Main(string[] args)
		{
			ReadData dataReader = new ReadData();
			if (dataReader.ReadParameters())
			{
				Calculation calculation = new Calculation(dataReader.Epsilon);
				var resultBisection = calculation.Bisection(dataReader.A, dataReader.B, dataReader.UserCounter);

				Console.WriteLine();
				if (resultBisection.Value.HasValue)
					Console.WriteLine("Wynik bisekcji to: {0} w krokach {1}", resultBisection.Value.Value, resultBisection.Key);
				else
					Console.WriteLine("Nie znaleziono rozwiązania metodą bisekcji w {0} krokach", resultBisection.Key);

				var resultSecantMethods = calculation.SecantMethods(dataReader.A, dataReader.B, dataReader.UserCounter);

				Console.WriteLine();
				if (resultSecantMethods.Value.HasValue)
					Console.WriteLine("Wynik metody siecznych to: {0} w krokach {1}", resultSecantMethods.Value.Value, resultSecantMethods.Key);
				else
					Console.WriteLine("Nie znaleziono rozwiązania metodą siecznych w {0} krokach", resultSecantMethods.Key);
			}

			Console.ReadLine();
		}
	}
}
