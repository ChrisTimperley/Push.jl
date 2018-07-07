using Push
using Test

cfg_path = joinpath(dirname(@__FILE__), "configuration/float.cfg")
cfg = Push.load_configuration(cfg_path)

# FLOAT.*
s = Push.run("(1.0 FLOAT.*)", cfg)
@test s.float == [1.0]
s = Push.run("(2.5 3.0 50.0 0.1 FLOAT.*)", cfg)
@test s.float == [2.5, 3.0, 5.0]
s = Push.run("(2.5 3.0 -50.0 10.0 FLOAT.*)", cfg)
@test s.float == [2.5, 3.0, -500.0]

# FLOAT.+
s = Push.run("(1.0 FLOAT.+)", cfg)
@test s.float == [1.0]
s = Push.run("(7.0 3.0 2.5 10.25 FLOAT.+)", cfg)
@test s.float == [7.0, 3.0, 12.75]
s = Push.run("(7.0 3.0 2.75 -10.25 FLOAT.+)", cfg)
@test s.float == [7.0, 3.0, -7.5]

# FLOAT.-
s = Push.run("(1.0 FLOAT.-)", cfg)
@test s.float == [1.0]
s = Push.run("(7.0 3.0 10.75 2.25 FLOAT.-)", cfg)
@test s.float == [7.0, 3.0, 8.5]
s = Push.run("(7.0 3.0 10.0 25.0 FLOAT.-)", cfg)
@test s.float == [7.0, 3.0, -15.0]

# FLOAT./
s = Push.run("(1.0 FLOAT./)", cfg)
@test s.float == [1.0]
s = Push.run("(7.0 3.0 10.0 2.0 FLOAT./)", cfg)
@test s.float == [7.0, 3.0, 5.0]
s = Push.run("(7.0 3.0 -10.0 4.0 FLOAT./)", cfg)
@test s.float == [7.0, 3.0, -2.5]
s = Push.run("(7.0 3.0 -10.0 0.0 FLOAT./)", cfg)
@test s.float == [7.0, 3.0, -10.0, 0.0]

# FLOAT.<
s = Push.run("(1.0 FLOAT.<)", cfg)
@test s.float == [1.0] && isempty(s.boolean)
s = Push.run("(100.0 900.0 2.0 3.0 FLOAT.<)", cfg)
@test s.float == [100.0, 900.0] && s.boolean == [true]
s = Push.run("(100.0 900.0 5.0 -10.0 FLOAT.<)", cfg)
@test s.float == [100.0, 900.0] && s.boolean == [false]
s = Push.run("(100.0 900.0 5.0 5.0 FLOAT.<)", cfg)
@test s.float == [100.0, 900.0] && s.boolean == [false]

# FLOAT.=
s = Push.run("(1.0 FLOAT.=)", cfg)
@test s.float == [1.0] && isempty(s.boolean)
s = Push.run("(100.0 900.0 -10.0 90.0 FLOAT.=)", cfg)
@test s.float == [100.0, 900.0] && s.boolean == [false]
s = Push.run("(100.0 900.0 -10.0 -10.0 FLOAT.=)", cfg)
@test s.float == [100.0, 900.0] && s.boolean == [true]

# FLOAT.>
s = Push.run("(1.0 FLOAT.>)", cfg)
@test s.float == [1.0] && isempty(s.boolean)
s = Push.run("(100.0 900.0 2.0 3.0 FLOAT.>)", cfg)
@test s.float == [100.0, 900.0] && s.boolean == [false]
s = Push.run("(100.0 900.0 5.0 -10.0 FLOAT.>)", cfg)
@test s.float == [100.0, 900.0] && s.boolean == [true]
s = Push.run("(100.0 900.0 5.0 5.0 FLOAT.>)", cfg)
@test s.float == [100.0, 900.0] && s.boolean == [false]

# FLOAT.DUP
s = Push.run("(10.0 20.0 30.0 FLOAT.DUP)", cfg)
@test s.float == [10.0, 20.0, 30.0, 30.0]

