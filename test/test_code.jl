using Push
using Test

cfg_path = joinpath(dirname(@__FILE__), "configuration/code.cfg")
cfg = Push.load_configuration(cfg_path)

# CODE.QUOTE
s = Push.run("(CODE.QUOTE X)", cfg)
@test s.code == [:X]
s = Push.run("(CODE.QUOTE -12)", cfg)
@test s.code == [-12]
s = Push.run("(CODE.QUOTE -5.1)", cfg)
@test s.code == [convert(Float32, -5.1)]
s = Push.run("(CODE.QUOTE TRUE)", cfg)
@test s.code == [true]
s = Push.run("(CODE.QUOTE CODE.QUOTE)", cfg)
@test s.code == [Symbol("CODE.QUOTE")]
s = Push.run("(CODE.QUOTE A CODE.QUOTE (X Y Z))", cfg)
@test s.code == [:A, [:X, :Y, :Z]]

# CODE.=
s = Push.run("(CODE.QUOTE X CODE.QUOTE X CODE.=)", cfg)
@test s.boolean == [true] && isempty(s.code)
s = Push.run("(CODE.QUOTE X CODE.QUOTE Y CODE.=)", cfg)
@test s.boolean == [false] && isempty(s.code)
s = Push.run("(CODE.QUOTE CODE.QUOTE CODE.QUOTE CODE.QUOTE CODE.=)", cfg)
@test s.boolean == [true] && isempty(s.code)

# CODE.APPEND
s = Push.run("(CODE.QUOTE (X Y) CODE.QUOTE (A B) CODE.APPEND)", cfg)
@test s.code == [[:A, :B, :X, :Y]] && isempty(s.name)
s = Push.run("(CODE.QUOTE (X Y) CODE.QUOTE Z CODE.APPEND)", cfg)
@test s.code == [[:Z, :X, :Y]] && isempty(s.name)
s = Push.run("(CODE.QUOTE A CODE.QUOTE B CODE.APPEND)", cfg)
@test s.code == [[:B, :A]] && isempty(s.name)
s = Push.run("(CODE.QUOTE A CODE.APPEND)", cfg)
@test s.code == [:A] && isempty(s.name)

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
#
#
# WHAT IS CAR OF AN EMPTY LIST?
#
#
s = Push.run("(CODE.QUOTE X CODE.CAR)", cfg)
@test s.code == [:X]
s = Push.run("(CODE.CAR)", cfg)
@test isempty(s.code)
s = Push.run("(CODE.QUOTE X CODE.QUOTE (1 2 3 4 5) CODE.CAR)", cfg)
@test s.code == [:X, 1]
s = Push.run("(CODE.QUOTE () CODE.CAR)", cfg)
@test s.code == [[]]

# CODE.CDR
s = Push.run("(CODE.CDR)", cfg)
@test isempty(s.code)
s = Push.run("(CODE.QUOTE X CODE.CDR)", cfg)
@test s.code == [[]]
s = Push.run("(CODE.QUOTE (X) CODE.CDR)", cfg)
@test s.code == [[]]
s = Push.run("(CODE.QUOTE (X Y Z) CODE.CDR)", cfg)
@test s.code == [[:Y, :Z]]

# CODE.CONS
s = Push.run("(CODE.QUOTE Z CODE.QUOTE (X Y) CODE.CONS)", cfg)
@test s.code == [[:Z, :X, :Y]]
s = Push.run("(CODE.QUOTE Z CODE.CONS)", cfg)
@test s.code == [:Z]
s = Push.run("(CODE.QUOTE (Z) CODE.QUOTE (X Y) CODE.CONS)", cfg)
@test s.code == [[[:Z], :X, :Y]]
s = Push.run("(CODE.QUOTE B CODE.QUOTE A CODE.CONS)", cfg)
@test s.code == [[:B, :A]]
s = Push.run("(CODE.QUOTE (B) CODE.QUOTE A CODE.CONS)", cfg)
@test s.code == [[[:B], :A]]

