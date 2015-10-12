# How it works:
# First, the is_prime function. That uses the AKS primality test. Science or something.
# Anyways, the first step is to get an estimate. This is done by a simple n log2 n estimation.
# Then a simple search is done downwards to find the closest prime <= that estimate.
# Then a count is done of all the primes below that estimate. This is split up using Elixir's tasks.
# Each task gets a range of 1000 numbers, and it sends back the number of primes in that range.
# Once all the tasks are done, the count of primes below that estimate is compared with the intended count.
# If the intended count is greater than the estimated count, a search is done upwards for the result.
# Otherwise, the search is done downwards.
# This is the most efficient way I could come up with.

defmodule Problem7 do
	def is_prime(n, i, c, max) when c != 1 and c != n and rem(c, n) != 0 and i < max do
		false
	end

	def is_prime(n, i, c, max) when i <= max do
		new_c = div(c * (n - i), i + 1)
		is_prime(n, i + 1, new_c, max)
	end

	def is_prime(n, i, c, max) when i > max do
		true
	end

	def is_prime(n) when n == 2 do
		true
	end

	def is_prime(n) when rem(n, 2) == 0 do
		false
	end

	def is_prime(n) when n == 1 do
		false
	end

	def is_prime(n) do
		is_prime(n, 0, 1, div(n, 2) + 1)
	end

	def count_primes(parent, num, range_end, accum) when num >= range_end do
		send(parent, {:finish, accum})
	end

	def count_primes(parent, num, range_end, accum) when num < range_end do
		if is_prime(num) do
			count_primes(parent, num + 1, range_end, accum + 1)
		else
			count_primes(parent, num + 1, range_end, accum)
		end
	end

	def count_primes(parent, num, range_end) do 
		count_primes(parent, num, range_end, 0)
	end

	def wait_tasks(num_tasks, num_recv, accum) when num_tasks <= num_recv do
		accum
	end

	def wait_tasks(num_tasks, num_recv, accum) when num_tasks > num_recv do
		receive do
			{:finish, num} -> wait_tasks(num_tasks, num_recv + 1, accum + num)
		end
	end

	def spawn_tasks(est, range, n) when n < range do
		s = self()
		if (n * 1000) + 1000 < est do
			Task.start_link fn -> count_primes(s, n * 1000, (n * 1000) + 1000) end
		else
			Task.start_link fn -> count_primes(s, n * 1000, est) end
		end
		spawn_tasks(est, range, n + 1)
	end

	def spawn_tasks(est, range, n) do
		wait_tasks(n, 0, 0)
	end

	def count_below_estimate(est) do
		range = trunc(Float.ceil(est / 1000))
		spawn_tasks(est, range, 0)
	end

	def estimate_prime(n) do
		n * Float.floor(:math.log(n) / :math.log(2))
	end

	# go up
	def find_from_point(point, n, dest) when dest > n do
		if is_prime(point) do
			if n + 1 == dest do
				find_from_point(point, n + 1, dest)
			else
				find_from_point(point + 1, n + 1, dest)
			end
		else
			find_from_point(point + 1, n, dest)
		end
	end

	# go down
	def find_from_point(point, n, dest) when dest < n do
		if is_prime(point) do
			if n - 1 == dest do
				find_from_point(point, n - 1, dest)
			else
				find_from_point(point - 1, n - 1, dest)
			end
		else
			find_from_point(point - 1, n, dest)
		end
	end

	# we're here
	def find_from_point(point, n, dest) when dest == n do
		point
	end

	def find_lower_prime(n) do
		if is_prime(n) do
			n
		else
			find_lower_prime(n - 1)
		end
	end

	def find_nth_prime(n) do
		est = find_lower_prime(trunc(estimate_prime(n)))
		IO.puts("est: " <> Integer.to_string(est))
		count = count_below_estimate(est)
		IO.puts("below est: " <> Integer.to_string(count))
		find_from_point(est - 1, count, n - 1)
	end
end

IO.puts Problem7.find_nth_prime(10001)