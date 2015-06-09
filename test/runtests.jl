test_dir = dirname(@__FILE__)
tests = [
  "boolean",
  "code",
  "configuration",
  "exec",
  "float",
  "integer",
  "name",
  "stack"
]

println("Running tests:")

for t in tests
  f = "test_$t.jl"
  println("  * $f...")
  include(joinpath(test_dir, f))
end
