EXEC_EQ(ctx::Push3Context) = if length(ctx.exec) >= 2
  push!(ctx.boolean, pop!(ctx.exec) === pop!(ctx.exec))
end

#
# TODO
#
EXEC_DEFINE(ctx::Push3Context) = if !isempty(ctx.name) && !isempty(ctx.exec)
  register(ctx, pop!(ctx.name), pop!(ctx.exec)) 
end

#
# TODO
#
EXEC_DO_STAR_COUNT(ctx::Push3Context) = return

#
# TODO
#
EXEC_DO_STAR_RANGE(ctx::Push3Context) = return

#
# TODO
#
EXEC_DO_STAR_TIMES(ctx::Push3Context) = return

# What if "EXEC_DUP" is the command being duplicated?
# Should we allow it to be cloned?
EXEC_DUP(ctx::Push3Context) = if !isempty(ctx.exec)
  push!(ctx.exec, peek(ctx.exec))
end