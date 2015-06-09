random_bool(s::State) =
  randbool()

random_integer(s::State) =
  rand(s.parameters.min_random_integer:s.parameters.max_random_integer)

random_float(s::State) =
  rand(s.parameters.min_random_float:eps(Float32):s.parameters.max_random_float)

random_name(s::State) =
  random_name(s, s.parameters.new_erc_name_probability, s.parameters.min_random_name_length, s.parameters.max_random_name_length)
random_name(s::State, p_new::FloatingPoint, minl::Integer, maxl::Integer) =  
  rand() <= p_new ? randstring(rand(minl:maxl)) : random_bound_name(s)
random_name(s::State, ins::Vector{Symbol}) =
  ins[rand(1:end)]
random_bound_name(s::State) =
  random_name(s, list_instructions(s))

function random_erc(s::State)
  choice = rand()
  choice <= 0.25  && return random_bool(s)
  choice <= 0.5   && return random_integer(s)
  choice <= 0.75  && return random_float(s)
  return random_name(s)
end

# UNDER CONSTRUCTION.
random_code(s::State) =
  random_code(s, s.parameters.max_points)
random_code(s::State, mx::Integer) =
  random_code_with_size(1:mx)


function random_code_with_size(s::State, ln::Integer)
  ln == 1 && return something ? random_erc(s) : random_instruction(s)
end

function decompose(s::State, ln::Integer, mx::Integer)
  (ln == 1 || mx == 1) && return [ln]
end
