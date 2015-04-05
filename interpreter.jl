type Interpreter

end

# Really we want a context...

function execute(i::Interpreter, p::PushProgram)
  push!(i.exec, p)

  # Keep processing the EXEC stack until all programs have been executed.
  while !isempty(i.exec)
    p = pop!(i.exec)

    # NOT JULIA-ESQUE
    if isa(p, PushInstruction)
      execute(i, p)

    # Literals are executed by being pushed onto their appropriate stack.
    elseif isa(p, PushLiteral)
      push!(i.T, p)

    # The program must be a list, in which case we should push all of its
    # programs onto the EXEC stack in reverse order (so that they are processed
    # in their original order).
    else
      for it in size(p):-1:1
        push!(i.exec, it)
      end
    end
  end
end

# Push literal's onto their appropriate stack.
execute(::Interpreter, l::PushLiteral)

# If the given expression is a single instruction, then execute it.
execute(::Interpreter, ::PushInstruction) = return

# Sequentially execute each program within a given list.
execute(::Interpreter, lst::Vector{Any}) = for l in lst
  execute(l)
end


type Lexer

end