# CODE.DUP
s = Push.run("(CODE.DUP)", cfg)
@test isempty(s.code)
s = Push.run("(CODE.QUOTE X CODE.DUP)", cfg)
@test s.code == [:X, :X]

# CODE.EXTRACT
s = Push.run("(CODE.EXTRACT)", cfg)
@test isempty(s.code)
s = Push.run("(CODE.QUOTE (A B C D) CODE.EXTRACT)", cfg)
@test s.code == [[:A, :B, :C, :D]]
s = Push.run("(0 CODE.QUOTE (A B C D) CODE.EXTRACT)", cfg)
@test s.code == [[:A, :B, :C, :D]]
s = Push.run("(1 CODE.QUOTE (A B C D) CODE.EXTRACT)", cfg)
@test s.code == [:A]
s = Push.run("(2 CODE.QUOTE (A B C D) CODE.EXTRACT)", cfg)
@test s.code == [:B]
s = Push.run("(3 CODE.QUOTE (A B C D) CODE.EXTRACT)", cfg)
@test s.code == [:C]
s = Push.run("(4 CODE.QUOTE (A B C D) CODE.EXTRACT)", cfg)
@test s.code == [:D]
s = Push.run("(5 CODE.QUOTE (A B C D) CODE.EXTRACT)", cfg)
@test s.code == [[:A, :B, :C, :D]]
s = Push.run("(6 CODE.QUOTE (A B C D) CODE.EXTRACT)", cfg)
@test s.code == [:A]
s = Push.run("(-1 CODE.QUOTE (A B C D) CODE.EXTRACT)", cfg)
@test s.code == [:A]
s = Push.run("(-2 CODE.QUOTE (A B C D) CODE.EXTRACT)", cfg)
@test s.code == [:B]
s = Push.run("(-5 CODE.QUOTE (A B C D) CODE.EXTRACT)", cfg)
@test s.code == [[:A, :B, :C, :D]]
s = Push.run("(-6 CODE.QUOTE (A B C D) CODE.EXTRACT)", cfg)
@test s.code == [:A]
s = Push.run("(0 CODE.QUOTE A CODE.EXTRACT)", cfg)
@test s.code == [:A]
s = Push.run("(1 CODE.QUOTE ((A B C) (D E) (F)) CODE.EXTRACT)", cfg)
@test s.code == [[:A, :B, :C]]
s = Push.run("(2 CODE.QUOTE ((A B C) (D E) (F)) CODE.EXTRACT)", cfg)
@test s.code == [:A]
s = Push.run("(6 CODE.QUOTE ((A B C) (D E) (F)) CODE.EXTRACT)", cfg)
@test s.code == [:D]

# CODE.FLUSH
s = Push.run("(CODE.QUOTE 76 CODE.QUOTE (A B C D) CODE.FLUSH)", cfg)
@test s.code == []
s = Push.run("(CODE.FLUSH)", cfg)
@test s.code == []

# CODE.FROMBOOLEAN
s = Push.run("(A CODE.FROMBOOLEAN)", cfg)
@test s.name == [:A] && isempty(s.code)
s = Push.run("(FALSE FALSE TRUE CODE.FROMBOOLEAN)", cfg)
@test s.code == [true] && s.boolean == [false, false]
s = Push.run("(TRUE TRUE FALSE CODE.FROMBOOLEAN)", cfg)
@test s.code == [false] && s.boolean == [true, true]

# CODE.FROMINTEGER
s = Push.run("(7 CODE.FROMINTEGER)", cfg)
@test s.code == [7] && isempty(s.integer)
s = Push.run("(1 2 3 CODE.FROMINTEGER)", cfg)
@test s.integer == [1, 2] && s.code == [3]
s = Push.run("(3 2 1 CODE.FROMINTEGER)", cfg)
@test s.integer == [3, 2] && s.code == [1]

