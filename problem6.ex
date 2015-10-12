defmodule Problem6 do
	def sum_squares(num, accum) when num <= 100 do
		sum_squares(num + 1, accum + (num * num))
	end

	def sum_squares(num, accum) when num > 100 do
		accum
	end

	def sum(num, accum) when num <= 100 do
		sum(num + 1, accum + num)
	end

	def sum(num, accum) when num > 100 do
		accum
	end

	def square_sum() do
		result = sum(1, 0)
		result * result
	end

	def solve() do
		square_sum() - sum_squares(1, 0)
	end
end

IO.puts Problem6.solve()