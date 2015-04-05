INTEGER_MODULO(ctx::Push3Context) = if length(ctx.integer) >= 2
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
  div = pop!(ctx.integer)
  if divisor != zero(Int32)
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

INTEGER_STACKDEPTH(ctx::Push3Context) = push!(ctx.integer, length(ctx.integer))

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