# CODE.FROMNAME
s = Push.run("(CODE.FROMNAME)", cfg)
@test isempty(s.code)
s = Push.run("(NAME.QUOTE ADD CODE.FROMNAME)", cfg)
@test s.code == [:ADD] && isempty(s.name)

# CODE.IF
s = Push.run("(CODE.QUOTE X CODE.QUOTE Y CODE.IF)", cfg)
@test s.code == [:X, :Y]
s = Push.run("(TRUE CODE.QUOTE X CODE.IF)", cfg)
@test s.code == [:X] && s.boolean == [true]
s = Push.run("(TRUE CODE.QUOTE (A B C) CODE.QUOTE (X Y Z) CODE.IF)", cfg)
@test s.name == [:A, :B, :C] && isempty(s.code) && isempty(s.boolean)
s = Push.run("(FALSE CODE.QUOTE (A B C) CODE.QUOTE (X Y Z) CODE.IF)", cfg)
@test s.name == [:X, :Y, :Z] && isempty(s.code) && isempty(s.boolean)

# CODE.LENGTH
s = Push.run("(CODE.LENGTH)", cfg)
@test isempty(s.integer)
s = Push.run("(CODE.QUOTE X CODE.LENGTH)", cfg)
@test s.integer == [1]
s = Push.run("(CODE.QUOTE (X) CODE.LENGTH)", cfg)
@test s.integer == [1]
s = Push.run("(CODE.QUOTE (X Y Z) CODE.LENGTH)", cfg)
@test s.integer == [3]
s = Push.run("(CODE.QUOTE ((A B C) D E) CODE.LENGTH)", cfg)
@test s.integer == [3]

# CODE.LIST
s = Push.run("(CODE.QUOTE A CODE.LIST)", cfg)
@test s.code == [:A]
s = Push.run("(CODE.QUOTE Z CODE.QUOTE A CODE.QUOTE B CODE.LIST)", cfg)
@test s.code == [:Z, [:B, :A]]
s = Push.run("(CODE.QUOTE Z CODE.QUOTE (1 2 3 4) CODE.QUOTE (A B C) CODE.LIST)", cfg)
@test s.code == [:Z, [[:A, :B, :C], [1, 2, 3, 4]]]
s = Push.run("(CODE.QUOTE Z CODE.QUOTE (1 2 3 4) CODE.QUOTE A CODE.LIST)", cfg)
@test s.code == [:Z, [:A, [1, 2, 3, 4]]]

# CODE.NOOP
s = Push.run("(CODE.NOOP)", cfg)
@test isempty(s.code) && isempty(s.boolean) && isempty(s.integer) && isempty(s.float) && isempty(s.name) && isempty(s.exec)
s = Push.run("(1 CODE.NOOP 5)", cfg)
@test isempty(s.code) && isempty(s.boolean) && s.integer == [1, 5] && isempty(s.float) && isempty(s.name) && isempty(s.exec)

# CODE.NTH
s = Push.run("(CODE.NTH)", cfg)
@test isempty(s.code)
s = Push.run("(0 CODE.QUOTE X CODE.NTH)", cfg)
@test s.code == [:X]
s = Push.run("(919 CODE.QUOTE X CODE.NTH)", cfg)
@test s.code == [:X]
s = Push.run("(98 CODE.QUOTE () CODE.NTH)", cfg)
@test s.code == [[]]
s = Push.run("(CODE.QUOTE (1 2 3) CODE.NTH)", cfg)
@test s.code == [[1, 2, 3]]
s = Push.run("(0 CODE.QUOTE (1 2 3) CODE.NTH)", cfg)
@test s.code == [1]
s = Push.run("(1 CODE.QUOTE (1 2 3) CODE.NTH)", cfg)
@test s.code == [2]
s = Push.run("(2 CODE.QUOTE (1 2 3) CODE.NTH)", cfg)
@test s.code == [3]
s = Push.run("(3 CODE.QUOTE (1 2 3) CODE.NTH)", cfg)
@test s.code == [1]
s = Push.run("(-1 CODE.QUOTE (1 2 3) CODE.NTH)", cfg)
@test s.code == [2]

