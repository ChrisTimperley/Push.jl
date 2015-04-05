INTEGER_MODULO(ctx::Push3Context) = if length(ctx.integer) >= 2
  divisor = pop!(ctx.integer)
  if divisor != zero(Int32)
    # FILL IN.
  end 
end

# Pushes the product of the top two integers on the stack.
INTEGER_MUL(ctx::Push3Context) = if length(ctx.integer) >= 2
  push!(ctx.integer, pop!(ctx.integer) * pop!(ctx.integer))
end

# Pushes the sum of the top two integers on the stack.
INTEGER_PLUS(ctx::Push3Context) = if length(ctx.integer) >= 2
  push!(ctx.integer, pop!(ctx.integer) + pop!(ctx.integer))
end

# Pushes the 2nd integer on the stack minus the 1st.
INTEGER_MINUS(ctx::Push3Context) = if length(ctx.integer) >= 2
  push!(ctx.integer, - pop!(ctx.integer) + pop!(ctx.integer))
end

# Pushes the 2nd integer on the stack divided by the 1st.
INTEGER_DIV(ctx::Push3Context) = if length(ctx.integer) >= 2
  div = pop!(ctx.integer)
  if divisor != zero(Int32)
    push!(ctx.integer, pop!(ctx.integer) / div)
  end
end

# Pushes True onto the boolean stack if the 2nd item on the INTEGER
# stack is less than the first, else False is pushed onto the boolean
# stack. We flip the operation internally to speed things up a bit.
INTEGER_LT(ctx::Push3Context) = if length(ctx.integer) >= 2
  push!(ctx.boolean, pop!(ctx.integer) > pop!(ctx.integer))
end

INTEGER_EQ(ctx::Push3Context) = if length(ctx.integer) >= 2
  push!(ctx.boolean, pop!(ctx.integer) == pop!(ctx.integer))
end

INTEGER_GT(ctx::Push3Context) = if length(ctx.integer) >= 2
  push!(ctx.boolean, pop!(ctx.integer) < pop!(ctx.integer))
end

# Defines the name of top of the NAME stack as an instruction which will
# push the item currently on top of the INTEGER stack onto the EXEC stack.
INTEGER_DEFINE(ctx::Push3Context) = if !isempty(ctx.integer) && !isempty(ctx.name)
  register(ctx, pop!(ctx.name), pop!(ctx.integer))
end

# Creates a duplicate of the top item on the INTEGER stack above it.
INTEGER_DUP(ctx::Push3Context) = if !isempty(ctx.integer)
  push!(ctx.integer, peek(ctx.integer))
end

# Clears the contents of the INTEGER stack.
INTEGER_FLUSH(ctx::Push3Context) = clear!(ctx.integer)

# Pushes 1 if the top of the BOOLEAN stack is true, or 0 if false.
INTEGER_FROM_BOOLEAN(ctx::Push3Context) = if !isempty(ctx.boolean)
  push!(ctx.integer, pop!(ctx.boolean) ? 1 : 0)
end

# 