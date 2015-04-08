using Push
using Base.Test

cfg_path = joinpath(dirname(@__FILE__), "configuration/mock.cfg")
cfg = Push.load_configuration(cfg_path)

@test cfg.instructions == [
  "INTEGER.FROMBOOLEAN",
  "INTEGER.FROMFLOAT",
  "INTEGER.>",
  "INTEGER.<"]

@test cfg.types == [
  "FLOAT",
  "NAME",
  "CODE",
  "BOOLEAN",
  "INTEGER"
]

@test cfg.parameters == [
  "MAX-RANDOM-FLOAT" => "1.0",
  "MIN-RANDOM-FLOAT" => "-1.0",
  "MAX-RANDOM-INTEGER" => "10",
  "MIN-RANDOM-INTEGER" => "-10",
  "EVALPUSH-LIMIT" => "1000",
  "NEW-ERC-NAME-PROBABILITY" => "0.001",
  "MAX-POINTS-IN-RANDOM-EXPRESSIONS" => "25",
  "MAX-POINTS-IN-PROGRAM" => "100",
]