using Push
using Test

# Load the base configuration used by all tests.
cfg_path = joinpath(dirname(@__FILE__), "configuration/boolean.cfg")
cfg = Push.load_configuration(cfg_path)

# EQUALS.
s = Push.run("(FALSE FALSE BOOLEAN.=)", cfg)
@test s.boolean == [true]
s = Push.run("(FALSE TRUE BOOLEAN.=)", cfg)
@test s.boolean == [false]

# NOT.
s = Push.run("(FALSE BOOLEAN.NOT)", cfg)
@test s.boolean == [true]
s = Push.run("(TRUE BOOLEAN.NOT)", cfg)
@test s.boolean == [false]

# AND.
s = Push.run("(FALSE FALSE BOOLEAN.AND)", cfg)
@test s.boolean == [false]
s = Push.run("(FALSE TRUE BOOLEAN.AND)", cfg)
@test s.boolean == [false]
s = Push.run("(TRUE FALSE BOOLEAN.AND)", cfg)
@test s.boolean == [false]
s = Push.run("(TRUE TRUE BOOLEAN.AND)", cfg)
@test s.boolean == [true]

# OR.
s = Push.run("(FALSE FALSE BOOLEAN.OR)", cfg)
@test s.boolean == [false]
s = Push.run("(FALSE TRUE BOOLEAN.OR)", cfg)
@test s.boolean == [true]
s = Push.run("(TRUE FALSE BOOLEAN.OR)", cfg)
@test s.boolean == [true]
s = Push.run("(TRUE TRUE BOOLEAN.OR)", cfg)
@test s.boolean == [true]

# DUP.
s = Push.run("(FALSE BOOLEAN.DUP)", cfg)
@test length(s.boolean) == 2

# FLUSH.
s = Push.run("(FALSE TRUE FALSE FALSE BOOLEAN.FLUSH)", cfg)
@test isempty(s.boolean)

# FROM FLOAT.
s = Push.run("(0.0 BOOLEAN.FROMFLOAT)", cfg)
@test isempty(s.float) && s.boolean == [false]
s = Push.run("(1.871 BOOLEAN.FROMFLOAT)", cfg)
@test isempty(s.float) && s.boolean == [true]

# FROM INT.
s = Push.run("(0 BOOLEAN.FROMINT)", cfg)
@test isempty(s.integer) && s.boolean == [false]
s = Push.run("(32 BOOLEAN.FROMINT)", cfg)
@test isempty(s.integer) && s.boolean == [true]

# POP.
s = Push.run("(TRUE FALSE BOOLEAN.POP)", cfg)
@test s.boolean == [true]

# ROT.
s = Push.run("(FALSE TRUE TRUE BOOLEAN.ROT)", cfg)
@test s.boolean == [true, false, true]

# SWAP.
s = Push.run("(FALSE TRUE BOOLEAN.SWAP)", cfg)
@test s.boolean == [true, false]

# STACKDEPTH.
s = Push.run("(TRUE FALSE FALSE FALSE BOOLEAN.STACKDEPTH)", cfg)
@test length(s.boolean) == 4 && s.integer == [4]

# SHOVE.
s = Push.run("(3 FALSE FALSE FALSE TRUE BOOLEAN.SHOVE)", cfg)
@test isempty(s.integer) && s.boolean == [true, false, false, false]

# YANK.
s = Push.run("(3 TRUE FALSE FALSE FALSE BOOLEAN.YANK)", cfg)
@test isempty(s.integer) && s.boolean == [false, false, false, true]

# YANKDUP.
s = Push.run("(3 TRUE FALSE FALSE FALSE BOOLEAN.YANKDUP)", cfg)
@test isempty(s.integer) && s.boolean == [true, false, false, false, true]

# RAND.
s = Push.run("(BOOLEAN.RAND)", cfg)
@test length(s.boolean) == 1

# DEFINE.
s = Push.run("(X BOOLEAN.DEFINE X)", cfg)
@test isempty(s.boolean) && s.name == [:X, :X]
s = Push.run("(X TRUE BOOLEAN.DEFINE X)", cfg)
@test s.boolean == [true]
