INTEGER_MOD(s::State) = if length(s.integer) >= 2
  divisor = pop!(s.integer)
  if divisor != zero(Int32)
    # FILL IN.
  end 
end

INTEGER_MUL(s::State) = if length(s.integer) >= 2
  push!(s.integer, pop!(s.integer) * pop!(s.integer))
end

INTEGER_PLUS(s::State) = if length(s.integer) >= 2
  push!(s.integer, pop!(s.integer) + pop!(s.integer))
end

INTEGER_SUB(s::State) = if length(s.integer) >= 2
  push!(s.integer, - pop!(s.integer) + pop!(s.integer))
end

INTEGER_DIV(s::State) = if length(s.integer) >= 2
  div = peek(s.integer)
  if div != zero(Int32)
    pop!(s.integer)
    push!(s.integer, pop!(s.integer) / div)
  end
end

INTEGER_LT(s::State) = if length(s.integer) >= 2
  push!(s.boolean, pop!(s.integer) > pop!(s.integer))
end

INTEGER_EQ(s::State) = if length(s.integer) >= 2
  push!(s.boolean, pop!(s.integer) == pop!(s.integer))
end

INTEGER_GT(s::State) = if length(s.integer) >= 2
  push!(s.boolean, pop!(s.integer) < pop!(s.integer))
end

INTEGER_DEFINE(s::State) = if !isempty(s.integer) && !isempty(s.name)
  register(s, pop!(s.name), pop!(s.integer))
end

INTEGER_DUP(s::State) = if !isempty(s.integer)
  push!(s.integer, peek(s.integer))
end

INTEGER_FLUSH(s::State) = empty!(s.integer)

INTEGER_FROM_BOOLEAN(s::State) = if !isempty(s.boolean)
  push!(s.integer, pop!(s.boolean) ? one(Int32) : zero(Int32))
end

# 
# TODO:
# Check Push3 reference integer to floating point conversion semantics.
#
INTEGER_FROM_FLOAT(s::State) = if !isempty(s.float)
  push!(s.integer, pop!(s.float))
end

INTEGER_MAX(s::State) = if length(s.integer) >= 2
  push!(s.integer, max(pop!(s.integer), pop!(s.integer)))
end

INTEGER_MIN(s::State) = if length(s.integer) >= 2
  push!(s.integer, min(pop!(s.integer), pop!(s.integer)))
end

INTEGER_POP(s::State) = if !isempty(s.integer)
  pop!(s.integer)
end

#
# TODO:
# Implement RAND functions.
#
INTEGER_RAND(s::State) = return

INTEGER_ROT(s::State) = if length(s.integer) >= 3
  s.integer[1], s.integer[3] = s.integer[3], s.integer[1]
end

# 
# TODO:
# Look into semantics of SHOVE.
#
INTEGER_SHOVE(s::State) = if length(s.integer) >= 2
  #index = pop!(s.integer)
#
  #insert_at!(s.integer, pop!(s.integer), pop!(s.integer))
end

INTEGER_STACK_DEPTH(s::State) = push!(s.integer, length(s.integer))

INTEGER_SWAP(s::State) = if length(s.integer) >= 2
  s.integer[1], s.integer[2] = s.integer[2], s.integer[1]
end

#
# TODO
#
INTEGER_YANK(s::State) = return

#
# TODO
#
INTEGER_YANKDUP(s::State) = return

Push.register("INTEGER.%",           INTEGER_MOD)
Push.register("INTEGER.*",           INTEGER_MUL)
Push.register("INTEGER.+",           INTEGER_PLUS)
Push.register("INTEGER.-",           INTEGER_SUB)
Push.register("INTEGER./",           INTEGER_DIV)
Push.register("INTEGER.<",           INTEGER_LT)
Push.register("INTEGER.=",           INTEGER_EQ)
Push.register("INTEGER.>",           INTEGER_GT)
Push.register("INTEGER.DEFINE",      INTEGER_DEFINE)
Push.register("INTEGER.DUP",         INTEGER_DUP)
Push.register("INTEGER.FLUSH",       INTEGER_FLUSH)
Push.register("INTEGER.FROMBOOLEAN", INTEGER_FROM_BOOLEAN)
Push.register("INTEGER.FROMFLOAT",   INTEGER_FROM_FLOAT)
Push.register("INTEGER.MAX",         INTEGER_MAX)
Push.register("INTEGER.MIN",         INTEGER_MIN)
Push.register("INTEGER.POP",         INTEGER_POP)
Push.register("INTEGER.RAND",        INTEGER_RAND)
Push.register("INTEGER.ROT",         INTEGER_ROT)
Push.register("INTEGER.SHOVE",       INTEGER_SHOVE)
Push.register("INTEGER.STACKDEPTH",  INTEGER_STACK_DEPTH)
Push.register("INTEGER.SWAP",        INTEGER_SWAP)
Push.register("INTEGER.YANK",        INTEGER_YANK)
Push.register("INTEGER.YANKDUP",     INTEGER_YANKDUP)