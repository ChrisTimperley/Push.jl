using Push
using Test

cfg_path = joinpath(dirname(@__FILE__), "configuration/name.cfg")
cfg = Push.load_configuration(cfg_path)

# NAME.QUOTE
s = Push.run("(NAME.QUOTE NAME.QUOTE)", cfg)
@test s.name == [Symbol("NAME.QUOTE")]

# NAME.=
s = Push.run("(X Y NAME.=)", cfg)
@test s.boolean == [false]
s = Push.run("(X X NAME.=)", cfg)
@test s.boolean == [true]

# NAME.DUP
s = Push.run("(X NAME.DUP)", cfg)
@test s.name == [:X, :X]

# NAME.FLUSH
s = Push.run("(X Y Z NAME.FLUSH)", cfg)
@test isempty(s.name)

# NAME.POP
s = Push.run("(X Y Z NAME.POP)", cfg)
@test s.name == [:X, :Y]

# NAME.ROT
s = Push.run("(Y Z NAME.ROT)", cfg)
@test s.name == [:Y, :Z]
s = Push.run("(A X Y Z NAME.ROT)", cfg)
@test s.name == [:A, :Z, :X, :Y]

# NAME.SHOVE
s = Push.run("(A B C D 0 NAME.SHOVE)", cfg)
@test s.name == [:A, :B, :C, :D]
s = Push.run("(A B C D -100 NAME.SHOVE)", cfg)
@test s.name == [:A, :B, :C, :D]
s = Push.run("(A B C D 1 NAME.SHOVE)", cfg)
@test s.name == [:A, :B, :D, :C]
s = Push.run("(A B C D 2 NAME.SHOVE)", cfg)
@test s.name == [:A, :D, :B, :C]
s = Push.run("(A B C D 3 NAME.SHOVE)", cfg)
@test s.name == [:D, :A, :B, :C]
s = Push.run("(A B C D 10 NAME.SHOVE)", cfg)
@test s.name == [:D, :A, :B, :C]

# NAME.STACKDEPTH
s = Push.run("(A B C D NAME.STACKDEPTH)", cfg)
@test s.name == [:A, :B, :C, :D] && s.integer == [4]
s = Push.run("(NAME.STACKDEPTH)", cfg)
@test s.integer == [0]

# NAME.SWAP
s = Push.run("(A B C NAME.SWAP)", cfg)
@test s.name == [:A, :C, :B]
s = Push.run("(A NAME.SWAP)", cfg)
@test s.name == [:A]

# NAME.YANK
s = Push.run("(A B C D 0 NAME.YANK)", cfg)
@test s.name == [:A, :B, :C, :D]
s = Push.run("(A B C D -100 NAME.YANK)", cfg)
@test s.name == [:A, :B, :C, :D]
s = Push.run("(A B C D 1 NAME.YANK)", cfg)
@test s.name == [:A, :B, :D, :C]
s = Push.run("(A B C D 2 NAME.YANK)", cfg)
@test s.name == [:A, :C, :D, :B]
s = Push.run("(A B C D 3 NAME.YANK)", cfg)
@test s.name == [:B, :C, :D, :A]
s = Push.run("(A B C D 10 NAME.YANK)", cfg)
@test s.name == [:B, :C, :D, :A]

# NAME.YANKDUP
s = Push.run("(A B C D 0 NAME.YANKDUP)", cfg)
@test s.name == [:A, :B, :C, :D, :D]
s = Push.run("(A B C D -100 NAME.YANKDUP)", cfg)
@test s.name == [:A, :B, :C, :D, :D]
s = Push.run("(A B C D 1 NAME.YANKDUP)", cfg)
@test s.name == [:A, :B, :C, :D, :C]
s = Push.run("(A B C D 2 NAME.YANKDUP)", cfg)
@test s.name == [:A, :B, :C, :D, :B]
s = Push.run("(A B C D 3 NAME.YANKDUP)", cfg)
@test s.name == [:A, :B, :C, :D, :A]
s = Push.run("(A B C D 10 NAME.YANKDUP)", cfg)
@test s.name == [:A, :B, :C, :D, :A]

# NAME.RAND
s = Push.run("(NAME.RAND)", cfg)
@test length(s.name) == 1

# NAME.RANDBOUNDNAME
s = Push.run("(NAME.RANDBOUNDNAME)", cfg)
@test length(s.name) == 1 && in(s.name[1], Push.list_instructions(s))
