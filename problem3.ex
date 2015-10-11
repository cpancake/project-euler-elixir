defmodule Problem3 do
	def solve(num, divisor, factors) when num <= 1 do
		List.first(factors)
	end

	def solve(num, divisor, factors) when num > 1 and rem(num, divisor) == 0 do
		solve(div(num, divisor), divisor, [divisor|factors])
	end

	def solve(num, divisor, factors) when num > 1 do
		solve(num, divisor + 1, factors)
	end

	def solve(num) do
		solve(num, 2, [])
	end
end
# 600851475143
# 
IO.inspect Problem3.solve(600851475143)