using Push
using Test

cfg_path = joinpath(dirname(@__FILE__), "configuration/exec.cfg")
cfg = Push.load_configuration(cfg_path)

# EQUALS.
# What are the semantics of comparison on the CODE stack?
s = Push.run("(EXEC.= 3 3)", cfg)
@test s.boolean == [true]
s = Push.run("(EXEC.= 3 3.0)", cfg)
@test s.boolean == [true] # Should this be true or false?
s = Push.run("(EXEC.= 3)", cfg)
@test s.boolean == []

# EXEC.DUP
s = Push.run("(EXEC.DUP 3 INTEGER.+)", cfg)
@test s.integer == [6]

# EXEC.FLUSH
s = Push.run("(EXEC.FLUSH TRUE FALSE 3 6)", cfg)
@test isempty(s.integer) && isempty(s.boolean)

# EXEC.POP
s = Push.run("(EXEC.POP 5 2 INTEGER.+)", cfg)
@test s.integer == [2]
s = Push.run("(EXEC.POP EXEC.POP 3)", cfg)
@test s.integer == [3]
s = Push.run("(EXEC.POP 1)", cfg)
@test isempty(s.integer)

# EXEC.IF
s = Push.run("(EXEC.IF 3 2)", cfg)
@test s.integer == [3, 2]
s = Push.run("(TRUE EXEC.IF 5 10)", cfg)
@test isempty(s.boolean) && s.integer == [5]
s = Push.run("(FALSE EXEC.IF 5 10)", cfg)
@test isempty(s.boolean) && s.integer == [10]

# EXEC.ROT
s = Push.run("(EXEC.ROT A B C)", cfg)
@test s.name == [:B, :C, :A]
s = Push.run("(EXEC.ROT C B A)", cfg)
@test s.name == [:B, :A, :C]

# EXEC.SHOVE
s = Push.run("(0 EXEC.SHOVE A B C D)", cfg)
@test isempty(s.integer) && s.name == [:A, :B, :C, :D]
s = Push.run("(1 EXEC.SHOVE A B C D)", cfg)
@test isempty(s.integer) && s.name == [:B, :A, :C, :D]
s = Push.run("(2 EXEC.SHOVE A B C D)", cfg)
@test isempty(s.integer) && s.name == [:B, :C, :A, :D]
s = Push.run("(3 EXEC.SHOVE A B C D)", cfg)
@test isempty(s.integer) && s.name == [:B, :C, :D, :A]
s = Push.run("(98 EXEC.SHOVE A B C D)", cfg)
@test isempty(s.integer) && s.name == [:B, :C, :D, :A]
s = Push.run("(-65 EXEC.SHOVE A B C D)", cfg)
@test isempty(s.integer) && s.name == [:A, :B, :C, :D]

# EXEC.STACKDEPTH
s = Push.run("(EXEC.STACKDEPTH A B C D)", cfg)
@test s.integer == [4]

# EXEC.SWAP
s = Push.run("(EXEC.SWAP A B C D)", cfg)
@test s.name == [:B, :A, :C, :D]
s = Push.run("(EXEC.SWAP A)", cfg)
@test s.name == [:A]

# EXEC.YANK
s = Push.run("(EXEC.YANK A B C D)", cfg)
@test s.name == [:A, :B, :C, :D]
s = Push.run("(0 EXEC.YANK A B C D)", cfg)
@test s.name == [:A, :B, :C, :D]
s = Push.run("(1 EXEC.YANK A B C D)", cfg)
@test s.name == [:B, :A, :C, :D]
s = Push.run("(2 EXEC.YANK A B C D)", cfg)
@test s.name == [:C, :A, :B, :D]
s = Push.run("(3 EXEC.YANK A B C D)", cfg)
@test s.name == [:D, :A, :B, :C]
s = Push.run("(98 EXEC.YANK A B C D)", cfg)
@test s.name == [:D, :A, :B, :C]
s = Push.run("(-86 EXEC.YANK A B C D)", cfg)
@test s.name == [:A, :B, :C, :D]

# EXEC.YANKDUP
s = Push.run("(EXEC.YANKDUP A B C D)", cfg)
@test s.name == [:A, :B, :C, :D]
s = Push.run("(0 EXEC.YANKDUP A B C D)", cfg)
@test s.name == [:A, :A, :B, :C, :D]
s = Push.run("(1 EXEC.YANKDUP A B C D)", cfg)
@test s.name == [:B, :A, :B, :C, :D]
s = Push.run("(2 EXEC.YANKDUP A B C D)", cfg)
@test s.name == [:C, :A, :B, :C, :D]
s = Push.run("(3 EXEC.YANKDUP A B C D)", cfg)
@test s.name == [:D, :A, :B, :C, :D]
s = Push.run("(98 EXEC.YANKDUP A B C D)", cfg)
@test s.name == [:D, :A, :B, :C, :D]
s = Push.run("(-86 EXEC.YANKDUP A B C D)", cfg)
@test s.name == [:A, :A, :B, :C, :D]

# EXEC.K
s = Push.run("(EXEC.K A B C)", cfg)
@test s.name == [:A, :C]
s = Push.run("(EXEC.K A)", cfg)
@test s.name == [:A]

# EXEC.Y
# Test: count from 0 to 10
s = Push.run("(0 EXEC.Y (INTEGER.DUP 1 INTEGER.+ INTEGER.DUP 10 INTEGER.< EXEC.IF () EXEC.POP))", cfg)
@test s.integer == [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

# EXEC.S
s = Push.run("(EXEC.S A B C D)", cfg)
@test s.name == [:B, :C, :C, :A, :D]

# EXEC.DO*COUNT
s = Push.run("(10 EXEC.DO*COUNT A)", cfg)
@test s.name == [:A, :A, :A, :A, :A, :A, :A, :A, :A, :A] && s.integer == [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

# EXEC.DO*RANGE
s = Push.run("(0 EXEC.DO*RANGE A)", cfg)
@test s.name == [:A]
s = Push.run("(0 9 EXEC.DO*RANGE A)", cfg)
@test s.name == [:A, :A, :A, :A, :A, :A, :A, :A, :A, :A] && s.integer == [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
s = Push.run("(9 0 EXEC.DO*RANGE A)", cfg)
@test s.name == [:A, :A, :A, :A, :A, :A, :A, :A, :A, :A] && s.integer == [9, 8, 7, 6, 5, 4, 3, 2, 1, 0]

# EXEC.DO*TIMES
s = Push.run("(10 EXEC.DO*TIMES (A))", cfg)
@test s.name == [:A, :A, :A, :A, :A, :A, :A, :A, :A, :A] && isempty(s.integer)

# EXEC.DEFINE
