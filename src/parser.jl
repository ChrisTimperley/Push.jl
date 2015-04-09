module Parser
  export to_push

  # Produces a readily executable Push program from a given definition.
  to_push(s::String) = parse(lex(s))

  # Lex source code into a sequence of tokens.
  lex(s::String) = String[ss for ss in matchall(r"\(|\)|[^\(\)\s]+", s)]

  # Parse tokens into a Push program.
  function parse(tokens::Vector{String})
    prog = Any[]
    prog_stack = Vector{Any}[]

    while !isempty(tokens)
      t = shift!(tokens)
      if t == "("
        p2 = Any[]
        push!(prog, p2)
        push!(prog_stack, prog)
        prog = p2
      elseif t == ")"
        prog = pop!(prog_stack)
      elseif ismatch(r"^\-?\d+\.\d+$", t)
        push!(prog, convert(Float32, float(t)))
      elseif ismatch(r"^\-?\d+$", t)
        push!(prog, convert(Int32, int(t)))
      elseif t == "FALSE"
        push!(prog, false)
      elseif t == "TRUE"
        push!(prog, true)
      elseif ismatch(r"^\w\S*$", t)
        push!(prog, convert(Symbol, uppercase(t)))
      else
        error("PARSING ERROR - Unrecognised token: $(t).")
      end
    end

    if !isempty(prog_stack)
      error("PARSING ERROR - Unclosed parenthesis.")
    end
    if length(prog) != 1
      error("PARSING ERROR - Missing top-level parenthesis.")
    end

    return prog[1]
  end

end