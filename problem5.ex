defmodule Problem5 do
	def solve(num, current_divisor) when current_divisor <= 20 and (rem(num, current_divisor) == 0) do
		solve(num, current_divisor + 1)
	end

	def solve(num, current_divisor) when current_divisor <= 20 do
		solve(num + 20, 1)
	end

	def solve(num, current_divisor) when current_divisor > 20 do
		num
	end

	def solve() do
		solve(20, 1)
	end
end

IO.puts Problem5.solve()