class Solution

  def initialize
    @mutex = Mutex.new
    @resource = ConditionVariable.new
  end

  def execute
    t2 = Thread.new do
      i = 2
        @mutex.synchronize do

          t1 = Thread.new do
            j = 1
              @mutex.synchronize do
                while j < 100
                  puts "Thread 1: The number is #{j}"
                  @resource.signal
                  @resource.wait(@mutex)
                  j += 2
                end
              end
          end

          while i <= 100
            @resource.wait(@mutex)
            puts "Thread 2: The number is #{i}"
            @resource.signal
            i += 2
          end
        end
    end

    t2.join
  end
end

solution = Solution.new
solution.execute