# FLOAT.FLUSH
s = Push.run("(10.0 20.0 30.0 FLOAT.FLUSH)", cfg)
@test s.float == []

# FLOAT.FROMBOOLEAN
s = Push.run("(10.0 20.0 TRUE FALSE FLOAT.FROMBOOLEAN)", cfg)
@test s.float == [10.0, 20.0, 0.0] && s.boolean == [true]
s = Push.run("(10.0 20.0 FALSE TRUE FLOAT.FROMBOOLEAN)", cfg)
@test s.float == [10.0, 20.0, 1.0] && s.boolean == [false]

# FLOAT.FROMINTEGER
s = Push.run("(89 FLOAT.FROMINTEGER)", cfg)
@test s.integer == [] && s.float == [89.0]

# FLOAT.MAX
s = Push.run("(10.0 10.0 FLOAT.MAX)", cfg)
@test s.float == [10.0]
s = Push.run("(20.0 10.0 FLOAT.MAX)", cfg)
@test s.float == [20.0]
s = Push.run("(10.0 20.0 FLOAT.MAX)", cfg)
@test s.float == [20.0]

# FLOAT.MIN
s = Push.run("(10.0 10.0 FLOAT.MIN)", cfg)
@test s.float == [10.0]
s = Push.run("(20.0 10.0 FLOAT.MIN)", cfg)
@test s.float == [10.0]
s = Push.run("(10.0 20.0 FLOAT.MIN)", cfg)
@test s.float == [10.0]

# FLOAT.POP
s = Push.run("(10.0 20.0 30.0 FLOAT.POP)", cfg)
@test s.float == [10.0, 20.0]

# FLOAT.ROT
s = Push.run("(1.0 FLOAT.ROT)", cfg)
@test s.float == [1.0]
s = Push.run("(0.0 10.0 20.0 30.0 FLOAT.ROT)", cfg)
@test s.float == [0.0, 30.0, 10.0, 20.0]

# FLOAT.SHOVE
s = Push.run("(1.0 FLOAT.SHOVE)", cfg)
@test s.float == [1.0]
s = Push.run("(2.0 0 FLOAT.SHOVE)", cfg)
@test s.float == [2.0]
s = Push.run("(2.0 9000 FLOAT.SHOVE)", cfg)
@test s.float == [2.0]
s = Push.run("(1.0 2.0 3.0 4.0 5.0 6.0 7.0 8.0 900.0 -20 FLOAT.SHOVE)", cfg)
@test s.float == [1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,900.0]
s = Push.run("(1.0 2.0 3.0 4.0 5.0 6.0 7.0 8.0 900.0 0 FLOAT.SHOVE)", cfg)
@test s.float == [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 900.0]
s = Push.run("(1.0 2.0 3.0 4.0 5.0 6.0 7.0 8.0 900.0 1 FLOAT.SHOVE)", cfg)
@test s.float == [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 900.0, 8.0]
s = Push.run("(1.0 2.0 3.0 4.0 5.0 6.0 7.0 8.0 900.0 2 FLOAT.SHOVE)", cfg)
@test s.float == [1.0,2.0,3.0,4.0,5.0,6.0,900.0,7.0,8.0]
s = Push.run("(1.0 2.0 3.0 4.0 5.0 6.0 7.0 8.0 900.0 9 FLOAT.SHOVE)", cfg)
@test s.float == [900.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0]
s = Push.run("(1.0 2.0 3.0 4.0 5.0 6.0 7.0 8.0 900.0 1000 FLOAT.SHOVE)", cfg)
@test s.float == [900.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0]

# FLOAT.STACKDEPTH
s = Push.run("(FLOAT.STACKDEPTH)", cfg)
@test s.integer == [0]
s = Push.run("(1 20.0 30.0 40.0 FLOAT.STACKDEPTH)", cfg)
@test s.integer == [1, 3] && s.float == [20.0, 30.0, 40.0]

# FLOAT.SWAP
s = Push.run("(1.0 FLOAT.SWAP)", cfg)
@test s.float == [1.0]
s = Push.run("(1.0 2.0 3.0 4.0 5.0 6.0 FLOAT.SWAP)", cfg)
@test s.float == [1.0,2.0,3.0,4.0,6.0,5.0]

