NAME_EQUALS(s::State) = if length(s.name) >= 2
  push!(s.bool, pop!(s.name) == pop!(s.name))
end

NAME_DUP(s::State) = if !isempty(s.name)
  push!(s.bool, peek(s.name))
end

NAME_FLUSH(s::State) = clear!(s.name)

NAME_POP(s::State) = if !isempty(s.name)
  pop!(s.name)
end

#
# TODO
#
NAME_QUOTE(s::State) = s.flag_quote = true

#
# TODO
#
NAME_RAND(s::State) = return

#
# TODO
#
NAME_RAND_BOUND_NAME(s::State) = return

NAME_ROT(s::State) = if length(s.name) >= 3
  s.name[1], s.name[3] = s.name[3], s.name[1]
end

#
# TODO
#
NAME_SHOVE(s::State) = return

NAME_STACK_DEPTH(s::State) = push!(s.integer, length(s.name))

NAME_SWAP(s::State) = if length(s.name) >= 2
  s.name[1], s.name[2] = s.name[2], s.name[1]
end

#
# TODO
#
NAME_YANK(s::State) = return

#
# TODO
#
NAME_YANKDUP(s::State) = return

Push3.register("NAME.=",              NAME_EQUALS)
Push3.register("NAME.DUP",            NAME_DUP)
Push3.register("NAME.FLUSH",          NAME_FLUSH)
Push3.register("NAME.POP",            NAME_POP)
Push3.register("NAME.QUOTE",          NAME_QUOTE)
Push3.register("NAME.RAND",           NAME_RAND)
Push3.register("NAME.RANDBOUNDNAME",  NAME_RAND_BOUND_NAME)
Push3.register("NAME.ROT",            NAME_ROT)
Push3.register("NAME.SHOVE",          NAME_SHOVE)
Push3.register("NAME.STACKDEPTH",     NAME_STACK_DEPTH)
Push3.register("NAME.SWAP",           NAME_SWAP)
Push3.register("NAME.YANK",           NAME_YANK)
Push3.register("NAME.YANKDUP",        NAME_YANKDUP)