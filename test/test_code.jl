require("src/Push.jl")

using Push
using Base.Test

cfg_path = joinpath(dirname(@__FILE__), "configuration/code.cfg")
cfg = Push.load_configuration(cfg_path)

# CODE.=
s = Push.run("(CODE.QUOTE X CODE.QUOTE X CODE.=)", cfg)
@test s.boolean == [true] && isempty(s.code)
s = Push.run("(CODE.QUOTE X CODE.QUOTE Y CODE.=)", cfg)
@test s.boolean == [false] && isempty(s.code)
s = Push.run("(CODE.QUOTE CODE.QUOTE CODE.QUOTE CODE.QUOTE CODE.=)", cfg)
@test s.boolean == [true] && isempty(s.code)

# CODE.APPEND
s = Push.run("(CODE.QUOTE (X Y) CODE.QUOTE (A B) CODE.APPEND)", cfg)
@test s.code == {{:A, :B, :X, :Y}} && isempty(s.name)
s = Push.run("(CODE.QUOTE (X Y) CODE.QUOTE Z CODE.APPEND)", cfg)
@test s.code == {{:Z, :X, :Y}} && isempty(s.name)
s = Push.run("(CODE.QUOTE A CODE.QUOTE B CODE.APPEND)", cfg)
@test s.code == {{:B, :A}} && isempty(s.name)
s = Push.run("(CODE.QUOTE A CODE.APPEND)", cfg)
@test s.code == {{:A}} && isempty(s.name)

# CODE.ATOM
s = Push.run("(CODE.ATOM)", cfg)
@test isempty(s.code) && isempty(s.boolean)
s = Push.run("(CODE.QUOTE 32 CODE.ATOM)", cfg)
@test isempty(s.code) && s.boolean == [true]
s = Push.run("(CODE.QUOTE 32.0 CODE.ATOM)", cfg)
@test isempty(s.code) && s.boolean == [true]
s = Push.run("(CODE.QUOTE X CODE.ATOM)", cfg)
@test isempty(s.code) && s.boolean == [true]
s = Push.run("(CODE.QUOTE FALSE CODE.ATOM)", cfg)
@test isempty(s.code) && s.boolean == [true]
s = Push.run("(CODE.QUOTE (FALSE) CODE.ATOM)", cfg)
@test isempty(s.code) && s.boolean == [false]

# CODE.CAR
s = Push.run("(CODE.QUOTE X CODE.CAR)", cfg)
@test s.code == {:X}
s = Push.run("(CODE.CAR)", cfg)
@test isempty(s.code)
s = Push.run("(CODE.QUOTE X CODE.QUOTE (1 2 3 4 5) CODE.CAR)")
@test s.code == {:X, 1}

# CODE.CDR
s = Push.run("(CODE.CDR)", cfg)
@test isempty(s.code)
s = Push.run("(CODE.QUOTE X CODE.CDR)", cfg)
@test s.code == {{}}
s = Push.run("(CODE.QUOTE (X) CODE.CDR)", cfg)
@test s.code == {{}}
s = Push.run("(CODE.QUOTE (X Y Z) CODE.CDR)", cfg)
@test s.code == {{:Y, :Z}}

# CODE.CONS


# CODE.CONTAINER
# CODE.CONTAINS
# CODE.DEFINE
# CODE.DEFINITION
# CODE.DISCREPANCY
# CODE.DO
# CODE.DO*
# CODE.DO*COUNT
# CODE.DO*RANGE
# CODE.DO*TIMES
# CODE.DUP
# CODE.EXTRACT
# CODE.FLUSH
# CODE.FROMBOOLEAN
# CODE.FROMINTEGER
# CODE.FROMNAME
# CODE.IF
# CODE.INSERT
# CODE.INSTRUCTIONS
# CODE.LENGTH
# CODE.LIST
# CODE.MEMBER
# CODE.NOOP
# CODE.NTH
# CODE.NTHCDR
# CODE.NULL
# CODE.POP
# CODE.POSITION
# CODE.QUOTE
# CODE.RAND
# CODE.ROT
# CODE.SHOVE
# CODE.SIZE
# CODE.STACKDEPTH
# CODE.SUBST
# CODE.SWAP
# CODE.YANK
# CODE.YANKDUP