require 'terminal-table'

class Differential

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
    print_message = false
    begin
      if (print_message == true)
        puts "Wpowadzono niepoprawną wartość n. Spróbuj ponownie."
      end
      print "Podaj n: "
      @n = gets.chomp
      print_message = true
    end while (!(/^[1-9]\d*$/ =~ @n))
    @n = @n.to_i
  end

  def get_a
    print_message = false
    begin
      if (print_message == true)
        puts "Wpowadzono niepoprawną wartość a. Spróbuj ponownie."
      end
      print "Podaj a: "
      @a = gets.chomp
      print_message = true
    end while (@a.to_f <= 0 || (/^[0-9]*(\.\d*)?$/ =~ @a) == nil)
    @a = @a.to_f
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
    i = 0
    if n <= 10
      x = 1
    else
      x = @n/10
    end
    while (i <= @n+1)
      if (i % x == 0)
        rows << [@x[i], @euler[i], @midpoint[i], @accurate[i]]
      end
      if (x == 0)
        x += 1
      else
        i += x
      end
    end
    table = Terminal::Table.new :headings => ['xk', 'metoda Eulera', 'metoda punktu środkowego', 'dokładne rozwiązanie'], :rows => rows
    puts table
  end
end

differential = Differential.new
differential.get_n
differential.get_a
differential.calculate_xk
differential.calculate_euler
differential.calculate_midpoint
differential.calculate_accurate
differential.make_table
differential.calculate_error