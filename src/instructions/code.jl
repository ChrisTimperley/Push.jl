CODE_EQ(s::State) = if length(s.code) > 1
  push!(s.boolean, pop!(s.code) === pop!(s.code))
end

CODE_APPEND(s::State) = if length(s.code) > 1
  first = pop!(s.code)
  second = peek(s.code)
  s.code[end] = vcat(isa(first, Vector) ? first : [first],
    isa(second, Vector) ? second : [second])
end

CODE_ATOM(s::State) = if !isempty(s.code)
  push!(s.boolean, !isa(pop!(s.code), Vector))
end

CODE_CAR(s::State) = if !isempty(s.code) && isa(s.code[end], Vector)
  s.code[end] = isempty(s.code[end]) ? [] : s.code[end][1]
end

CODE_CDR(s::State) = if !isempty(s.code)
  top = peek(s.code)
  if !isa(top, Vector) || length(top) < 2
    s.code[end] = []
  else
    s.code[end] = top[2:end]
  end
end

CODE_CONS(s::State) = if length(s.code) > 1
  top = pop!(s.code)
  s.code[end] = vcat([peek(s.code)], isa(top, Vector) ? top : [top])
end

CODE_CONTAINER(s::State) = if length(s.code) > 1
  s.code[end] = container(pop!(s.code), peek(s.code))
end

CODE_CONTAINS(s::State) = if length(s.code) > 1
  first = pop!(s.code)
  second = pop!(s.code)
  push!(s.boolean, !isempty(container(second, first)))
end

CODE_DISCREPANCY(s::State) = if length(s.code) > 1
  a = isa(peek(s.code), Vector) ? pop!(s.code) : [pop!(s.code)]
  b = isa(peek(s.code), Vector) ? pop!(s.code) : [pop!(s.code)]
  dis = zero(Int32)

  for v in setdiff(a, b)
    dis += count(x -> x == v, a)
  end
  for v in setdiff(b, a)
    dis += count(x -> x == v, b)
  end

  push!(s.integer, dis)
end

CODE_DO(s::State) = if !isempty(s.code)
  push!(s.exec, Symbol("CODE.POP"), peek(s.code))
end

CODE_DO_STAR(s::State) = if !isempty(s.code)
  push!(s.exec, pop!(s.code))
end

CODE_DO_STAR_COUNT(s::State) = if !isempty(s.code) && !isempty(s.integer) && s.integer[end] > 0
  push!(s.exec, pop!(s.code), Symbol("EXEC.DO*COUNT"))
end

CODE_DO_STAR_TIMES(s::State) = if !isempty(s.code) && !isempty(s.integer) && s.integer[end] > 0
  push!(s.exec, pop!(s.code), Symbol("EXEC.DO*TIMES"))
end

CODE_DO_STAR_RANGE(s::State) = if !isempty(s.code) && length(s.integer) > 1
  push!(s.exec, pop!(s.code), Symbol("EXEC.DO*RANGE"))
end

CODE_DUP(s::State) = if !isempty(s.code)
  push!(s.code, peek(s.code))
end

CODE_EXTRACT(s::State) = if !isempty(s.code) && !isempty(s.integer)
  index = abs(pop!(s.integer))
  code = peek(s.code)

  # Do nothing (other than pop from the INTEGER stack) if the top of the CODE
  # stack is an atom.
  if !isa(code, Vector)
    return
  end

  # Calculate the index modulo the number of points in the given expression.
  index %= num_points(code)

  # Depth-first search for the given index.
  q = Any[code]
  j = 0
  while !isempty(q)
    expr = pop!(q)

    # Put the extracted sub-expression on top of the CODE stack.
    if j == index
      s.code[end] = expr
      break
    end

    # Add sub-expressions to the front of the processing queue, from
    # left to right.
    if isa(expr, Vector)
      for k in length(expr):-1:1
        push!(q, expr[k])
      end
    end

    j += 1
  end
end

CODE_FLUSH(s::State) = empty!(s.code)

CODE_FROM_BOOLEAN(s::State) = if !isempty(s.boolean)
  push!(s.code, pop!(s.boolean))
end

CODE_FROM_FLOAT(s::State) = if !isempty(s.float)
  push!(s.code, pop!(s.float))
end

CODE_FROM_INTEGER(s::State) = if !isempty(s.integer)
  push!(s.code, pop!(s.integer))
end

CODE_FROM_NAME(s::State) = if !isempty(s.name)
  push!(s.code, pop!(s.name))
end

CODE_IF(s::State) = if !isempty(s.boolean) && length(s.code) > 1
  a = pop!(s.code)
  b = pop!(s.code)
  push!(s.exec, pop!(s.boolean) ? b : a)
end

CODE_INSERT(s::State) = if !isempty(s.integer) && length(s.code) > 1
  cntr = pop!(s.code)
  item = pop!(s.code)

  # Calculate the insertion point.
  i = abs(pop!(s.integer)) % num_points(cntr)

  # Push the modified container back onto the stack.
  push!(s.code, insert_at_point!(cntr, item, i))
end

#
# TODO
#
CODE_INSTRUCTIONS(s::State) = return

CODE_LENGTH(s::State) = if !isempty(s.code)
  top = pop!(s.code)
  push!(s.integer, isa(top, Vector) ? length(top) : 1)
end

CODE_LIST(s::State) = if length(s.code) > 1
  s.code[end] = [pop!(s.code), peek(s.code)]
end

CODE_MEMBER(s::State) = if length(s.code) > 1
  first = isa(peek(s.code), Vector) ? pop!(s.code) : [pop!(s.code)]
  push!(s.boolean, in(pop!(s.code), first))
