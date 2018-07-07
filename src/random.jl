random_bool(s::State) =
  rand(Bool)

random_integer(s::State) =
  rand(s.parameters.min_random_integer:s.parameters.max_random_integer)

random_float(s::State) =
  rand(s.parameters.min_random_float:eps(Float32):s.parameters.max_random_float)

random_name(s::State) =
  random_name(s, s.parameters.new_erc_name_probability, s.parameters.min_random_name_length, s.parameters.max_random_name_length)
random_name(s::State, p_new::AbstractFloat, minl::Integer, maxl::Integer) =
  rand() <= p_new ? randstring(rand(minl:maxl)) : random_bound_name(s)
random_name(s::State, ins::Vector{Symbol}) =
  ins[rand(1:end)]
random_bound_name(s::State) =
  random_name(s, list_instructions(s))

# Generates a random atom for `random_code`.
# If the atom is an ERC instruction, then a new ERC is generated and returned
# instead.
function random_atom(s::State)
  atom = random_bound_name(s)
  atom == symbol("FLOAT.ERC") && return random_float(s)
  atom == symbol("INTEGER.ERC") && return random_integer(s)
  atom == symbol("BOOLEAN.ERC") && return random_bool(s)
  atom == symbol("NAME.ERC") && return random_name(s)
  return atom
end

# Very inefficient.
# Should implement an iterative version without overheads and type issues.
random_code(s::State) =
  random_code(s, s.parameters.max_points_in_random_expressions)
random_code(s::State, mx::Integer) =
  random_code_with_size(s, rand(1:mx), mx)
random_code_with_size(s::State, ln::Integer, mx::Integer) =
  ln == 1 ? random_atom(s) : [random_code_with_size(s, i, mx) for i in decompose(ln, mx)]

function decompose(i::Integer, mx::Integer)
  (i == 1 || mx == 1) && return [1]
  this_part = rand(1:i - 1)
  push!(decompose(i - this_part, mx - 1), this_part)
end
