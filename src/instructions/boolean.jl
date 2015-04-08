BOOLEAN_EQUALS(s::State) = if length(s.boolean) >= 2
  push!(s.boolean, pop!(s.boolean) == pop!(s.boolean))
end

# Don't bother actually popping and pushing. Edit the top of the stack.
BOOLEAN_NOT(s::State) = if !isempty(s.boolean)
  s.boolean[1] = !s.boolean[1]
end

BOOLEAN_AND(s::State) = if length(s.boolean) >= 2
  push!(s.boolean, pop!(s.boolean) & pop!(s.boolean))
end

BOOLEAN_OR(s::State) = if length(s.boolean) >= 2
  push!(s.boolean, pop!(s.boolean) | pop!(s.boolean))
end

BOOLEAN_DEFINE(s::State) = return

BOOLEAN_DUP(s::State) = if !isempty(s.boolean)
  push!(s.boolean, peek(s.boolean))
end

BOOLEAN_FLUSH(s::State) = if !isempty(s.boolean)
  empty!(s.boolean)
end

BOOLEAN_FROM_FLOAT(s::State) = if !isempty(s.float)
  push!(s.boolean, pop!(s.float) != zero(Float32))
end

BOOLEAN_FROM_INT(s::State) = if !isempty(s.integer)
  push!(s.boolean, pop!(s.integer) != zero(Int32))
end

BOOLEAN_POP(s::State) = pop!(s.boolean)

BOOLEAN_ROT(s::State) = if length(s.boolean) >= 3
  s.boolean[1], s.boolean[3] = s.boolean[3], s.boolean[1]
end

BOOLEAN_SHOVE(s::State) = if !isempty(s.int)
  insert_at!(s.boolean, pop!(s.boolean), pop!(s.int))
end

BOOLEAN_RAND(s::State) = push!(s.boolean, RANDOM_BOOLEAN)

BOOLEAN_STACK_DEPTH(s::State) = push!(s.int, length(s.boolean))

BOOLEAN_SWAP(s::State) = if length(s.boolean) >= 2
  s.boolean[1], s.boolean[2] = s.boolean[2], s.boolean[1]
end

# could tell it which stacks we use?
Push.register("BOOLEAN.=",           BOOLEAN_EQUALS)
Push.register("BOOLEAN.NOT",         BOOLEAN_NOT)
Push.register("BOOLEAN.AND",         BOOLEAN_AND)
Push.register("BOOLEAN.OR",          BOOLEAN_OR)
Push.register("BOOLEAN.DEFINE",      BOOLEAN_DEFINE)
Push.register("BOOLEAN.DUP",         BOOLEAN_DUP)
Push.register("BOOLEAN.FLUSH",       BOOLEAN_FLUSH)
Push.register("BOOLEAN.FROMFLOAT",   BOOLEAN_FROM_FLOAT)
Push.register("BOOLEAN.FROMINT",     BOOLEAN_FROM_INT)
Push.register("BOOLEAN.POP",         BOOLEAN_POP)
Push.register("BOOLEAN.ROT",         BOOLEAN_ROT)
Push.register("BOOLEAN.SHOVE",       BOOLEAN_SHOVE)
Push.register("BOOLEAN.RAND",        BOOLEAN_RAND)
Push.register("BOOLEAN.STACKDEPTH",  BOOLEAN_STACK_DEPTH)
Push.register("BOOLEAN.SWAP",        BOOLEAN_SWAP)