# CODE.NULL
s = Push.run("(CODE.NULL)", cfg)
@test isempty(s.code) && isempty(s.boolean)
s = Push.run("(CODE.QUOTE () CODE.NULL)", cfg)
@test isempty(s.code) && s.boolean == [true]
s = Push.run("(CODE.QUOTE (1 2 3) CODE.NULL)", cfg)
@test isempty(s.code) && s.boolean == [false]
s = Push.run("(CODE.QUOTE 1 CODE.NULL)", cfg)
@test isempty(s.code) && s.boolean == [false]

# CODE.POP
s = Push.run("(CODE.QUOTE X CODE.QUOTE Y CODE.POP)", cfg)
@test s.code == [:X]

# CODE.ROT
s = Push.run("(CODE.QUOTE A CODE.QUOTE B CODE.ROT)", cfg)
@test s.code == [:A, :B]
s = Push.run("(CODE.QUOTE Z CODE.QUOTE A CODE.QUOTE B CODE.QUOTE C CODE.ROT)", cfg)
@test s.code == [:Z, :C, :A, :B]

# CODE.SIZE
s = Push.run("(CODE.QUOTE X CODE.SIZE)", cfg)
@test isempty(s.code) && s.integer == [1]
s = Push.run("(CODE.QUOTE (X) CODE.SIZE)", cfg)
@test isempty(s.code) && s.integer == [2]
s = Push.run("(CODE.QUOTE (X Y Z) CODE.SIZE)", cfg)
@test isempty(s.code) && s.integer == [4]
s = Push.run("(CODE.QUOTE ((X) (Y Z)) CODE.SIZE)", cfg)
@test isempty(s.code) && s.integer == [6]
s = Push.run("(CODE.SIZE)", cfg)
@test isempty(s.code) && isempty(s.integer)

# CODE.STACKDEPTH
s = Push.run("(CODE.STACKDEPTH)", cfg)
@test s.integer == [0]
s = Push.run("(CODE.QUOTE X CODE.STACKDEPTH)", cfg)
@test s.integer == [1]
s = Push.run("(CODE.QUOTE X CODE.QUOTE 3 CODE.STACKDEPTH)", cfg)
@test s.integer == [2]

# CODE.SWAP
s = Push.run("(CODE.QUOTE A CODE.SWAP)", cfg)
@test s.code == [:A]
s = Push.run("(CODE.QUOTE Z CODE.QUOTE A CODE.QUOTE B CODE.SWAP)", cfg)
@test s.code == [:Z, :B, :A]

# CODE.DO
s = Push.run("((CODE.QUOTE CODE.= CODE.DUP) CODE.DO)", cfg)
@test isempty(s.code) && s.boolean == [true]
s = Push.run("(CODE.QUOTE (X Y Z) CODE.DO)", cfg)
@test isempty(s.code) && s.name == [:X, :Y, :Z]
s = Push.run("(CODE.QUOTE (1 2 3 INTEGER.+ INTEGER.+) CODE.DO)", cfg)
@test isempty(s.code) && s.integer == [6]

# CODE.DO*
s = Push.run("((CODE.DUP CODE.QUOTE CODE.=) CODE.DO*)", cfg)
@test isempty(s.code) && isempty(s.boolean)
s = Push.run("(CODE.QUOTE (X Y Z) CODE.DO*)", cfg)
@test isempty(s.code) && s.name == [:X, :Y, :Z]
s = Push.run("(CODE.QUOTE (1 2 3 INTEGER.+ INTEGER.+) CODE.DO*)", cfg)
@test isempty(s.code) && s.integer == [6]
s = Push.run("(CODE.QUOTE (CODE.STACKDEPTH) CODE.DO*)", cfg)
@test isempty(s.code) && s.integer == [0]

