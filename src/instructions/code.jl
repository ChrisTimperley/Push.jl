CODE_EQ(s::State) = if length(s.code) >= 2
  push!(s.boolean, pop!(s.code) === pop!(s.code))
end

#
# TODO
#
CODE_APPEND(s::State) = return

#
# TODO
#
CODE_ATOM(s::State) = return

#
# TODO
#
CODE_CAR(s::State) = return

#
# TODO
#
CODE_CDR(s::State) = return

#
# TODO
#
CODE_CONS(s::State) = return

#
# TODO
#
CODE_CONTAINER(s::State) = return

#
# TODO
#
CODE_CONTAINS(s::State) = return

#
# TODO
#
CODE_DEFINE(s::State) = return

#
# TODO
#
CODE_DEFINITION(s::State) = return

#
# TODO
#
CODE_DISCREPANCY(s::State) = return

#
# TODO
#
CODE_DO(s::State) = return

#
# TODO
#
CODE_DO_STAR(s::State) = return

#
# TODO
#
CODE_DO_STAR_COUNT(s::State) = return

#
# TODO
#
CODE_DO_STAR_RANGE(s::State) = return

#
# TODO
#
CODE_DO_STAR_TIMES(s::State) = return

CODE_DUP(s::State) = if !isempty(s.code)
  push!(s.code, peek(s.code))
end

#
# TODO
#
CODE_EXTRACT(s::State) = return

CODE_FLUSH(s::State) = empty!(s.code)

#
# TODO
#
CODE_FROM_BOOLEAN(s::State) = if !isempty(s.boolean)
  
end

#
# TODO
#
CODE_FROM_FLOAT(s::State) = if !isempty(s.float)

end

#
# TODO
#
CODE_FROM_INTEGER(s::State) = if !isempty(s.integer)

end

#
# TODO
#
CODE_FROM_NAME(s::State) = if !isempty(s.name)

end

CODE_IF(s::State) = if !isempty(s.boolean) && length(s.code) >= 2
  a = pop!(s.boolean)
  b = pop!(s.boolean)
  push!(s.exec, pop!(s.boolean) ? b : a)
end

#
# TODO
#
CODE_INSERT(s::State) = return

#
# TODO
#
CODE_INSTRUCTIONS(s::State) = return

#
# TODO
#
CODE_LENGTH(s::State) = return

#
# TODO
#
CODE_LIST(s::State) = return

#
# TODO
#
CODE_MEMBER(s::State) = return

CODE_NOOP(s::State) = return

#
# TODO
#
CODE_NTH(s::State) = return

#
# TODO
#
CODE_NTH_CDR(s::State) = return

#
# TODO
#
CODE_NULL(s::State) = return

CODE_POP(s::State) = !isempty(s.code) && pop!(s.code)

#
# TODO
#
CODE_POSITION(s::State) = return

#
# TODO
#
CODE_QUOTE(s::State) = s.flag_quote = true

#
# TODO
#
CODE_RAND(s::State) = return

CODE_ROT(s::State) = if length(s.code) >= 3
  s.code[end], s.code[end-2] = s.code[end-2], s.code[end]
end

#
# TODO
#
CODE_SHOVE(s::State) = return

#
# TODO
#
CODE_SIZE(s::State) = return

#
# TODO
#
CODE_STACK_DEPTH(s::State) = push!(s.integer, length(s.code))

#
# TODO
#
CODE_SUBST(s::State) = return

CODE_SWAP(s::State) = if length(s.code) >= 2
  s.code[1], s.code[2] = s.code[2], s.code[1]
end

#
# TODO
#
CODE_YANK(s::State) = return

#
# TODO
#
CODE_YANK_DUP(s::State) = return

Push.register("CODE.=",                CODE_EQ)
Push.register("CODE.APPEND",           CODE_APPEND)
Push.register("CODE.ATOM",             CODE_ATOM)
Push.register("CODE.CAR",              CODE_CAR)
Push.register("CODE.CDR",              CODE_CDR)
Push.register("CODE.CONS",             CODE_CONS)
Push.register("CODE.CONTAINER",        CODE_CONTAINER)
Push.register("CODE.CONTAINS",         CODE_CONTAINS)
Push.register("CODE.DEFINE",           CODE_DEFINE)
Push.register("CODE.DEFINITION",       CODE_DEFINITION)
Push.register("CODE.DISCREPANCY",      CODE_DISCREPANCY)
Push.register("CODE.DO",               CODE_DO)
Push.register("CODE.DO*",              CODE_DO_STAR)
Push.register("CODE.DO*COUNT",         CODE_DO_STAR_COUNT)
Push.register("CODE.DO*RANGE",         CODE_DO_STAR_RANGE)
Push.register("CODE.DO*TIMES",         CODE_DO_STAR_TIMES)
Push.register("CODE.DUP",              CODE_DUP)
Push.register("CODE.EXTRACT",          CODE_EXTRACT)
Push.register("CODE.FLUSH",            CODE_FLUSH)
Push.register("CODE.FROMBOOLEAN",      CODE_FROM_BOOLEAN)
Push.register("CODE.FROMINTEGER",      CODE_FROM_INTEGER)
Push.register("CODE.FROMNAME",         CODE_FROM_NAME)
Push.register("CODE.IF",               CODE_IF)
Push.register("CODE.INSERT",           CODE_INSERT)
Push.register("CODE.INSTRUCTIONS",     CODE_INSTRUCTIONS)
Push.register("CODE.LENGTH",           CODE_LENGTH)
Push.register("CODE.LIST",             CODE_LIST)
Push.register("CODE.MEMBER",           CODE_MEMBER)
Push.register("CODE.NOOP",             CODE_NOOP)
Push.register("CODE.NTH",              CODE_NTH)
Push.register("CODE.NTHCDR",           CODE_NTH_CDR)
Push.register("CODE.NULL",             CODE_NULL)
Push.register("CODE.POP",              CODE_POP)
Push.register("CODE.POSITION",         CODE_POSITION)
Push.register("CODE.QUOTE",            CODE_QUOTE)
Push.register("CODE.RAND",             CODE_RAND)
Push.register("CODE.ROT",              CODE_ROT)
Push.register("CODE.SHOVE",            CODE_SHOVE)
Push.register("CODE.SIZE",             CODE_SIZE)
Push.register("CODE.STACKDEPTH",       CODE_STACK_DEPTH)
Push.register("CODE.SUBST",            CODE_SUBST)
Push.register("CODE.SWAP",             CODE_SWAP)
Push.register("CODE.YANK",             CODE_YANK)
Push.register("CODE.YANKDUP",          CODE_YANK_DUP)