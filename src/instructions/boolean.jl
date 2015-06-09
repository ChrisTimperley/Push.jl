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

BOOLEAN_DEFINE(s::State) = if !isempty(s.boolean) && !isempty(s.name)
  s.definitions[pop!(s.name)] = pop!(s.boolean)
end

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

BOOLEAN_ROT(s::State) = if length(s.boolean) > 2
  s.boolean[end], s.boolean[end-1], s.boolean[end-2] =
    s.boolean[end-1], s.boolean[end-2], s.boolean[end]
end

BOOLEAN_SHOVE(s::State) = if !isempty(s.integer) && !isempty(s.boolean)
  shove!(s.boolean, pop!(s.integer))
end

BOOLEAN_RAND(s::State) = push!(s.boolean, random_bool(s))

BOOLEAN_STACK_DEPTH(s::State) = push!(s.integer, length(s.boolean))

BOOLEAN_SWAP(s::State) = if length(s.boolean) >= 2
  s.boolean[end], s.boolean[end-1] = s.boolean[end-1], s.boolean[end]
end

BOOLEAN_YANK(s::State) = if !isempty(s.integer) && !isempty(s.boolean)
  yank!(s.boolean, pop!(s.integer))
end

BOOLEAN_YANKDUP(s::State) = if !isempty(s.integer) && !isempty(s.boolean)
  yankdup!(s.boolean, pop!(s.integer))
end

BOOLEAN_ERC(s::State) = return

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
Push.register("BOOLEAN.YANK",        BOOLEAN_YANK)
Push.register("BOOLEAN.YANKDUP",     BOOLEAN_YANKDUP)
Push.register("BOOLEAN.ERC",         BOOLEAN_ERC)
