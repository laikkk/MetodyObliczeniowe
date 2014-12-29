require 'terminal-table'

begin
  print "Podaj n: "
  n = gets.chomp
end while (!(/^[1-9]\d*$/ =~ n))
n = n.to_i

begin
  print "Podaj a: "
  a = gets.chomp
end while (!(/^(0\.\d+)|([1-9]\.\d+)|([1-9]\d*)$/ =~ a))
a = a.to_f

euler = []
midpoint = []
result = []
euler[0] = midpoint[0] = result[0] = 1.0
x = []
x[0] = 0
h = a/n
def f(x, y)
  return y*(y-1)+x**2*(3-x-x**4)
  #return 2*x
  #return -(y**2)
end

def f1(x, y)
  #return 1/(1+x)
  return x**3+1
end

for i in (1...n+1) do
  x[i] = (x[i-1]+h).round(14)
end

for i in (1...n+1) do
  euler[i]=euler[i-1]+h*f(x[i-1],euler[i-1])
  #puts "#{euler[i-1]} + #{h} * #{f(x[i-1],euler[i-1])}"
  #puts '-------------------------'
end

#puts '-------------------------'

for i in (1...n+1) do
  midpoint[i]=midpoint[i-1]+h*f(x[i-1]+h/2,midpoint[i-1]+(h/2)*f(x[i-1],midpoint[i-1]))
  #puts "#{midpoint[i-1]} + #{h} * #{f(x[i-1],midpoint[i-1])}"
  #puts '-------------------------'
end

for i in (1...n+1) do
  result[i]=f1(x[i],0)
end

rows = []
for i in 0...n+1
  rows << [x[i], euler[i], midpoint[i], result[i]]
end

table = Terminal::Table.new :headings => ['xk', 'metoda Eulera', 'metoda punktu środkowego', 'dokładne rozwiązanie'], :rows => rows
puts table