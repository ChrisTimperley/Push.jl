EXEC_EQ(s::State) = if length(s.exec) > 1
  push!(s.boolean, pop!(s.exec) == pop!(s.exec))
end

EXEC_DEFINE(s::State) = if !isempty(s.exec) && !isempty(s.name)
  s.definitions[pop!(s.name)] = deepcopy(pop!(s.exec))
end

EXEC_DO_STAR_COUNT(s::State) = if !isempty(s.integer) && s.integer[end] >= 0 && !isempty(s.exec)
  push!(s.integer, 0, pop!(s.integer) - 1)
  push!(s.exec, pop!(s.exec), Symbol("EXEC.DO*RANGE"))
end

EXEC_DO_STAR_RANGE(s::State) = if length(s.integer) > 1 && !isempty(s.exec)
  dest_idx = pop!(s.integer)
  curr_idx = peek(s.integer)
  if dest_idx != curr_idx
    body = pop!(s.exec)
    curr_idx::Int32 = curr_idx + (dest_idx > curr_idx ? one(Int32) : -one(Int32))
    if !(body isa Symbol)
      body = copy(body)
    end
    push!(s.exec, [curr_idx, dest_idx, Symbol("EXEC.DO*RANGE"), body], body)
  end
end

EXEC_DO_STAR_TIMES(s::State) = if !isempty(s.integer) && s.integer[end] >= 0 && !isempty(s.exec)
  push!(s.integer, 0, pop!(s.integer) - 1)
  push!(s.exec, [Symbol("INTEGER.POP"), pop!(s.exec)], Symbol("EXEC.DO*RANGE"))
end

# What if "EXEC_DUP" is the command being duplicated?
# Should we allow it to be cloned?
EXEC_DUP(s::State) = if !isempty(s.exec)
  push!(s.exec, peek(s.exec))
end

EXEC_FLUSH(s::State) = empty!(s.exec)

EXEC_IF(s::State) = if !isempty(s.boolean) && length(s.exec) >= 2
  a = pop!(s.exec)
  b = pop!(s.exec)
  push!(s.exec, pop!(s.boolean) ? a : b)
end

EXEC_K(s::State) = if length(s.exec) > 1
  s.exec[end] = pop!(s.exec)
end

EXEC_POP(s::State) = pop!(s.exec)

EXEC_ROT(s::State) = if length(s.exec) > 2
  s.exec[end], s.exec[end-1], s.exec[end-2] =
    s.exec[end-1], s.exec[end-2], s.exec[end]
end

EXEC_S(s::State) = if length(s.exec) > 2
  a = pop!(s.exec)
  b = pop!(s.exec)
  c = pop!(s.exec)
  if !(c isa Symbol)
    c = copy(c)
  end
  push!(s.exec, a, c, [b, c])
end

EXEC_SHOVE(s::State) = if !isempty(s.integer) && !isempty(s.exec)
  shove!(s.exec, pop!(s.integer))
end

EXEC_STACK_DEPTH(s::State) = push!(s.integer, length(s.exec))

EXEC_SWAP(s::State) = if length(s.exec) > 1
  s.exec[end], s.exec[end-1] = s.exec[end-1], s.exec[end]
end

EXEC_Y(s::State) = if !isempty(s.exec)
  body = pop!(s.exec)
  push!(s.exec, [Symbol("EXEC.Y"), copy(body)], body)
end

EXEC_YANK(s::State) = if !isempty(s.integer) && !isempty(s.exec)
  yank!(s.exec, pop!(s.integer))
end

EXEC_YANK_DUP(s::State) = if !isempty(s.integer) && !isempty(s.exec)
  yankdup!(s.exec, pop!(s.integer))
end

Push.register("EXEC.=",          EXEC_EQ)
Push.register("EXEC.DEFINE",     EXEC_DEFINE)
Push.register("EXEC.DO*COUNT",   EXEC_DO_STAR_COUNT)
Push.register("EXEC.DO*RANGE",   EXEC_DO_STAR_RANGE)
Push.register("EXEC.DO*TIMES",   EXEC_DO_STAR_TIMES)
Push.register("EXEC.DUP",        EXEC_DUP)
Push.register("EXEC.FLUSH",      EXEC_FLUSH)
Push.register("EXEC.IF",         EXEC_IF)
Push.register("EXEC.K",          EXEC_K)
Push.register("EXEC.POP",        EXEC_POP)
Push.register("EXEC.ROT",        EXEC_ROT)
Push.register("EXEC.S",          EXEC_S)
Push.register("EXEC.SHOVE",      EXEC_SHOVE)
Push.register("EXEC.STACKDEPTH", EXEC_STACK_DEPTH)
Push.register("EXEC.SWAP",       EXEC_SWAP)
Push.register("EXEC.Y",          EXEC_Y)
Push.register("EXEC.YANK",       EXEC_YANK)
Push.register("EXEC.YANKDUP",    EXEC_YANK_DUP)
