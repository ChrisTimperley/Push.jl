NAME_EQUALS(s::State) = if length(s.name) >= 2
  push!(s.boolean, pop!(s.name) == pop!(s.name))
end

NAME_DUP(s::State) = if !isempty(s.name)
  push!(s.name, peek(s.name))
end

NAME_FLUSH(s::State) = empty!(s.name)

NAME_POP(s::State) = !isempty(s.name) && pop!(s.name)

NAME_QUOTE(s::State) = s.flag_quote_name = true

NAME_RAND(s::State) = push!(s.name, random_name(s))

NAME_RAND_BOUND_NAME(s::State) = push!(s.name, random_bound_name(s))

NAME_ROT(s::State) = if length(s.name) > 2
  s.name[end], s.name[end-1], s.name[end-2] =
    s.name[end-1], s.name[end-2], s.name[end]
end

NAME_SHOVE(s::State) = if !isempty(s.integer) && !isempty(s.name)
  shove!(s.name, pop!(s.integer))
end

NAME_STACK_DEPTH(s::State) = push!(s.integer, length(s.name))

NAME_SWAP(s::State) = if length(s.name) >= 2
  s.name[end], s.name[end-1] = s.name[end-1], s.name[end]
end

NAME_YANK(s::State) = if !isempty(s.integer) && !isempty(s.name)
  yank!(s.name, pop!(s.integer))
end

NAME_YANKDUP(s::State) = if !isempty(s.integer) && !isempty(s.name)
  yankdup!(s.name, pop!(s.integer))
end

NAME_ERC(s::State) = return

Push.register("NAME.=",              NAME_EQUALS)
Push.register("NAME.DUP",            NAME_DUP)
Push.register("NAME.FLUSH",          NAME_FLUSH)
Push.register("NAME.POP",            NAME_POP)
Push.register("NAME.QUOTE",          NAME_QUOTE)
Push.register("NAME.RAND",           NAME_RAND)
Push.register("NAME.RANDBOUNDNAME",  NAME_RAND_BOUND_NAME)
Push.register("NAME.ROT",            NAME_ROT)
Push.register("NAME.SHOVE",          NAME_SHOVE)
Push.register("NAME.STACKDEPTH",     NAME_STACK_DEPTH)
Push.register("NAME.SWAP",           NAME_SWAP)
Push.register("NAME.YANK",           NAME_YANK)
Push.register("NAME.YANKDUP",        NAME_YANKDUP)
Push.register("NAME.ERC",            NAME_ERC)