end

CODE_NOOP(s::State) = return

CODE_NTH(s::State) = if !isempty(s.integer) && !isempty(s.code) && isa(s.code[end], Vector)
  if isempty(peek(s.code))
    s.code[end] = []
  else
    s.code[end] = s.code[end][1 + (abs(pop!(s.integer)) % length(peek(s.code)))]
  end
end

# Zeroth CDR is the first CDR in this implementation.
# Seems to be implied by the Push 3.0 language reference.
CODE_NTH_CDR(s::State) = if !isempty(s.code) && !isempty(s.integer)
  i = pop!(s.integer)
  if !isa(peek(s.code), Vector) || isempty(peek(s.code))
    s.code[end] = []
  else
    i = abs(i) % length(peek(s.code))
    deleteat!(s.code[end], 1:i+1)
  end
end

CODE_NULL(s::State) = if !isempty(s.code)
  top = pop!(s.code)
  push!(s.boolean, isa(top, Vector) && isempty(top))
end

CODE_POP(s::State) = !isempty(s.code) && pop!(s.code)

#
# TODO
#
CODE_POSITION(s::State) = return

CODE_QUOTE(s::State) = s.flag_quote_code = true

CODE_ROT(s::State) = if length(s.code) > 2
  s.code[end], s.code[end-1], s.code[end-2] =
    s.code[end-1], s.code[end-2], s.code[end]
end

CODE_SHOVE(s::State) = if !isempty(s.integer) && !isempty(s.code)
  shove!(s.code, pop!(s.integer))
end

CODE_SIZE(s::State) = if !isempty(s.code)
  push!(s.integer, num_points(pop!(s.code)))
end

CODE_STACK_DEPTH(s::State) = push!(s.integer, length(s.code))

#
# TODO
#
CODE_SUBST(s::State) = return

CODE_SWAP(s::State) = if length(s.code) >= 2
  s.code[end], s.code[end-1] = s.code[end-1], s.code[end]
end

CODE_YANK(s::State) = if !isempty(s.integer) && !isempty(s.code)
  yank!(s.code, pop!(s.integer))
end

CODE_YANK_DUP(s::State) = if !isempty(s.integer) && !isempty(s.code)
  yankdup!(s.code, pop!(s.integer))
end

CODE_RAND(s::State) = push!(s.code, random_code(s))

CODE_DEFINE(s::State) = if !isempty(s.code) && !isempty(s.name)
  s.definitions[pop!(s.name)] = pop!(s.code)
end

CODE_DEFINITION(s::State) = if !isempty(s.name) && haskey(s.definitions, pop!(s.name))
  push!(s.code, deepcopy(s.definitions[pop!(s.name)]))
end

Push.register("CODE.=",                CODE_EQ)
Push.register("CODE.APPEND",           CODE_APPEND)
Push.register("CODE.ATOM",             CODE_ATOM)
Push.register("CODE.CAR",              CODE_CAR)
Push.register("CODE.CDR",              CODE_CDR)
Push.register("CODE.CONS",             CODE_CONS)
Push.register("CODE.CONTAINER",        CODE_CONTAINER)
Push.register("CODE.CONTAINS",         CODE_CONTAINS)
Push.register("CODE.DEFINE",           CODE_DEFINE)
Push.register("CODE.DEFINITION",       CODE_DEFINITION)
Push.register("CODE.DISCREPANCY",      CODE_DISCREPANCY)
Push.register("CODE.DO",               CODE_DO)
Push.register("CODE.DO*",              CODE_DO_STAR)
Push.register("CODE.DO*COUNT",         CODE_DO_STAR_COUNT)
Push.register("CODE.DO*RANGE",         CODE_DO_STAR_RANGE)
Push.register("CODE.DO*TIMES",         CODE_DO_STAR_TIMES)
Push.register("CODE.DUP",              CODE_DUP)
Push.register("CODE.EXTRACT",          CODE_EXTRACT)
Push.register("CODE.FLUSH",            CODE_FLUSH)
Push.register("CODE.FROMBOOLEAN",      CODE_FROM_BOOLEAN)
Push.register("CODE.FROMINTEGER",      CODE_FROM_INTEGER)
Push.register("CODE.FROMNAME",         CODE_FROM_NAME)
Push.register("CODE.IF",               CODE_IF)
Push.register("CODE.INSERT",           CODE_INSERT)
Push.register("CODE.INSTRUCTIONS",     CODE_INSTRUCTIONS)
Push.register("CODE.LENGTH",           CODE_LENGTH)
Push.register("CODE.LIST",             CODE_LIST)
Push.register("CODE.MEMBER",           CODE_MEMBER)
Push.register("CODE.NOOP",             CODE_NOOP)
Push.register("CODE.NTH",              CODE_NTH)
Push.register("CODE.NTHCDR",           CODE_NTH_CDR)
Push.register("CODE.NULL",             CODE_NULL)
Push.register("CODE.POP",              CODE_POP)
Push.register("CODE.POSITION",         CODE_POSITION)
Push.register("CODE.QUOTE",            CODE_QUOTE)
Push.register("CODE.RAND",             CODE_RAND)
Push.register("CODE.ROT",              CODE_ROT)
Push.register("CODE.SHOVE",            CODE_SHOVE)
Push.register("CODE.SIZE",             CODE_SIZE)
Push.register("CODE.STACKDEPTH",       CODE_STACK_DEPTH)
Push.register("CODE.SUBST",            CODE_SUBST)
Push.register("CODE.SWAP",             CODE_SWAP)
Push.register("CODE.YANK",             CODE_YANK)
Push.register("CODE.YANKDUP",          CODE_YANK_DUP)
