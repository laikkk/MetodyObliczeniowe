require 'terminal-table'

class Euler

  attr_accessor :n
  attr_accessor :a
  attr_accessor :x
  attr_accessor :h
  attr_accessor :euler
  attr_accessor :midpoint
  attr_accessor :accurate


  def initialize
    @x = Array.new
    @euler = Array.new
    @midpoint = Array.new
    @accurate = Array.new
  end

  def getN
    begin
      print "Podaj n: "
      @n = gets.chomp
    end while (!(/^[1-9]\d*$/ =~ @n))
    @n = @n.to_i
  end

  def getA
    begin
      print "Podaj a: "
      @a = gets.chomp
    end while (!(/^(0\.\d+)|([1-9]\.\d+)|([1-9]\d*)$/ =~ @a))
    @a = a.to_f
  end

  def f(x, y)
    return y*(y-1)+x**2*(3-x-x**4)
    #return 2*x
    #return -(y**2)
  end

  def f1(x, y)
    #return 1/(1+x)
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
    @euler[0] = 1.0
    for i in (1...@n+1) do
      @euler[i]=@euler[i-1] + @h * f(@x[i-1], @euler[i-1])
      #puts "#{euler[i-1]} + #{h} * #{f(x[i-1],euler[i-1])}"
      #puts '-------------------------'
    end
  end

#puts '-------------------------'
  def calculate_midpoint
    @midpoint[0] = 1.0
    for i in (1...@n+1) do
      @midpoint[i] = @midpoint[i-1] + @h * f(@x[i-1] + @h/2, @midpoint[i-1] + (@h/2) * f(@x[i-1], @midpoint[i-1]))
      #puts "#{midpoint[i-1]} + #{h} * #{f(x[i-1]+h/2,midpoint[i-1]+h/2)} * #{f(x[i-1],midpoint[i-1])}"
      #puts '-------------------------'
    end
  end

  def calculate_accurate
    @accurate[0] = 1.0
    for i in (1...@n+1) do
      @accurate[i] = f1(@x[i],0)
    end
  end

  def make_table
    rows = []
    for i in 0...@n+1
      rows << [@x[i], @euler[i], @midpoint[i], accurate[i]]
    end
    table = Terminal::Table.new :headings => ['xk', 'metoda Eulera', 'metoda punktu srodkowego', 'dokladne rozwiazanie'], :rows => rows
    puts table
  end
end

# klasa = Euler.new
# klasa.getN
# klasa.getA
# klasa.calculate_xk
# klasa.calculate_euler
# klasa.calculate_midpoint
# klasa.calculate_accurate
# klasa.make_table
