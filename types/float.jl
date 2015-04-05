#
# TODO
#
FLOAT_MOD(ctx::Push3Context) = return

FLOAT_MUL(ctx::Push3Context) = if length(ctx.float) >= 2
  push!(ctx.float, pop!(ctx.float) * pop!(ctx.float))
end

FLOAT_PLUS(ctx::Push3Context) = if length(ctx.float) >= 2
  push!(ctx.float, pop!(ctx.float) + pop!(ctx.float))
end

FLOAT_SUB(ctx::Push3Context) = if length(ctx.float) >= 2
  push!(ctx.float, pop!(ctx.float) - pop!(ctx.float))
end

FLOAT_DIV(ctx::Push3Context) = if length(ctx.float) >= 2
  div = peek(ctx.float)
  if div != zero(Float32)
    pop!(ctx.float)
    push!(ctx.float, pop!(ctx.float) / div)
  end
end

FLOAT_LT(ctx::Push3Context) = if length(ctx.float) >= 2
  push!(ctx.boolean, pop!(ctx.float) > pop!(ctx.float))
end

FLOAT_EQ(ctx::Push3Context) = if length(ctx.float) >= 2
  push!(ctx.boolean, pop!(ctx.float) == pop!(ctx.float))
end

FLOAT_GT(ctx::Push3Context) = if length(ctx.float) >= 2
  push!(ctx.boolean, pop!(ctx.float) < pop!(ctx.float))
end

FLOAT_COS(ctx::Push3Context) = if !isempty(ctx.float)
  push!(ctx.float, cos(pop!(ctx.float)))
end

FLOAT_DEFINE(ctx::Push3Context) = if !isempty(ctx.float) && !isempty(ctx.name)
  register(ctx, pop!(ctx.name), pop!(ctx.float))
end

FLOAT_DUP(ctx::Push3Context) = if !isempty(ctx.float)
  push!(ctx.float, peek(ctx.float))
end

FLOAT_FLUSH(ctx::Push3Context) = clear!(ctx.float)

FLOAT_FROM_BOOLEAN(ctx::Push3Context) = if !isempty(ctx.boolean)
  push!(ctx.float, pop!(ctx.boolean) ? one(Float32) : zero(Float32))
end

FLOAT_FROM_INTEGER(ctx::Push3Context) = if !isempty(ctx.integer)
  push!(ctx.float, convert(Float32, pop!(ctx.integer))
end

FLOAT_MAX(ctx::Push3Context) = if length(ctx.float) >= 2
  push!(ctx.float, max(pop!(ctx.float), pop!(ctx.float)))
end

FLOAT_MIN(ctx::Push3Context) = if length(ctx.float) >= 2
  push!(ctx.float, min(pop!(ctx.float), pop!(ctx.float)))
end

FLOAT_POP(ctx::Push3Context) = if !isempty(ctx.float)
  pop!(ctx.float)
end

#
# TODO
#
FLOAT_RAND(ctx::Push3Context) = return

FLOAT_ROT(ctx::Push3Context) = if length(ctx.float) >= 3
  ctx.float[1], ctx.float[3] = ctx.float[3], ctx.float[1]
end

#
# TODO
#
FLOAT_SHOVE(ctx::Push3Context) = return

FLOAT_SIN(ctx::Push3Context) = if !isempty(ctx.float)
  push!(ctx.float, sin(pop!(ctx.float)))
end

FLOAT_STACK_DEPTH(ctx::Push3Context) = push!(ctx.integer, length(ctx.float))

FLOAT_SWAP(ctx::Push3Context) = if length(ctx.float) >= 2
  ctx.float[1], ctx.float[2] = ctx.float[2], ctx.float[1]
end

FLOAT_TAN(ctx::Push3Context) = if !isempty(ctx.float)
  push!(ctx.float, tan(pop!(ctx.float)))
end

#
# TODO
#
FLOAT_YANK(ctx::Push3Context) = return

#
# TODO
#
FLOAT_YANKDUP(ctx::Push3Context) = return

Push3.register("FLOAT.%",           FLOAT_MOD)
Push3.register("FLOAT.*",           FLOAT_MUL)
Push3.register("FLOAT.+",           FLOAT_PLUS)
Push3.register("FLOAT.-",           FLOAT_SUB),
Push3.register("FLOAT./",           FLOAT_DIV)
Push3.register("FLOAT.<",           FLOAT_LT)
Push3.register("FLOAT.=",           FLOAT_EQ)
Push3.register("FLOAT.>",           FLOAT_GT)
Push3.register("FLOAT.COS",         FLOAT_COS)
Push3.register("FLOAT.DEFINE",      FLOAT_DEFINE)
Push3.register("FLOAT.DUP",         FLOAT_DUP)
Push3.register("FLOAT.FLUSH",       FLOAT_FLUSH)
Push3.register("FLOAT.FROMBOOLEAN", FLOAT_FROM_BOOLEAN)
Push3.register("FLOAT.FROMINTEGER", FLOAT_FROM_INTEGER)
Push3.register("FLOAT.MAX",         FLOAT_MAX)
Push3.register("FLOAT.MIN",         FLOAT_MIN)
Push3.register("FLOAT.POP",         FLOAT_POP)
Push3.register("FLOAT.RAND",        FLOAT_RAND)
Push3.register("FLOAT.ROT",         FLOAT_ROT)
Push3.register("FLOAT.SHOVE",       FLOAT_SHOVE)
Push3.register("FLOAT.SIN",         FLOAT_SIN)
Push3.register("FLOAT.STACKDEPTH",  FLOAT_STACK_DEPTH)
Push3.register("FLOAT.SWAP",        FLOAT_SWAP)
Push3.register("FLOAT.TAN",         FLOAT_TAN)
Push3.register("FLOAT.YANK",        FLOAT_YANK)
Push3.register("FLOAT.YANKDUP",     FLOAT_YANKDUP)