NAME_EQUALS(ctx::Push3Context) = if length(ctx.name) >= 2
  push!(ctx.bool, pop!(ctx.name) == pop!(ctx.name))
end

NAME_DUP(ctx::Push3Context) = if !isempty(ctx.name)
  push!(ctx.bool, peek(ctx.name))
end

NAME_FLUSH(ctx::Push3Context) = clear!(ctx.name)

NAME_POP(ctx::Push3Context) = if !isempty(ctx.name)
  pop!(ctx.name)
end

#
# TODO
#
NAME_QUOTE(ctx::Push3Context) = ctx.flag_quote = true

#
# TODO
#
NAME_RAND(ctx::Push3Context) = return

#
# TODO
#
NAME_RAND_BOUND_NAME(ctx::Push3Context) = return

NAME_ROT(ctx::Push3Context) = if length(ctx.name) >= 3
  ctx.name[1], ctx.name[3] = ctx.name[3], ctx.name[1]
end

#
# TODO
#
NAME_SHOVE(ctx::Push3Context) = return

NAME_STACK_DEPTH(ctx::Push3Context) = push!(ctx.integer, length(ctx.name))

NAME_SWAP(ctx::Push3Context) = if length(ctx.name) >= 2
  ctx.name[1], ctx.name[2] = ctx.name[2], ctx.name[1]
end

#
# TODO
#
NAME_YANK(ctx::Push3Context) = return

#
# TODO
#
NAME_YANKDUP(ctx::Push3Context) = return

Push3.register("NAME.=", NAME_EQUALS)
Push3.register("NAME.DUP", NAME_DUP)
Push3.register("NAME.FLUSH", NAME_FLUSH)
Push3.register("NAME.POP", NAME_POP)
Push3.register("NAME.QUOTE", NAME_QUOTE)
Push3.register("NAME.RAND", NAME_RAND)
Push3.register("NAME.RANDBOUNDNAME", NAME_RAND_BOUND_NAME)
Push3.register("NAME.ROT", NAME_ROT)
Push3.register("NAME.SHOVE", NAME_SHOVE)
Push3.register("NAME.STACKDEPTH", NAME_STACK_DEPTH)
Push3.register("NAME.SWAP", NAME_SWAP)
Push3.register("NAME.YANK", NAME_YANK)
Push3.register("NAME.YANKDUP", NAME_YANKDUP)