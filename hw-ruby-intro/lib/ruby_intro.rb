# When done, submit this entire file to the autograder.

# Part 1

def sum arr
  if arr.length == 0
    return 0
  else
    sum = 0
    arr.each do |ele|
      sum += ele
    end
    return sum
  end
end

def max_2_sum arr
  if arr.length == 0
    return 0
  elsif arr.length == 1
    return arr[0]
  else
    arr_s = arr.sort {|x, y| y <=> x}
    return arr_s[0] + arr_s[1]
  end
end

def sum_to_n? arr, n
  if arr.length == 0 or arr.length == 1
    return false
  else
    arr_helper = arr.combination(2).to_a.select {|a| a[0] + a[1] == n}
    return arr_helper.length > 0
  end
end

# Part 2

def hello(name)
  return "Hello, #{name}"
end

def starts_with_consonant? s
  s.downcase =~ /^[a-z]/ and !(s.downcase =~ /^[aeiou]/)
end

def binary_multiple_of_4? s
  s =~ /^[01]*100$/ or s =~ /^0$/
end

# Part 3

class BookInStock
  attr_accessor :isbn
  attr_accessor :price
  def initialize(isbn, price)
    raise ArgumentError if isbn.length == 0 or price <= 0
    @isbn = isbn
    @price = price
  end
  
  def price_as_string
    '$'+'%.2f' % self.price
  end
end
