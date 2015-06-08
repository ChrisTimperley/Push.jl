module Random
  export random_bool, random_integer, random_float

  random_bool(s::State) = randbool()
  random_integer(s::State) = rand(s.parameters.min_random_integer:s.parameters.max_random_integer)
  random_float(s::State) = rand(s.parameters.min_random_float:eps(Float32):s.parameters.max_random_float)
end
