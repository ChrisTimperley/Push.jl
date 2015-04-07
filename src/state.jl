type State
  parameters::Parameters
  float::Vector{Float32}
  integer::Vector{Int32}
  boolean::Vector{Bool}
  code::Vector{Any}
  exec::Vector{Any}
  instructions::Dict{Symbol, Function}
  
  State() = new()
  State(f::Vector{Float32}, i::Vector{Int32}, b::Vector{Int32},
    c::Vector{Any}, e::Vector{Any}, ins::Dict{Symbol, Function}) =
    new(f, i, b, c, e, ins)
end

# Enables a registered Push instruction, specified by its name,
# by inserting it into the instruction table of a given state.
enable_instruction!(s::State, i::Symbol) = s[i] = fetch_instruction(i)