# CODE.DO*RANGE
s = Push.run("(CODE.QUOTE (X) CODE.DO*RANGE)", cfg)
@test s.code == [[:X]] && isempty(s.name)
s = Push.run("(0 CODE.QUOTE (X) CODE.DO*RANGE)", cfg)
@test s.code == [[:X]] && isempty(s.name) && s.integer == [0]
s = Push.run("(0 4 CODE.QUOTE (X) CODE.DO*RANGE)", cfg)
@test s.name == [:X, :X, :X, :X, :X]

# CODE.DO*COUNT
s = Push.run("(CODE.QUOTE (2 INTEGER.*) CODE.DO*COUNT)", cfg)
@test s.code == [[2, Symbol("INTEGER.*")]] && isempty(s.integer)
s = Push.run("(6 CODE.QUOTE (2 INTEGER.*) CODE.DO*COUNT)", cfg)
@test s.integer == [0, 2, 4, 6, 8, 10]

# CODE.DO*TIMES
s = Push.run("(CODE.QUOTE (INTEGER.DUP) CODE.DO*TIMES)", cfg)
@test s.code == [[Symbol("INTEGER.DUP")]] && isempty(s.integer)
s = Push.run("(6 CODE.QUOTE (INTEGER.DUP) CODE.DO*TIMES)", cfg)
@test isempty(s.code) && isempty(s.integer)
s = Push.run("(5 CODE.QUOTE (X) CODE.DO*TIMES)", cfg)
@test s.name == [:X, :X, :X, :X, :X]
s = Push.run("(0 5 CODE.QUOTE (1 INTEGER.+) CODE.DO*TIMES)", cfg)
@test isempty(s.code) && s.integer == [5]
s = Push.run("(0 5 CODE.QUOTE (INTEGER.DUP 1 INTEGER.+) CODE.DO*TIMES)", cfg)
@test isempty(s.code) && s.integer == [0, 1, 2, 3, 4, 5]

# CODE.NTHCDR
s = Push.run("(CODE.QUOTE (A B C) CODE.NTHCDR)", cfg)
@test s.code == [[:A, :B, :C]]
s = Push.run("(0 CODE.QUOTE () CODE.NTHCDR)", cfg)
@test s.code == [[]] && isempty(s.integer)
s = Push.run("(10 CODE.QUOTE X CODE.NTHCDR)", cfg)
@test s.code == [[]] && isempty(s.integer)
s = Push.run("(0 CODE.QUOTE (A B C D E) CODE.NTHCDR)", cfg)
@test s.code == [[:B, :C, :D, :E]] && isempty(s.integer)
s = Push.run("(-1 CODE.QUOTE (A B C D E) CODE.NTHCDR)", cfg)
@test s.code == [[:C, :D, :E]] && isempty(s.integer)
s = Push.run("(3 CODE.QUOTE (A B C D E) CODE.NTHCDR)", cfg)
@test s.code == [[:E]] && isempty(s.integer)
s = Push.run("(-3 CODE.QUOTE (A B C D E) CODE.NTHCDR)", cfg)
@test s.code == [[:E]] && isempty(s.integer)
s = Push.run("(4 CODE.QUOTE (A B C D E) CODE.NTHCDR)", cfg)
@test s.code == [[]] && isempty(s.integer)
s = Push.run("(-4 CODE.QUOTE (A B C D E) CODE.NTHCDR)", cfg)
@test s.code == [[]] && isempty(s.integer)
s = Push.run("(5 CODE.QUOTE (A B C D E) CODE.NTHCDR)", cfg)
@test s.code == [[:B, :C, :D, :E]] && isempty(s.integer)
s = Push.run("(-5 CODE.QUOTE (A B C D E) CODE.NTHCDR)", cfg)
@test s.code == [[:B, :C, :D, :E]] && isempty(s.integer)