# FLOAT.YANK
s = Push.run("(1.0 FLOAT.YANK)", cfg)
@test s.float == [1.0]
s = Push.run("(10.0 0 FLOAT.YANK)", cfg)
@test s.float == [10.0]
s = Push.run("(10.0 20.0 30.0 40.0 50.0 -90 FLOAT.YANK)", cfg)
@test s.float == [10.0, 20.0, 30.0, 40.0, 50.0]
s = Push.run("(10.0 20.0 30.0 40.0 50.0 0 FLOAT.YANK)", cfg)
@test s.float == [10.0, 20.0, 30.0, 40.0, 50.0]
s = Push.run("(10.0 20.0 30.0 40.0 50.0 1 FLOAT.YANK)", cfg)
@test s.float == [10.0, 20.0, 30.0, 50.0, 40.0]
s = Push.run("(10.0 20.0 30.0 40.0 50.0 2 FLOAT.YANK)", cfg)
@test s.float == [10.0, 20.0, 40.0, 50.0, 30.0]
s = Push.run("(10.0 20.0 30.0 40.0 50.0 5 FLOAT.YANK)", cfg)
@test s.float == [20.0, 30.0, 40.0, 50.0, 10.0]
s = Push.run("(10.0 20.0 30.0 40.0 50.0 987 FLOAT.YANK)", cfg)
@test s.float == [20.0, 30.0, 40.0, 50.0, 10.0]

# FLOAT.YANKDUP
s = Push.run("(1.0 FLOAT.YANKDUP)", cfg)
@test s.float == [1.0]
s = Push.run("(10.0 20.0 30.0 40.0 50.0 0 FLOAT.YANKDUP)", cfg)
@test s.float == [10.0, 20.0, 30.0, 40.0, 50.0, 50.0]
s = Push.run("(10.0 20.0 30.0 40.0 50.0 1 FLOAT.YANKDUP)", cfg)
@test s.float == [10.0, 20.0, 30.0, 40.0, 50.0, 40.0]
s = Push.run("(10.0 20.0 30.0 40.0 50.0 2 FLOAT.YANKDUP)", cfg)
@test s.float == [10.0, 20.0, 30.0, 40.0, 50.0, 30.0]
s = Push.run("(10.0 20.0 30.0 40.0 50.0 3 FLOAT.YANKDUP)", cfg)
@test s.float == [10.0, 20.0, 30.0, 40.0, 50.0, 20.0]
s = Push.run("(10.0 20.0 30.0 40.0 50.0 4 FLOAT.YANKDUP)", cfg)
@test s.float == [10.0, 20.0, 30.0, 40.0, 50.0, 10.0]
s = Push.run("(10.0 20.0 30.0 40.0 50.0 987 FLOAT.YANKDUP)", cfg)
@test s.float == [10.0, 20.0, 30.0, 40.0, 50.0, 10.0]
s = Push.run("(10.0 20.0 30.0 40.0 50.0 -987 FLOAT.YANKDUP)", cfg)
@test s.float == [10.0, 20.0, 30.0, 40.0, 50.0, 50.0]

# FLOAT.TAN
s = Push.run("(90.0 FLOAT.TAN)", cfg)
@test s.float == Float32[tan(90.0)]

# FLOAT.COS
s = Push.run("(90.0 FLOAT.COS)", cfg)
@test s.float == Float32[cos(90.0)]

# FLOAT.SIN
s = Push.run("(90.0 FLOAT.SIN)", cfg)
@test s.float == Float32[sin(90.0)]

# FLOAT.DEFINE
s = Push.run("(X FLOAT.DEFINE X)", cfg)
@test isempty(s.float) && s.name == [:X, :X]
s = Push.run("(3.0 X FLOAT.DEFINE X)", cfg)
@test isempty(s.name) && s.float == [3.0]

# FLOAT.RAND
s = Push.run("(FLOAT.RAND)", cfg)
@test length(s.float) == 1

# FLOAT.%
