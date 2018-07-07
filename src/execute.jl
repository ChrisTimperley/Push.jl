# Top level of the Push interpreter.
run(p::String) = run(p, default_configuration)
run(p::String, cfg::String) = run(p, load_configuration(cfg))
run(p::String, cfg::Configuration) = run(Parser.to_push(p), configure(cfg))
function run(p::Any, s::State)
  s.parameters.top_level_push_code && push!(s.code, p)
  push!(s.exec, p)
  execute(s)
  s.parameters.top_level_pop_code && pop!(s.code)
  return s
end

# No termination limit for now.
execute(s::State) = while !isempty(s.exec)
  if s.flag_quote_code
    s.flag_quote_code = false
    push!(s.code, pop!(s.exec))
  else
    execute(s, pop!(s.exec))
  end
end

# Could be made faster...
execute(s::State, v::Vector) = for elem in reverse(v)
  push!(s.exec, elem)
end

execute(s::State, v::Bool) =
  push!(s.boolean, v)

execute(s::State, v::Int32) =
  push!(s.integer, v)

execute(s::State, f::Float32) =
  push!(s.float, f)

function execute(s::State, v::Symbol)
  # If name quoting is enabled, push this name onto the NAME stack and disable quoting.
  if s.flag_quote_name
    s.flag_quote_name = false
    push!(s.name, v)

  # Check if this name refers to a "built-in" instruction.
  elseif haskey(s.instructions, v)
    s.instructions[v](s)

  # Check if the name refers to a stored definition.
  elseif haskey(s.definitions, v)
    push!(s.exec, s.definitions[v])

  # If neither of the above, treat the symbol as a literal name
  # and add it to the NAME stack.
  else
    push!(s.name, v)
  end
end