# CODE.SHOVE
s = Push.run("(CODE.QUOTE A CODE.QUOTE B CODE.QUOTE C CODE.QUOTE D CODE.SHOVE)", cfg)
@test s.code == [:A, :B, :C, :D]
s = Push.run("(-98 CODE.QUOTE A CODE.QUOTE B CODE.QUOTE C CODE.QUOTE D CODE.SHOVE)", cfg)
@test s.code == [:A, :B, :C, :D]
s = Push.run("(0 CODE.QUOTE A CODE.QUOTE B CODE.QUOTE C CODE.QUOTE D CODE.SHOVE)", cfg)
@test s.code == [:A, :B, :C, :D]
s = Push.run("(1 CODE.QUOTE A CODE.QUOTE B CODE.QUOTE C CODE.QUOTE D CODE.SHOVE)", cfg)
@test s.code == [:A, :B, :D, :C]
s = Push.run("(2 CODE.QUOTE A CODE.QUOTE B CODE.QUOTE C CODE.QUOTE D CODE.SHOVE)", cfg)
@test s.code == [:A, :D, :B, :C]
s = Push.run("(3 CODE.QUOTE A CODE.QUOTE B CODE.QUOTE C CODE.QUOTE D CODE.SHOVE)", cfg)
@test s.code == [:D, :A, :B, :C]
s = Push.run("(78 CODE.QUOTE A CODE.QUOTE B CODE.QUOTE C CODE.QUOTE D CODE.SHOVE)", cfg)
@test s.code == [:D, :A, :B, :C]

# CODE.YANK
s = Push.run("(CODE.QUOTE A CODE.QUOTE B CODE.QUOTE C CODE.QUOTE D CODE.YANK)", cfg)
@test s.code == [:A, :B, :C, :D]
s = Push.run("(0 CODE.QUOTE A CODE.QUOTE B CODE.QUOTE C CODE.QUOTE D CODE.YANK)", cfg)
@test s.code == [:A, :B, :C, :D]
s = Push.run("(-871 CODE.QUOTE A CODE.QUOTE B CODE.QUOTE C CODE.QUOTE D CODE.YANK)", cfg)
@test s.code == [:A, :B, :C, :D]
s = Push.run("(1 CODE.QUOTE A CODE.QUOTE B CODE.QUOTE C CODE.QUOTE D CODE.YANK)", cfg)
@test s.code == [:A, :B, :D, :C]
s = Push.run("(2 CODE.QUOTE A CODE.QUOTE B CODE.QUOTE C CODE.QUOTE D CODE.YANK)", cfg)
@test s.code == [:A, :C, :D, :B]
s = Push.run("(3 CODE.QUOTE A CODE.QUOTE B CODE.QUOTE C CODE.QUOTE D CODE.YANK)", cfg)
@test s.code == [:B, :C, :D, :A]
s = Push.run("(78 CODE.QUOTE A CODE.QUOTE B CODE.QUOTE C CODE.QUOTE D CODE.YANK)", cfg)
@test s.code == [:B, :C, :D, :A]

# CODE.YANKDUP
s = Push.run("(CODE.QUOTE A CODE.QUOTE B CODE.QUOTE C CODE.QUOTE D CODE.YANKDUP)", cfg)
@test s.code == [:A, :B, :C, :D]
s = Push.run("(0 CODE.QUOTE A CODE.QUOTE B CODE.QUOTE C CODE.QUOTE D CODE.YANKDUP)", cfg)
@test s.code == [:A, :B, :C, :D, :D]
s = Push.run("(-871 CODE.QUOTE A CODE.QUOTE B CODE.QUOTE C CODE.QUOTE D CODE.YANKDUP)", cfg)
@test s.code == [:A, :B, :C, :D, :D]
s = Push.run("(1 CODE.QUOTE A CODE.QUOTE B CODE.QUOTE C CODE.QUOTE D CODE.YANKDUP)", cfg)
@test s.code == [:A, :B, :C, :D, :C]
s = Push.run("(2 CODE.QUOTE A CODE.QUOTE B CODE.QUOTE C CODE.QUOTE D CODE.YANKDUP)", cfg)
@test s.code == [:A, :B, :C, :D, :B]
s = Push.run("(3 CODE.QUOTE A CODE.QUOTE B CODE.QUOTE C CODE.QUOTE D CODE.YANKDUP)", cfg)
@test s.code == [:A, :B, :C, :D, :A]
s = Push.run("(78 CODE.QUOTE A CODE.QUOTE B CODE.QUOTE C CODE.QUOTE D CODE.YANKDUP)", cfg)
@test s.code == [:A, :B, :C, :D, :A]

