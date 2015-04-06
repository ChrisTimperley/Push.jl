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

execute(i::Interpreter, s::State, v::Bool) =
  push!(s.boolean, v)

execute(i::Interpreter, s::State, v::Int32) =
  push!(s.integer, v)

function execute(i::Interpreter, s::State, v::Symbol)
  # Check if this name refers to a "built-in" instruction.
  if haskey(s.instructions, v)
    s.instructions[v](s)

  # Check if the name refers to a stored macro.
  #c.macros
  #elseif haskey(s.macros, v)
  #  s.macros[v](s)

  # If neither of the above, treat the symbol as a literal name
  # and add it to the NAME stack.
  else
    push!(s.name, v)
  end
end