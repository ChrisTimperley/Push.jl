using Push
using Base.Test

cfg_path = joinpath(dirname(@__FILE__), "configuration/mock.cfg")
cfg = Push.load_configuration(cfg_path)

# Check the list of instructions.
println(cfg.instructions)

@test cfg.instructions == [
  "INTEGER.FROMBOOLEAN",
  "INTEGER.FROMFLOAT",
  "INTEGER.>",
  "INTEGER.<"]