# CODE.INSERT
# Pushes the result of inserting the second item of the CODE stack into the
# first item, at the position indexed by the item at the top of the INTEGER
# stack. Indexing is computed as in CODE.EXTRACT.
s = Push.run("(CODE.QUOTE D CODE.QUOTE (A B C) CODE.INSERT)", cfg)
@test s.code == [:D, [:A, :B, :C]]
s = Push.run("(0 CODE.QUOTE D CODE.QUOTE (A B C) CODE.INSERT)", cfg)
@test s.code == [:D] && isempty(s.integer)
s = Push.run("(1 CODE.QUOTE X CODE.QUOTE ((A B C) (D E) (F)) CODE.INSERT)", cfg)
@test s.code == [[:X, [:D, :E], [:F]]] && isempty(s.integer)
s = Push.run("(-1 CODE.QUOTE X CODE.QUOTE ((A B C) (D E) (F)) CODE.INSERT)", cfg)
@test s.code == [[:X, [:D, :E], [:F]]] && isempty(s.integer)
s = Push.run("(2 CODE.QUOTE X CODE.QUOTE ((A B C) (D E) (F)) CODE.INSERT)", cfg)
@test s.code == [[[:X, :B, :C], [:D, :E], [:F]]] && isempty(s.integer)
s = Push.run("(-2 CODE.QUOTE X CODE.QUOTE ((A B C) (D E) (F)) CODE.INSERT)", cfg)
@test s.code == [[[:X, :B, :C], [:D, :E], [:F]]] && isempty(s.integer)
s = Push.run("(5 CODE.QUOTE X CODE.QUOTE ((A B C) (D E) (F)) CODE.INSERT)", cfg)
@test s.code == [[[:A, :B, :C], :X, [:F]]] && isempty(s.integer)
s = Push.run("(-5 CODE.QUOTE X CODE.QUOTE ((A B C) (D E) (F)) CODE.INSERT)", cfg)
@test s.code == [[[:A, :B, :C], :X, [:F]]] && isempty(s.integer)
s = Push.run("(4 CODE.QUOTE X CODE.QUOTE (A B C) CODE.INSERT)", cfg)
@test s.code == [:X] && isempty(s.integer)
s = Push.run("(6 CODE.QUOTE X CODE.QUOTE (A B C) CODE.INSERT)", cfg)
@test s.code == [[:A, :X, :C]] && isempty(s.integer)
s = Push.run("(-6 CODE.QUOTE X CODE.QUOTE (A B C) CODE.INSERT)", cfg)
@test s.code == [[:A, :X, :C]] && isempty(s.integer)

# CODE.CONTAINER
# Pushes the "container" of the 2nd CODE stack item within the first CODE
# stack item onto the CODE stack. If second item contains the first
# anywhere (i.e. in any nested list) then the container is the smallest
# sub-list that contains but is not equal to the first instance.
s = Push.run("(CODE.QUOTE X CODE.QUOTE (A B C) CODE.CONTAINER)", cfg)
@test s.code == [[]]
s = Push.run("(CODE.QUOTE X CODE.QUOTE (X A B) CODE.CONTAINER)", cfg)
@test s.code == [[:X, :A, :B]]
s = Push.run("(CODE.QUOTE X CODE.QUOTE (A ((B C) X D) E) CODE.CONTAINER)", cfg)
@test s.code == [[[:B, :C], :X, :D]]
s = Push.run("(CODE.QUOTE X CODE.QUOTE ((A X) B C X) CODE.CONTAINER)", cfg)
@test s.code == [[:A, :X]]

