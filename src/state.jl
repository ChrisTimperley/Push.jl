type State
  parameters::Parameters
  float::Vector{Float32}
  integer::Vector{Int32}
  boolean::Vector{Bool}
  name::Vector{Symbol}
  code::Vector{Any}
  exec::Vector{Any}
  instructions::Dict{Symbol, Function}
  flag_quote_name::Bool
  flag_quote_code::Bool
  
  State() = new(Parameters(), Float32[], Int32[], Bool[],
    Any[], Any[], Any[], Dict{Symbol, Function}(), false, false)
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
enable_instruction!(s::State, i::String) = enable_instruction!(s, convert(Symbol, i))
enable_instruction!(s::State, i::Symbol) = s.instructions[i] = fetch_instruction(i)