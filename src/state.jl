type State
  parameters::Parameters
  float::Vector{Float32}
  integer::Vector{Int32}
  boolean::Vector{Bool}
  name::Vector{Symbol}
  code::Vector{Any}
  exec::Vector{Any}
  instructions::Dict{Symbol, Function}
  
  State() = new(Parameters(), Float32[], Int32[], Bool[],
    Any[], Any[], Any[], Dict{Symbol, Function}())
  State(f::Vector{Float32}, i::Vector{Int32}, b::Vector{Int32},
    c::Vector{Any}, e::Vector{Any}, ins::Dict{Symbol, Function}) =
    new(f, i, b, c, e, ins)
end

# Enables a registered Push instruction, specified by its name,
# by inserting it into the instruction table of a given state.
enable_instruction!(s::State, i::String) = enable_instruction!(s, convert(Symbol, i))
enable_instruction!(s::State, i::Symbol) = s.instructions[i] = fetch_instruction(i)