defmodule Problem4 do
	def max_num(num1, num2) when num1 >= num2 do
		num1
	end

	def max_num(num1, num2) when num2 > num1 do
		num2
	end

	def check_palindrome(num) do
		str = Integer.to_string(num)
		String.reverse(str) == str
	end

	def solve(num1, num2, max) when num1 > 0 do
		result = num1 * num2
		if check_palindrome(result) do
			solve(num1 - 1, num2, max_num(max, result))
		else
			solve(num1 - 1, num2, max)
		end
	end

	def solve(num1, num2, max) when num1 == 0 and num2 > 1 do
		solve(999, num2 - 1, max)
	end

	def solve(num1, num2, max) when num1 == 0 and num2 == 1 do
		max
	end

	def solve() do
		solve(999, 999, -1)
	end
end

IO.puts Problem4.solve()