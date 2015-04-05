EXEC_EQ(ctx::Push3Context) = if length(ctx.exec) >= 2
  push!(ctx.boolean, pop!(ctx.exec) === pop!(ctx.exec))
end

#
# TODO
#
EXEC_DEFINE(ctx::Push3Context) = if !isempty(ctx.name) && !isempty(ctx.exec)
  register(ctx, pop!(ctx.name), pop!(ctx.exec)) 
end

#
# TODO
#
EXEC_DO_STAR_COUNT(ctx::Push3Context) = return

#
# TODO
#
EXEC_DO_STAR_RANGE(ctx::Push3Context) = return

#
# TODO
#
EXEC_DO_STAR_TIMES(ctx::Push3Context) = return

# What if "EXEC_DUP" is the command being duplicated?
# Should we allow it to be cloned?
EXEC_DUP(ctx::Push3Context) = if !isempty(ctx.exec)
  push!(ctx.exec, peek(ctx.exec))
end

EXEC_FLUSH(ctx::Push3Context) = clear!(ctx.exec)

EXEC_IF(ctx::Push3Context) = if !isempty(ctx.boolean) && length(ctx.exec) >= 2
  a = pop!(ctx.exec)
  b = pop!(ctx.exec)
  push!(ctx.exec, pop!(ctx.boolean) ? a : b)
end

# What happens when we're dealing with lists?
EXEC_K(ctx::Push3Context) = if length(ctx.exec) >= 2
  ctx.exec[1] = pop!(ctx.exec)
end

EXEC_POP(ctx::Push3Context) = pop!(ctx.exec)

EXEC_ROT(ctx::Push3Context) = if length(ctx.exec) >= 3
  ctx.exec[3], ctx.exec[1] = ctx.exec[1], ctx.exec[3]
end

#
# TODO
#
EXEC_S(ctx::Push3Context) = if length(ctx.exec) >= 3
  a = pop!(ctx.exec)
  b = pop!(ctx.exec)
  c = pop!(ctx.exec)

  # (B C) C A ?
end

#
# TODO
#
EXEC_SHOVE(ctx::Push3Context) = return

EXEC_STACK_DEPTH(ctx::Push3Context) = push!(ctx.integer, length(ctx.exec))

EXEC_SWAP(ctx::Push3Context) = if length(ctx.exec) >= 2
  ctx.exec[1], ctx.exec[2] = ctx.exec[2], ctx.exec[1]
end

EXEC_Y(ctx::Push3Context) = if !isempty(ctx.exec)
  top = pop!(ctx.exec)
  # (EXEC.Y <top>)
  push!(ctx.exec, top)
end

#
# TODO
#
EXEC_YANK(ctx::Push3Context) = return

#
# TODO
#
EXEC_YANK_DUP(ctx::Push3Context) = return

Push3.register("EXEC.=",          EXEC_EQ)
Push3.register("EXEC.DEFINE",     EXEC_DEFINE)
Push3.register("EXEC.DO*COUNT",   EXEC_DO_STAR_COUNT)
Push3.register("EXEC.DO*RANGE",   EXEC_DO_STAR_RANGE)
Push3.register("EXEC.DO*TIMES",   EXEC_DO_STAR_TIMES)
Push3.register("EXEC.DUP",        EXEC_DUP)
Push3.register("EXEC.FLUSH",      EXEC_FLUSH)
Push3.register("EXEC.IF",         EXEC_IF)
Push3.register("EXEC.K",          EXEC_K)
Push3.register("EXEC.POP",        EXEC_POP)
Push3.register("EXEC.ROT",        EXEC_ROT)
Push3.register("EXEC.S",          EXEC_S)
Push3.register("EXEC.SHOVE",      EXEC_SHOVE)
Push3.register("EXEC.STACKDEPTH", EXEC_STACK_DEPTH)
Push3.register("EXEC.SWAP",       EXEC_SWAP)
Push3.register("EXEC.Y",          EXEC_Y)
Push3.register("EXEC.YANK",       EXEC_YANK)
Push3.register("EXEC.YANKDUP",    EXEC_YANK_DUP)