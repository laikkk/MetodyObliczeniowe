require 'terminal-table'

class Euler

  attr_accessor :n
  attr_accessor :a
  attr_accessor :h

  def initialize
    @start_point = 1.0
    @x = Array.new
    @euler = Array.new
    @midpoint = Array.new
    @accurate = Array.new
    @error_euler = Array.new
    @error_midpoint = Array.new
  end

  def get_n
    checker = 0
    begin
      if (checker != 0) 
        puts "Wpowadzono niepoprawną wartość n. Spróbuj ponownie."
      end
      print "Podaj n: "
      @n = gets.chomp
      checker += 1
    end while (!(/^[1-9]\d*$/ =~ @n))
    @n = @n.to_i
  end

  def get_a
    checker = 0
    begin
      if (checker != 0) 
        puts "Wpowadzono niepoprawną wartość a. Spróbuj ponownie."
      end
      print "Podaj a: "
      @a = gets.chomp
      checker += 1
    end while (!(/^(0\.[1-9]+)|(0\.0\d+)|([1-9]\.\d+)|([1-9]\d*)$/ =~ @a))
    @a = a.to_f
  end

  def f(x, y)
    return y*(y-1)+x**2*(3-x-x**4)
  end

  def f1(x, y)
    return x**3+1
  end

  def calculate_xk
    @x[0] = 0
    @h = @a/@n
    for i in (1...n+1) do
      @x[i] = (@x[i-1]+h).round(14)
    end
  end

  def calculate_euler
    @euler[0] = @start_point
    for i in (1...@n+1) do
      @euler[i]=@euler[i-1] + @h * f(@x[i-1], @euler[i-1])
    end
  end

  def calculate_midpoint
    @midpoint[0] = @start_point
    for i in (1...@n+1) do
      @midpoint[i] = @midpoint[i-1] + @h * f(@x[i-1] + @h/2, @midpoint[i-1] + (@h/2) * f(@x[i-1], @midpoint[i-1]))
    end
  end

  def calculate_accurate
    @accurate[0] = @start_point
    for i in (1...@n+1) do
      @accurate[i] = f1(@x[i],0)
    end
  end

  def calculate_error
    for i in (0...@n+1) do
      @error_euler[i] = (@accurate[i] - @euler[i]).abs
      @error_midpoint[i] = (@accurate[i] - @midpoint[i]).abs
    end
    puts "Maksymalny błąd metody Eulera: #{@error_euler.max}\nMaksymalny błąd metody punktu środkowego: #{@error_midpoint.max}"
  end

  def make_table
    rows = []
    for i in 0...@n+1
      rows << [@x[i], @euler[i], @error_euler[i], @midpoint[i], @error_midpoint[i], @accurate[i]]
    end
    table = Terminal::Table.new :headings => ['xk', 'metoda Eulera', 'błąd', 'metoda punktu środkowego', 'błąd', 'dokładne rozwiązanie'], :rows => rows
    puts table
  end
end

klasa = Euler.new
klasa.get_n
klasa.get_a
klasa.calculate_xk
klasa.calculate_euler
klasa.calculate_midpoint
klasa.calculate_accurate
klasa.calculate_error
klasa.make_table
