using System;
using System.Collections.Generic;

namespace Zadanie2
{
    /// <summary>
    /// Klasa opisująca równanie 
    /// </summary>
    public class Calculation
    {
        private double _epsilon;
        private const char Kontynuacja = 'T';

        public Calculation(double epsilon)
        {
            _epsilon = epsilon;
        }

        private double CalculateFx(double a)
        {
            return Math.Pow(a, 5) + Math.Pow(a, 1) - 5;
            //return Math.Pow(a, 3) - Math.Pow(a, 1) + 1;
            //return Math.Pow(a, 3) - Math.Pow(a, 2) + 2 * a - 1;
            //return a * a * a * (a + Math.Sin(a * a - 1) - 1) - 1; // wyniki są na przedziale [-1,0] i [1,2]
        }

        /// <summary>
        /// Metoda bisekcji
        /// </summary>
        /// <returns></returns>
        internal KeyValuePair<int, double?> Bisection(double a, double b, int userCounter)
        {
            var fa = CalculateFx(a);
            var fb = CalculateFx(b);
            int counter = 0;

            if (fa * fb > 0)
            {
                return new KeyValuePair<int, double?>(userCounter, null);
            }

            while (counter < userCounter)
            {
                counter += 1;
                var c = (a + b) / 2;
                var fc = CalculateFx(c);
                if (Math.Abs(fc) < _epsilon)
                {
                    return new KeyValuePair<int, double?>(counter, c);
                }

                if (fa * fc < 0)
                {
                    b = c;
                }
                else
                {
                    a = c;
                    fa = fc;
                }

                if (counter == userCounter)
                {
                    if (!ExecuteNextsSteps(counter))
                    {
                        return new KeyValuePair<int, double?>(counter, null);
                    }

                    userCounter += GetNextStepsCount();
                }
            }

            return new KeyValuePair<int, double?>(userCounter, null);
        }

        /// <summary>
        /// Metoda sprawdzająca czy kontynuować obliczenia po wykonaniu n kroków
        /// </summary>
        /// <returns>zwraca true jeżeli użytkownik chce kontunuacji, false jeżeli użytkownik nie chce kontynuowac obliczeń</returns>
        private bool ExecuteNextsSteps(int counter)
        {
            return ReadData.ReadChar(counter) == Kontynuacja;
        }

        /// <summary>
        /// Pobiera ilość kolejnych kroków od użytkownika
        /// </summary>
        /// <returns></returns>
        private int GetNextStepsCount()
        {
            var count = ReadData.ReadParameter();
            return count.HasValue ? count.Value : 0;
        }

        ///// <summary>
        ///// Metoda siecznych
        ///// </summary>
        ///// <returns>Zwraca null jeżeli nie znaleziono rozwiązania, gdy znajdzie rozwiązanie zwróci punkt</returns>
        internal KeyValuePair<int, double?> SecantMethods(double a, double b, int userCounter)
        {
            var fa = CalculateFx(a);
            var fb = CalculateFx(b);
            int counter = 0;
            double c = 0;

            while (counter < userCounter && Math.Abs(a - b) > _epsilon)
            {
                counter++;

                if (Math.Abs(fa - fb) < _epsilon)
                {
                    Console.WriteLine("! Złe punkty startowe !");
                    return new KeyValuePair<int, double?>(userCounter, null);
                }

                c = a - fa * ((a - b) / (fa - fb));
                var fc = CalculateFx(c);

                if (Math.Abs(fc) < _epsilon)
                {
                    return new KeyValuePair<int, double?>(counter, c);
                }

                b = a;
                fb = fa;
                a = c;
                fa = fc;

                if (counter == userCounter)
                {
                    if (!ExecuteNextsSteps(counter))
                    {
                        return new KeyValuePair<int, double?>(userCounter, null);
                    }

                    userCounter += GetNextStepsCount();
                }
            }

            return new KeyValuePair<int, double?>(counter, c); //!
        }
    }
}
