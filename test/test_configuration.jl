using Push
using Test

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

@test sort(collect(cfg.parameters)) == [
  "EVALPUSH-LIMIT" => "1000",
  "MAX-POINTS-IN-PROGRAM" => "100",
  "MAX-POINTS-IN-RANDOM-EXPRESSIONS" => "25",
  "MAX-RANDOM-FLOAT" => "1.0",
  "MAX-RANDOM-INTEGER" => "10",
  "MIN-RANDOM-FLOAT" => "-1.0",
  "MIN-RANDOM-INTEGER" => "-10",
  "NEW-ERC-NAME-PROBABILITY" => "0.001",
]