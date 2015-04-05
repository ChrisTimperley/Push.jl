INTEGER_MOD(ctx::Push3Context) = if length(ctx.integer) >= 2
  divisor = pop!(ctx.integer)
  if divisor != zero(Int32)
    # FILL IN.
  end 
end

INTEGER_MUL(ctx::Push3Context) = if length(ctx.integer) >= 2
  push!(ctx.integer, pop!(ctx.integer) * pop!(ctx.integer))
end

INTEGER_PLUS(ctx::Push3Context) = if length(ctx.integer) >= 2
  push!(ctx.integer, pop!(ctx.integer) + pop!(ctx.integer))
end

INTEGER_MINUS(ctx::Push3Context) = if length(ctx.integer) >= 2
  push!(ctx.integer, - pop!(ctx.integer) + pop!(ctx.integer))
end

INTEGER_DIV(ctx::Push3Context) = if length(ctx.integer) >= 2
  div = peek(ctx.integer)
  if div != zero(Int32)
    pop!(ctx.integer)
    push!(ctx.integer, pop!(ctx.integer) / div)
  end
end

INTEGER_LT(ctx::Push3Context) = if length(ctx.integer) >= 2
  push!(ctx.boolean, pop!(ctx.integer) > pop!(ctx.integer))
end

INTEGER_EQ(ctx::Push3Context) = if length(ctx.integer) >= 2
  push!(ctx.boolean, pop!(ctx.integer) == pop!(ctx.integer))
end

INTEGER_GT(ctx::Push3Context) = if length(ctx.integer) >= 2
  push!(ctx.boolean, pop!(ctx.integer) < pop!(ctx.integer))
end

INTEGER_DEFINE(ctx::Push3Context) = if !isempty(ctx.integer) && !isempty(ctx.name)
  register(ctx, pop!(ctx.name), pop!(ctx.integer))
end

INTEGER_DUP(ctx::Push3Context) = if !isempty(ctx.integer)
  push!(ctx.integer, peek(ctx.integer))
end

INTEGER_FLUSH(ctx::Push3Context) = clear!(ctx.integer)

INTEGER_FROM_BOOLEAN(ctx::Push3Context) = if !isempty(ctx.boolean)
  push!(ctx.integer, pop!(ctx.boolean) ? one(Int32) : zero(Int32))
end

# 
# TODO:
# Check Push3 reference integer to floating point conversion semantics.
#
INTEGER_FROM_FLOAT(ctx::Push3Context) = if !isempty(ctx.float)
  push!(ctx.integer, pop!(ctx.float))
end

INTEGER_MAX(ctx::Push3Context) = if length(ctx.integer) >= 2
  push!(ctx.integer, max(pop!(ctx.integer), pop!(ctx.integer)))
end

INTEGER_MIN(ctx::Push3Context) = if length(ctx.integer) >= 2
  push!(ctx.integer, min(pop!(ctx.integer), pop!(ctx.integer)))
end

INTEGER_POP(ctx::Push3Context) = if !isempty(ctx.integer)
  pop!(ctx.integer)
end

#
# TODO:
# Implement RAND functions.
#
INTEGER_RAND(ctx::Push3Context) = return

INTEGER_ROT(ctx::Push3Context) = if length(ctx.integer) >= 3
  ctx.integer[1], ctx.integer[3] = ctx.integer[3], ctx.integer[1]
end

# 
# TODO:
# Look into semantics of SHOVE.
#
INTEGER_SHOVE(ctx::Push3Context) = if length(ctx.integer) >= 2
  #index = pop!(ctx.integer)
#
  #insert_at!(ctx.integer, pop!(ctx.integer), pop!(ctx.integer))
end

INTEGER_STACK_DEPTH(ctx::Push3Context) = push!(ctx.integer, length(ctx.integer))

INTEGER_SWAP(ctx::Push3Context) = if length(ctx.integer) >= 2
  ctx.integer[1], ctx.integer[2] = ctx.integer[2], ctx.integer[1]
end

#
# TODO
#
INTEGER_YANK(ctx::Push3Context) = return

#
# TODO
#
INTEGER_YANKDUP(ctx::Push3Context) = return

Push3.register("INTEGER.%",           INTEGER_MOD)
Push3.register("INTEGER.*",           INTEGER_MUL)
Push3.register("INTEGER.+",           INTEGER_PLUS)
Push3.register("INTEGER.-",           INTEGER_SUB)
Push3.register("INTEGER./",           INTEGER_DIV)
Push3.register("INTEGER.<",           INTEGER_LT)
Push3.register("INTEGER.=",           INTEGER_EQ)
Push3.register("INTEGER.>",           INTEGER_GT)
Push3.register("INTEGER.DEFINE",      INTEGER_DEFINE)
Push3.register("INTEGER.DUP",         INTEGER_DUP)
Push3.register("INTEGER.FLUSH",       INTEGER_FLUSH)
Push3.register("INTEGER.FROMBOOLEAN", INTEGER_FROM_BOOLEAN)
Push3.register("INTEGER.FROMFLOAT",   INTEGER_FROM_FLOAT)
Push3.register("INTEGER.MAX",         INTEGER_MAX)
Push3.register("INTEGER.MIN",         INTEGER_MIN)
Push3.register("INTEGER.POP",         INTEGER_POP)
Push3.register("INTEGER.RAND",        INTEGER_RAND)
Push3.register("INTEGER.ROT",         INTEGER_ROT)
Push3.register("INTEGER.SHOVE",       INTEGER_SHOVE)
Push3.register("INTEGER.STACKDEPTH",  INTEGER_STACK_DEPTH)
Push3.register("INTEGER.SWAP",        INTEGER_SWAP)
Push3.register("INTEGER.YANK",        INTEGER_YANK)
Push3.register("INTEGER.YANKDUP",     INTEGER_YANKDUP)