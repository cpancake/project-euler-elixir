defmodule Problem1 do
	def solve(num, accum) when num >= 1000 do
		accum
	end

	def solve(num, accum) when num < 1000 and (rem(num, 3) == 0 or rem(num, 5) == 0) do
		solve(num + 1, accum + num)
	end

	def solve(num, accum) when num < 1000 do
		solve(num + 1, accum)
	end

	def solve() do
		solve(0, 0)
	end
end

IO.puts Problem1.solve()