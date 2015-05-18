module Random
  export random_bool

  # Not entirely happy with this...
  random_bool(rng::AbstractRNG) = rand(rng) <= 0.5

end
