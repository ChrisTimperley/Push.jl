CODE_EQ(s::State) = if length(s.code) > 1
  push!(s.boolean, pop!(s.code) === pop!(s.code))
end

CODE_APPEND(s::State) = if length(s.code) > 1
  first = pop!(s.code)
  second = peek(s.code)
  s.code[end] = vcat(isa(first, Vector) ? first : {first},
    isa(second, Vector) ? second : {second})
end

CODE_ATOM(s::State) = if !isempty(s.code)
  push!(s.boolean, !isa(pop!(s.code), Vector))
end

CODE_CAR(s::State) = if !isempty(s.code) && isa(s.code[end], Vector)
  s.code[end] = isempty(s.code[end]) ? {} : s.code[end][1]
end

CODE_CDR(s::State) = if !isempty(s.code)
  top = peek(s.code)
  if !isa(top, Vector) || length(top) < 2
    s.code[end] = {}
  else
    shift!(top[2:end])
  end
end

CODE_CONS(s::State) = if length(s.code) > 1
  top = pop!(s.code)
  s.code[end] = vcat({peek(s.code)}, isa(top, Vector) ? top : {top})
end

# Pushes the container of the 2nd CODE item within the 1st CODE item onto the stack, or
# an empty list if no such container can be found.
CODE_CONTAINER(s::State) = if length(s.code) > 1
  haystack = pop!(s.code)
  needle = peek(s.code)

  # If the haystack isn't a list, then push an empty list onto the CODE stack.
  if !isa(haystack, Vector)
    s.code[end] = {}
    return
  end

  # Perform a breadth-first recursive search of the haystack, from left to right.
  found = false
  q = {haystack}
  while !isempty(q)
    container = pop!(q)

    # Search for the needle in the container.
    if in(needle, container)
      found = true
      break
    end

    # Add sub-lists onto end of search queue.
    for subcontainer in container
      push!(q, subcontainer)
    end
  end

  # Replace the needle at the top of the CODE stack with its container, or if no
  # container was found, replace with an empty list.
  s.code[end] = found ? container : {}
end

#
# TODO
#
CODE_CONTAINS(s::State) = return

#
# TODO
#
CODE_DEFINE(s::State) = return

#
# TODO
#
CODE_DEFINITION(s::State) = return

#
# TODO
#
CODE_DISCREPANCY(s::State) = return

CODE_DO(s::State) = if !isempty(s.code)
  push!(s.exec, convert(Symbol, "CODE.POP"), peek(s.code))
end

CODE_DO_STAR(s::State) = if !isempty(s.code)
  push!(s.exec, pop!(s.code))
end

CODE_DO_STAR_COUNT(s::State) = if !isempty(s.code) && !isempty(s.integer) && s.integer[end] > 0
  push!(s.exec, pop!(s.code), convert(Symbol, "EXEC.DO*COUNT"))
end

CODE_DO_STAR_TIMES(s::State) = if !isempty(s.code) && !isempty(s.integer) && s.integer[end] > 0
  push!(s.exec, pop!(s.code), convert(Symbol, "EXEC.DO*TIMES"))
end

CODE_DO_STAR_RANGE(s::State) = if !isempty(s.code) && length(s.integer) > 1
  push!(s.exec, pop!(s.code), convert(Symbol, "EXEC.DO*RANGE"))
end

CODE_DUP(s::State) = if !isempty(s.code)
  push!(s.code, peek(s.code))
end

CODE_EXTRACT(s::State) = if !isempty(s.code) && !isempty(s.integer)
  
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

#
# TODO
#
CODE_INSERT(s::State) = return

#
# TODO
#
CODE_INSTRUCTIONS(s::State) = return

CODE_LENGTH(s::State) = if !isempty(s.code)
  top = pop!(s.code)
  push!(s.integer, isa(top, Vector) ? length(top) : 1)
end

CODE_LIST(s::State) = if length(s.code) > 1
  s.code[end] = {pop!(s.code), peek(s.code)}
end

#
# TODO
#
CODE_MEMBER(s::State) = return

CODE_NOOP(s::State) = return

CODE_NTH(s::State) = if !isempty(s.integer) && !isempty(s.code) && isa(s.code[end], Vector)
  s.code[end] = s.code[end][1 + (abs(pop!(s.integer)) % length(peek(s.code)))]
end

#
# TODO
#
CODE_NTH_CDR(s::State) = return

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
    s.code[end-2], s.code[end], s.code[end-1]
end

#
# TODO
#
CODE_SHOVE(s::State) = return

#
# TODO
#
CODE_SIZE(s::State) = return

#
# TODO
#
CODE_STACK_DEPTH(s::State) = push!(s.integer, length(s.code))

#
# TODO
#
CODE_SUBST(s::State) = return

CODE_SWAP(s::State) = if length(s.code) >= 2
  s.code[end], s.code[end-1] = s.code[end-1], s.code[end]
end

#
# TODO
#
CODE_YANK(s::State) = return

#
# TODO
#
CODE_YANK_DUP(s::State) = return

CODE_RAND(s::State) = return

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