type Interpreter

end

# No termination limit for now.
execute(i::Interpreter, s::State) = while !isempty(s.exec)

  # QUOTE MODE.

  execute(i, s, pop!(s.exec))
end

# Not too happy about this...
execute(i::Interpreter, s::State, v::Vector{Any}) = while !isempty(v)
  push!(s.exec, pop!(v))
end

execute(i::Interpreter, s::State, v::Boolean) =
  push!(s.boolean, v)

execute(i::Interpreter, s::State, v::Int32) =
  push!(s.integer, v)

# Names?
function execute(i::Interpreter, s::State, v::Symbol)

  # Has this name been defined?
  # Check if this name refers to a "built-in" instruction.
  #c.instructions = 

  # Check if the name refers to a stored macro.
  #c.macros

  # If neither of the above, treat the symbol as a literal name
  # and add it to the NAME stack.
  push!(s.name, v)

end