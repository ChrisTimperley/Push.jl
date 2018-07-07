using Push
using Test

cfg_path = joinpath(dirname(@__FILE__), "configuration/integer.cfg")
cfg = Push.load_configuration(cfg_path)

# INTEGER.*
s = Push.run("(1 INTEGER.*)", cfg)
@test s.integer == [1]
s = Push.run("(7 3 2 10 INTEGER.*)", cfg)
@test s.integer == [7, 3, 20]

# INTEGER.+
s = Push.run("(1 INTEGER.+)", cfg)
@test s.integer == [1]
s = Push.run("(7 3 2 10 INTEGER.+)", cfg)
@test s.integer == [7, 3, 12]
s = Push.run("(7 3 2 -10 INTEGER.+)", cfg)
@test s.integer == [7, 3, -8]

# INTEGER.-
s = Push.run("(1 INTEGER.-)", cfg)
@test s.integer == [1]
s = Push.run("(7 3 10 2 INTEGER.-)", cfg)
@test s.integer == [7, 3, 8]
s = Push.run("(7 3 2 10 INTEGER.-)", cfg)
@test s.integer == [7, 3, -8]

# INTEGER./
s = Push.run("(1 INTEGER./)", cfg)
@test s.integer == [1]
s = Push.run("(7 3 10 2 INTEGER./)", cfg)
@test s.integer == [7, 3, 5]
s = Push.run("(7 3 -10 4 INTEGER./)", cfg)
@test s.integer == [7, 3, -2]
s = Push.run("(7 3 -10 0 INTEGER./)", cfg)
@test s.integer == [7, 3, -10, 0]

# INTEGER.<
s = Push.run("(1 INTEGER.<)", cfg)
@test s.integer == [1] && isempty(s.boolean)
s = Push.run("(100 900 2 3 INTEGER.<)", cfg)
@test s.integer == [100, 900] && s.boolean == [true]
s = Push.run("(100 900 5 -10 INTEGER.<)", cfg)
@test s.integer == [100, 900] && s.boolean == [false]
s = Push.run("(100 900 5 5 INTEGER.<)", cfg)
@test s.integer == [100, 900] && s.boolean == [false]

# INTEGER.=
s = Push.run("(1 INTEGER.=)", cfg)
@test s.integer == [1] && isempty(s.boolean)
s = Push.run("(100 900 -10 90 INTEGER.=)", cfg)
@test s.integer == [100, 900] && s.boolean == [false]
s = Push.run("(100 900 -10 -10 INTEGER.=)", cfg)
@test s.integer == [100, 900] && s.boolean == [true]

# INTEGER.>
s = Push.run("(1 INTEGER.>)", cfg)
@test s.integer == [1] && isempty(s.boolean)
s = Push.run("(100 900 2 3 INTEGER.>)", cfg)
@test s.integer == [100, 900] && s.boolean == [false]
s = Push.run("(100 900 5 -10 INTEGER.>)", cfg)
@test s.integer == [100, 900] && s.boolean == [true]
s = Push.run("(100 900 5 5 INTEGER.>)", cfg)
@test s.integer == [100, 900] && s.boolean == [false]

# INTEGER.DUP
s = Push.run("(10 20 30 INTEGER.DUP)", cfg)
@test s.integer == [10, 20, 30, 30]

# INTEGER.FLUSH
s = Push.run("(10 20 30 INTEGER.FLUSH)", cfg)
@test s.integer == []

# INTEGER.FROMBOOLEAN
s = Push.run("(10 20 TRUE FALSE INTEGER.FROMBOOLEAN)", cfg)
@test s.integer == [10, 20, 0] && s.boolean == [true]
s = Push.run("(10 20 FALSE TRUE INTEGER.FROMBOOLEAN)", cfg)
@test s.integer == [10, 20, 1] && s.boolean == [false]

# INTEGER.FROMFLOAT
s = Push.run("(1.0 2.0 3.0 INTEGER.FROMFLOAT)", cfg)
@test s.integer == [3] && s.float == [1.0, 2.0]

# INTEGER.MAX
s = Push.run("(10 10 INTEGER.MAX)", cfg)
@test s.integer == [10]
s = Push.run("(20 10 INTEGER.MAX)", cfg)
@test s.integer == [20]
s = Push.run("(10 20 INTEGER.MAX)", cfg)
@test s.integer == [20]

# INTEGER.MIN
s = Push.run("(10 10 INTEGER.MIN)", cfg)
@test s.integer == [10]
s = Push.run("(20 10 INTEGER.MIN)", cfg)
@test s.integer == [10]
s = Push.run("(10 20 INTEGER.MIN)", cfg)
@test s.integer == [10]

# INTEGER.POP
s = Push.run("(10 20 30 INTEGER.POP)", cfg)
@test s.integer == [10, 20]

# INTEGER.ROT
s = Push.run("(1 INTEGER.ROT)", cfg)
@test s.integer == [1]
s = Push.run("(0 10 20 30 INTEGER.ROT)", cfg)
@test s.integer == [0, 30, 10, 20]

