defmodule Problem2 do
	def solve(prev, cur, accum) when prev >= 4000000 do
		accum
	end

	def solve(prev, cur, accum) when (prev < 4000000 and rem(prev, 2) == 0) do
		solve(cur, prev + cur, accum + prev)
	end

	def solve(prev, cur, accum) when prev < 4000000 do
		solve(cur, prev + cur, accum)
	end

	def solve() do
		solve(1, 2, 0)
	end
end

IO.puts Problem2.solve()