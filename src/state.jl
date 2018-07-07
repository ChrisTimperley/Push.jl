mutable struct State
  rng::AbstractRNG
  parameters::Parameters
  float::Vector{Float32}
  integer::Vector{Int32}
  boolean::Vector{Bool}
  name::Vector{Symbol}
  code::Vector{Any}
  exec::Vector{Any}
  instructions::Dict{Symbol, Function}
  definitions::Dict{Symbol, Any}
  flag_quote_name::Bool
  flag_quote_code::Bool

  State() = new(MersenneTwister(0), Parameters(), Float32[], Int32[], Bool[],
    Any[], Any[], Any[], Dict{Symbol, Function}(), Dict{Symbol, Any}(), false, false)
end

function pp_stacks(s::State)
  println("FLOAT: ($(join(s.float, " ")))")
  println("INTEGER: ($(join(s.integer, " ")))")
  println("BOOLEAN: ($(join(s.boolean, " ")))")
  println("NAME: ($(join(s.name, " ")))")
  println("CODE: ($(join(s.code, " ")))")
  println("EXEC: ($(join(s.exec, " ")))")
end

# Enables a registered Push instruction, specified by its name,
# by inserting it into the instruction table of a given state.
enable_instruction!(s::State, i::String) = enable_instruction!(s, Symbol(i))
enable_instruction!(s::State, i::Symbol) = s.instructions[i] = fetch_instruction(i)

# Returns a list with all enabled instructions and definitions within
# a given state.
list_instructions(s::State) =
  vcat(collect(keys(s.instructions)), collect(keys(s.definitions)))