# CODE.DISCREPANCY
s = Push.run("(CODE.QUOTE X CODE.QUOTE X CODE.DISCREPANCY)", cfg)
@test s.integer == [0]
s = Push.run("(CODE.QUOTE X CODE.QUOTE Y CODE.DISCREPANCY)", cfg)
@test s.integer == [2]
s = Push.run("(CODE.QUOTE (X Y Z) CODE.QUOTE (X Y A B) CODE.DISCREPANCY)", cfg)
@test s.integer == [3]

# CODE.MEMBER
s = Push.run("(CODE.QUOTE (A B C) CODE.MEMBER)", cfg)
@test s.code == [[:A, :B, :C]] && isempty(s.boolean)
s = Push.run("(CODE.QUOTE A CODE.QUOTE (A B C) CODE.MEMBER)", cfg)
@test isempty(s.code) && s.boolean == [true]
s = Push.run("(CODE.QUOTE (A) CODE.QUOTE (A B C) CODE.MEMBER)", cfg)
@test isempty(s.code) && s.boolean == [false]
s = Push.run("(CODE.QUOTE A CODE.QUOTE B CODE.MEMBER)", cfg)
@test isempty(s.code) && s.boolean == [false]
s = Push.run("(CODE.QUOTE A CODE.QUOTE A CODE.MEMBER)", cfg)
@test isempty(s.code) && s.boolean == [true]
s = Push.run("(CODE.QUOTE A CODE.QUOTE ((A) B C) CODE.MEMBER)", cfg)
@test isempty(s.code) && s.boolean == [false]

# CODE.CONTAINS
s = Push.run("(CODE.QUOTE (1 2 3) CODE.QUOTE 1 CODE.CONTAINS)", cfg)
@test isempty(s.code) && s.boolean == [true]
s = Push.run("(CODE.QUOTE (1 2 3) CODE.QUOTE 4 CODE.CONTAINS)", cfg)
@test isempty(s.code) && s.boolean == [false]
s = Push.run("(CODE.QUOTE 1 CODE.QUOTE 1 CODE.CONTAINS)", cfg)
@test isempty(s.code) && s.boolean == [false]
s = Push.run("(CODE.QUOTE () CODE.QUOTE 1 CODE.CONTAINS)", cfg)
@test isempty(s.code) && s.boolean == [false]
s = Push.run("(CODE.QUOTE () CODE.QUOTE () CODE.CONTAINS)", cfg)
@test isempty(s.code) && s.boolean == [false]
s = Push.run("(CODE.QUOTE 1 CODE.QUOTE () CODE.CONTAINS)", cfg)
@test isempty(s.code) && s.boolean == [false]
s = Push.run("(CODE.QUOTE () CODE.QUOTE () CODE.CONTAINS)", cfg)
@test isempty(s.code) && s.boolean == [false]
s = Push.run("(CODE.QUOTE ((1 2) 3) CODE.QUOTE (1 2) CODE.CONTAINS)", cfg)
@test isempty(s.code) && s.boolean == [true]
s = Push.run("(CODE.QUOTE (((2 1) 9 8) 2 3) CODE.QUOTE 1 CODE.CONTAINS)", cfg)
@test isempty(s.code) && s.boolean == [true]

# CODE.SUBST
# -- LEFT OUT FOR NOW

# CODE.RAND

# CODE.POSITION
# Does this operate like EXTRACT, or like MEMBER?

# CODE.INSTRUCTIONS

# CODE.DEFINE
s = Push.run("(ADD CODE.QUOTE (5 3 INTEGER.+) CODE.DEFINE ADD)", cfg)
@test isempty(s.code) && isempty(s.name) && s.integer == [8]

# CODE.DEFINITION