# INTEGER.SHOVE
s = Push.run("(1 INTEGER.SHOVE)", cfg)
@test s.integer == [1]
s = Push.run("(2 0 INTEGER.SHOVE)", cfg)
@test s.integer == [2]
s = Push.run("(2 9000 INTEGER.SHOVE)", cfg)
@test s.integer == [2]
s = Push.run("(1 2 3 4 5 6 7 8 900 -20 INTEGER.SHOVE)", cfg)
@test s.integer == [1,2,3,4,5,6,7,8,900]
s = Push.run("(1 2 3 4 5 6 7 8 900 0 INTEGER.SHOVE)", cfg)
@test s.integer == [1,2,3,4,5,6,7,8,900]
s = Push.run("(1 2 3 4 5 6 7 8 900 1 INTEGER.SHOVE)", cfg)
@test s.integer == [1,2,3,4,5,6,7,900,8]
s = Push.run("(1 2 3 4 5 6 7 8 900 2 INTEGER.SHOVE)", cfg)
@test s.integer == [1,2,3,4,5,6,900,7,8]
s = Push.run("(1 2 3 4 5 6 7 8 900 9 INTEGER.SHOVE)", cfg)
@test s.integer == [900,1,2,3,4,5,6,7,8]
s = Push.run("(1 2 3 4 5 6 7 8 900 1000 INTEGER.SHOVE)", cfg)
@test s.integer == [900,1,2,3,4,5,6,7,8]

# INTEGER.STACKDEPTH
s = Push.run("(INTEGER.STACKDEPTH)", cfg)
@test s.integer == [0]
s = Push.run("(10 20 30 40 INTEGER.STACKDEPTH)", cfg)
@test s.integer == [10,20,30,40, 4]

# INTEGER.SWAP
s = Push.run("(1 INTEGER.SWAP)", cfg)
@test s.integer == [1]
s = Push.run("(1 2 3 4 5 6 INTEGER.SWAP)", cfg)
@test s.integer == [1,2,3,4,6,5]

# INTEGER.YANK
s = Push.run("(1 INTEGER.YANK)", cfg)
@test s.integer == [1]
s = Push.run("(10 0 INTEGER.YANK)", cfg)
@test s.integer == [10]
s = Push.run("(10 20 30 40 50 -90 INTEGER.YANK)", cfg)
@test s.integer == [10, 20, 30, 40, 50]
s = Push.run("(10 20 30 40 50 0 INTEGER.YANK)", cfg)
@test s.integer == [10, 20, 30, 40, 50]
s = Push.run("(10 20 30 40 50 1 INTEGER.YANK)", cfg)
@test s.integer == [10, 20, 30, 50, 40]
s = Push.run("(10 20 30 40 50 2 INTEGER.YANK)", cfg)
@test s.integer == [10, 20, 40, 50, 30]
s = Push.run("(10 20 30 40 50 5 INTEGER.YANK)", cfg)
@test s.integer == [20, 30, 40, 50, 10]
s = Push.run("(10 20 30 40 50 987 INTEGER.YANK)", cfg)
@test s.integer == [20, 30, 40, 50, 10]

# INTEGER.YANKDUP
s = Push.run("(1 INTEGER.YANKDUP)", cfg)
@test s.integer == [1]
s = Push.run("(10 20 30 40 50 0 INTEGER.YANKDUP)", cfg)
@test s.integer == [10, 20, 30, 40, 50, 50]
s = Push.run("(10 20 30 40 50 1 INTEGER.YANKDUP)", cfg)
@test s.integer == [10, 20, 30, 40, 50, 40]
s = Push.run("(10 20 30 40 50 2 INTEGER.YANKDUP)", cfg)
@test s.integer == [10, 20, 30, 40, 50, 30]
s = Push.run("(10 20 30 40 50 3 INTEGER.YANKDUP)", cfg)
@test s.integer == [10, 20, 30, 40, 50, 20]
s = Push.run("(10 20 30 40 50 4 INTEGER.YANKDUP)", cfg)
@test s.integer == [10, 20, 30, 40, 50, 10]
s = Push.run("(10 20 30 40 50 987 INTEGER.YANKDUP)", cfg)
@test s.integer == [10, 20, 30, 40, 50, 10]
s = Push.run("(10 20 30 40 50 -987 INTEGER.YANKDUP)", cfg)
@test s.integer == [10, 20, 30, 40, 50, 50]

# INTEGER.DEFINE
s = Push.run("(X INTEGER.DEFINE X)", cfg)
@test isempty(s.integer) && s.name == [:X, :X]
s = Push.run("(3 X INTEGER.DEFINE X)", cfg)
@test isempty(s.name) && s.integer == [3]

# INTEGER.RAND
s = Push.run("(INTEGER.RAND)", cfg)
@test length(s.integer) == 1

# INTEGER.%
