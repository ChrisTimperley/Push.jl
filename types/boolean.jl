BOOLEAN_EQUALS(ctx::Push3Context) = if length(ctx.boolean) >= 2
  push!(ctx.boolean, pop!(ctx.boolean) == pop!(ctx.boolean))
end

# Don't bother actually popping and pushing. Edit the top of the stack.
BOOLEAN_NOT(ctx::Push3Context) = if !isempty(ctx.boolean)
  ctx.boolean[1] = !ctx.boolean[1]
end

BOOLEAN_AND(ctx::Push3Context) = if length(ctx.boolean) >= 2
  push!(ctx.boolean, pop!(ctx.boolean) && pop!(ctx.boolean))
end

BOOLEAN_OR(ctx::Push3Context) = if length(ctx.boolean) >= 2
  push!(ctx.boolean, pop!(ctx.boolean) || pop!(ctx.boolean))
end

BOOLEAN_DEFINE(ctx::Push3Context) = return

BOOLEAN_DUP(ctx::Push3Context) = if !isempty(ctx.boolean)
  push!(ctx.boolean, peek(ctx.boolean))
end

BOOLEAN_FLUSH(ctx::Push3Context) = if !isempty(ctx.boolean)
  clear!(ctx.boolean)
end

BOOLEAN_FROM_FLOAT(ctx::Push3Context) = if !isempty(ctx.float)
  push!(ctx.boolean, pop!(ctx.float) != zero(Float32))
end

BOOLEAN_FROM_INT(ctx::Push3Context) = if !isempty(ctx.int)
  push!(ctx.boolean, pop!(ctx.int) != zero(Int32))
end

BOOLEAN_POP(ctx::Push3Context) = pop!(ctx.boolean)

BOOLEAN_ROT(ctx::Push3Context) = if length(ctx.boolean) >= 3
  t = ctx.boolean[1]
  ctx.boolean[1] = ctx.boolean[3]
  ctx.boolean[3] = t
end

BOOLEAN_SHOVE(ctx::Push3Context) = if !isempty(ctx.int)
  insert_at!(ctx.boolean, pop!(ctx.boolean), pop!(ctx.int))
end

BOOLEAN_RAND(ctx::Push3Context) = push!(ctx.boolean, RANDOM_BOOLEAN)

BOOLEAN_STACKDEPTH(ctx::Push3Context) = push!(ctx.int, length(ctx.boolean))

BOOLEAN_SWAP(ctx::Push3Context) = if length(ctx.boolean) >= 2
  t = ctx.boolean[1]
  ctx.boolean[1] = ctx.boolean[2]
  ctx.boolean[2] = t
end

# could tell it which stacks we use?
Push3.register("BOOLEAN.EQUALS",      BOOLEAN_EQUALS)
Push3.register("BOOLEAN.NOT",         BOOLEAN_NOT)
Push3.register("BOOLEAN.AND",         BOOLEAN_AND)
Push3.register("BOOLEAN.OR",          BOOLEAN_OR)
Push3.register("BOOLEAN.DEFINE",      BOOLEAN_DEFINE)
Push3.register("BOOLEAN.DUP",         BOOLEAN_DUP)
Push3.register("BOOLEAN.FLUSH",       BOOLEAN_FLUSH)
Push3.register("BOOLEAN.FROM_FLOAT",  BOOLEAN_FROM_FLOAT)
Push3.register("BOOLEAN.FROM_INT",    BOOLEAN_FROM_INT)
Push3.register("BOOLEAN.POP",         BOOLEAN_POP)
Push3.register("BOOLEAN.ROT",         BOOLEAN_ROT)
Push3.register("BOOLEAN.SHOVE",       BOOLEAN_SHOVE)
Push3.register("BOOLEAN.RAND",        BOOLEAN_RAND)
Push3.register("BOOLEAN.STACKDEPTH",  BOOLEAN_STACKDEPTH)
Push3.register("BOOLEAN.SWAP",        BOOLEAN_SWAP)