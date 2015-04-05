BOOLEAN_EQUALS(s::State) = if length(s.boolean) >= 2
  push!(s.boolean, pop!(s.boolean) == pop!(s.boolean))
end

# Don't bother actually popping and pushing. Edit the top of the stack.
BOOLEAN_NOT(s::State) = if !isempty(s.boolean)
  s.boolean[1] = !s.boolean[1]
end

BOOLEAN_AND(s::State) = if length(s.boolean) >= 2
  push!(s.boolean, pop!(s.boolean) && pop!(s.boolean))
end

BOOLEAN_OR(s::State) = if length(s.boolean) >= 2
  push!(s.boolean, pop!(s.boolean) || pop!(s.boolean))
end

BOOLEAN_DEFINE(s::State) = return

BOOLEAN_DUP(s::State) = if !isempty(s.boolean)
  push!(s.boolean, peek(s.boolean))
end

BOOLEAN_FLUSH(s::State) = if !isempty(s.boolean)
  clear!(s.boolean)
end

BOOLEAN_FROM_FLOAT(s::State) = if !isempty(s.float)
  push!(s.boolean, pop!(s.float) != zero(Float32))
end

BOOLEAN_FROM_INT(s::State) = if !isempty(s.int)
  push!(s.boolean, pop!(s.int) != zero(Int32))
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
Push3.register("BOOLEAN.STACKDEPTH",  BOOLEAN_STACK_DEPTH)
Push3.register("BOOLEAN.SWAP",        BOOLEAN_SWAP)