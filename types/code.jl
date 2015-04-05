CODE_EQ(ctx::Push3Context) = if length(ctx.code) >= 2
  push!(ctx.boolean, pop!(ctx.code) === pop!(ctx.code))
end

#
# TODO
#
CODE_APPEND(ctx::Push3Context) = return

#
# TODO
#
CODE_ATOM(ctx::Push3Context) = return

#
# TODO
#
CODE_CAR(ctx::Push3Context) = return

#
# TODO
#
CODE_CDR(ctx::Push3Context) = return

#
# TODO
#
CODE_CONS(ctx::Push3Context) = return

#
# TODO
#
CODE_CONTAINER(ctx::Push3Context) = return

#
# TODO
#
CODE_CONTAINS(ctx::Push3Context) = return

#
# TODO
#
CODE_DEFINE(ctx::Push3Context) = return

#
# TODO
#
CODE_DEFINITION(ctx::Push3Context) = return

#
# TODO
#
CODE_DISCREPANCY(ctx::Push3Context) = return

#
# TODO
#
CODE_DO(ctx::Push3Context) = return

#
# TODO
#
CODE_DO_STAR(ctx::Push3Context) = return

#
# TODO
#
CODE_DO_STAR_COUNT(ctx::Push3Context) = return

#
# TODO
#
CODE_DO_STAR_RANGE(ctx::Push3Context) = return

#
# TODO
#
CODE_DO_STAR_TIMES(ctx::Push3Context) = return

CODE_DUP(ctx::Push3Context) = if !isempty(ctx.code)
  push!(ctx.code, peek(ctx.code))
end

#
# TODO
#
CODE_EXTRACT(ctx::Push3Context) = return

CODE_FLUSH(ctx::Push3Context) = clear!(ctx.code)

#
# TODO
#
CODE_FROM_BOOLEAN(ctx::Push3Context) = if !isempty(ctx.boolean)
  
end

#
# TODO
#
CODE_FROM_FLOAT(ctx::Push3Context) = if !isempty(ctx.float)

end

#
# TODO
#
CODE_FROM_INTEGER(ctx::Push3Context) = if !isempty(ctx.integer)

end

#
# TODO
#
CODE_FROM_NAME(ctx::Push3Context) = if !isempty(ctx.name)

end

CODE_IF(ctx::Push3Context) = if !isempty(ctx.boolean) && length(ctx.code) >= 2
  a = pop!(ctx.boolean)
  b = pop!(ctx.boolean)
  push!(ctx.exec, pop!(ctx.boolean) ? b : a)
end

#
# TODO
#
CODE_INSERT(ctx::Push3Context) = return

#
# TODO
#
CODE_INSTRUCTIONS(ctx::Push3Context) = return

#
# TODO
#
CODE_LENGTH(ctx::Push3Context) = return

#
# TODO
#
CODE_LIST(ctx::Push3Context) = return

#
# TODO
#
CODE_MEMBER(ctx::Push3Context) = return

CODE_NOOP(ctx::Push3Context) = return

#
# TODO
#
CODE_NTH(ctx::Push3Context) = return

#
# TODO
#
CODE_NTH_CDR(ctx::Push3Context) = return

#
# TODO
#
CODE_NULL(ctx::Push3Context) = return

CODE_POP(ctx::Push3Context) = if !isempty(ctx.code)
  pop!(ctx.code)
end

#
# TODO
#
CODE_POSITION(ctx::Push3Context) = return

#
# TODO
#
CODE_QUOTE(ctx::Push3Context) = ctx.flag_quote = true

#
# TODO
#
CODE_RAND(ctx::Push3Context) = return

CODE_ROT(ctx::Push3Context) = if length(ctx.code) >= 3
  ctx.code[1], ctx.code[3] = ctx.code[3], ctx.code[1]
end

#
# TODO
#
CODE_SHOVE(ctx::Push3Context) = return

#
# TODO
#
CODE_SIZE(ctx::Push3Context) = return

#
# TODO
#
CODE_STACK_DEPTH(ctx::Push3Context) = push!(ctx.integer, length(ctx.code))

#
# TODO
#
CODE_SUBST(ctx::Push3Context) = return

CODE_SWAP(ctx::Push3Context) = if length(ctx.code) >= 2
  ctx.code[1], ctx.code[2] = ctx.code[2], ctx.code[1]
end

#
# TODO
#
CODE_YANK(ctx::Push3Context) = return

#
# TODO
#
CODE_YANK_DUP(ctx::Push3Context) = return

Push3.register("CODE.=",                CODE_EQ)
Push3.register("CODE.APPEND",           CODE_APPEND)
Push3.register("CODE.ATOM",             CODE_ATOM)
Push3.register("CODE.CAR",              CODE_CAR)
Push3.register("CODE.CDR",              CODE_CDR)
Push3.register("CODE.CONS",             CODE_CONS)
Push3.register("CODE.CONTAINER",        CODE_CONTAINER)
Push3.register("CODE.CONTAINS",         CODE_CONTAINS)
Push3.register("CODE.DEFINE",           CODE_DEFINE)
Push3.register("CODE.DEFINITION",       CODE_DEFINITION)
Push3.register("CODE.DISCREPANCY",      CODE_DISCREPANCY)
Push3.register("CODE.DO",               CODE_DO)
Push3.register("CODE.DO*",              CODE_DO_STAR)
Push3.register("CODE.DO*COUNT",         CODE_DO_STAR_COUNT)
Push3.register("CODE.DO*RANGE",         CODE_DO_STAR_RANGE)
Push3.register("CODE.DO*TIMES",         CODE_DO_STAR_TIMES)
Push3.register("CODE.DUP",              CODE_DUP)
Push3.register("CODE.EXTRACT",          CODE_EXTRACT)
Push3.register("CODE.FLUSH",            CODE_FLUSH)
Push3.register("CODE.FROMBOOLEAN",      CODE_FROM_BOOLEAN)
Push3.register("CODE.FROMINTEGER",      CODE_FROM_INTEGER)
Push3.register("CODE.FROMNAME",         CODE_FROM_NAME)
Push3.register("CODE.IF",               CODE_IF)
Push3.register("CODE.INSERT",           CODE_INSERT)
Push3.register("CODE.INSTRUCTIONS",     CODE_INSTRUCTIONS)
Push3.register("CODE.LENGTH",           CODE_LENGTH)
Push3.register("CODE.LIST",             CODE_LIST)
Push3.register("CODE.MEMBER",           CODE_MEMBER)
Push3.register("CODE.NOOP",             CODE_NOOP)
Push3.register("CODE.NTH",              CODE_NTH)
Push3.register("CODE.NTHCDR",           CODE_NTH_CDR)
Push3.register("CODE.NULL",             CODE_NULL)
Push3.register("CODE.POP",              CODE_POP)
Push3.register("CODE.POSITION",         CODE_POSITION)
Push3.register("CODE.QUOTE",            CODE_QUOTE)
Push3.register("CODE.RAND",             CODE_RAND)
Push3.register("CODE.ROT",              CODE_ROT)
Push3.register("CODE.SHOVE",            CODE_SHOVE)
Push3.register("CODE.SIZE",             CODE_SIZE)
Push3.register("CODE.STACKDEPTH",       CODE_STACK_DEPTH)
Push3.register("CODE.SUBST",            CODE_SUBST)
Push3.register("CODE.SWAP",             CODE_SWAP)
Push3.register("CODE.YANK",             CODE_YANK)
Push3.register("CODE.YANKDUP",          CODE_YANK_DUP)