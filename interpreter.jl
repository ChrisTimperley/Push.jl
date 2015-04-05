type Interpreter

end

# No termination limit for now.
execute(i::Interpreter, c::Push3Context) = while !isempty(c.exec)

  # QUOTE MODE.

  execute(i, c, pop!(c.exec))
end

# Not too happy about this...
execute(i::Interpreter, c::Push3Context, v::Vector{Any}) = while !isempty(v)
  push!(c.exec, pop!(v))
end

execute(i::Interpreter, c::Push3Context, v::Boolean) =
  push!(c.boolean, v)

execute(i::Interpreter, c::Push3Context, v::Int32) =
  push!(c.integer, v)

# Names?
function execute(i::Interpreter, c::Push3Context, v::Symbol)

  # Has this name been defined?
  # Check if this name refers to a "built-in" instruction.
  #c.instructions = 

  # Check if the name refers to a stored macro.
  #c.macros

  # If neither of the above, treat the symbol as a literal name
  # and add it to the NAME stack.
  push!(ex.name, v)

end