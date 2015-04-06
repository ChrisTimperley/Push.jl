#
# TODO
#
FLOAT_MOD(s::State) = return

FLOAT_MUL(s::State) = if length(s.float) >= 2
  push!(s.float, pop!(s.float) * pop!(s.float))
end

FLOAT_PLUS(s::State) = if length(s.float) >= 2
  push!(s.float, pop!(s.float) + pop!(s.float))
end

FLOAT_SUB(s::State) = if length(s.float) >= 2
  push!(s.float, pop!(s.float) - pop!(s.float))
end

FLOAT_DIV(s::State) = if length(s.float) >= 2
  div = peek(s.float)
  if div != zero(Float32)
    pop!(s.float)
    push!(s.float, pop!(s.float) / div)
  end
end

FLOAT_LT(s::State) = if length(s.float) >= 2
  push!(s.boolean, pop!(s.float) > pop!(s.float))
end

FLOAT_EQ(s::State) = if length(s.float) >= 2
  push!(s.boolean, pop!(s.float) == pop!(s.float))
end

FLOAT_GT(s::State) = if length(s.float) >= 2
  push!(s.boolean, pop!(s.float) < pop!(s.float))
end

FLOAT_COS(s::State) = if !isempty(s.float)
  push!(s.float, cos(pop!(s.float)))
end

FLOAT_DEFINE(s::State) = if !isempty(s.float) && !isempty(s.name)
  register(s, pop!(s.name), pop!(s.float))
end

FLOAT_DUP(s::State) = if !isempty(s.float)
  push!(s.float, peek(s.float))
end

FLOAT_FLUSH(s::State) = clear!(s.float)

FLOAT_FROM_BOOLEAN(s::State) = if !isempty(s.boolean)
  push!(s.float, pop!(s.boolean) ? one(Float32) : zero(Float32))
end

FLOAT_FROM_INTEGER(s::State) = if !isempty(s.integer)
  push!(s.float, convert(Float32, pop!(s.integer)))
end

FLOAT_MAX(s::State) = if length(s.float) >= 2
  push!(s.float, max(pop!(s.float), pop!(s.float)))
end

FLOAT_MIN(s::State) = if length(s.float) >= 2
  push!(s.float, min(pop!(s.float), pop!(s.float)))
end

FLOAT_POP(s::State) = if !isempty(s.float)
  pop!(s.float)
end

#
# TODO
#
FLOAT_RAND(s::State) = return

FLOAT_ROT(s::State) = if length(s.float) >= 3
  s.float[1], s.float[3] = s.float[3], s.float[1]
end

#
# TODO
#
FLOAT_SHOVE(s::State) = return

FLOAT_SIN(s::State) = if !isempty(s.float)
  push!(s.float, sin(pop!(s.float)))
end

FLOAT_STACK_DEPTH(s::State) = push!(s.integer, length(s.float))

FLOAT_SWAP(s::State) = if length(s.float) >= 2
  s.float[1], s.float[2] = s.float[2], s.float[1]
end

FLOAT_TAN(s::State) = if !isempty(s.float)
  push!(s.float, tan(pop!(s.float)))
end

#
# TODO
#
FLOAT_YANK(s::State) = return

#
# TODO
#
FLOAT_YANKDUP(s::State) = return

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