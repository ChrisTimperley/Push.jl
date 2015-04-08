NAME_EQUALS(s::State) = if length(s.name) >= 2
  push!(s.bool, pop!(s.name) == pop!(s.name))
end

NAME_DUP(s::State) = if !isempty(s.name)
  push!(s.bool, peek(s.name))
end

NAME_FLUSH(s::State) = empty!(s.name)

NAME_POP(s::State) = !isempty(s.name) && pop!(s.name)

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
  s.name[end], s.name[end-2] = s.name[end-2], s.name[end]
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