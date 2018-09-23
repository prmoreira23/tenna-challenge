require 'set'
require 'byebug'

class Solution
  def initialize(min_number, max_number)
    @min_number = min_number
    @max_number = max_number
  end

  def hash
    @hash ||= generate_hash
  end

  def generate_hash
    @hash = {}
    (@min_number..@max_number).map { |n| @hash[n - 1] ? @hash[n] = odd_or_even(@hash[n - 1]) : @hash[n] = "odd"}
    @hash
  end

  def odd_or_even(n)
   n == "odd" ? "even" : "odd"
  end

  def multiples_of_two
    [*2.step(@max_number, 2)]
  end

  def multiples_of_three
    [*3.step(@max_number, 3)]
  end

  def multiples_of_two_and_three(a, b)
    Set.new(a).intersection(Set.new(b)).to_a
  end

  def execute
    m_of_two = multiples_of_two
    m_of_three = multiples_of_three
    m_of_two_and_three = multiples_of_two_and_three(m_of_two, m_of_three)
    m_of_three -= m_of_two_and_three

    m_of_three.each { |n|
      hash[n] = "is divisible by three"
    }

    m_of_two_and_three.each { |n|
      hash[n] = "is divisible by two and three"
    }

    (@min_number..@max_number).each do |number|
      puts "The number '#{number}' is #{hash[number]}."
    end
  end

end

solution = Solution.new(1, 100)
solution.execute
