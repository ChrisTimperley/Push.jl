module Push3
  export register

  include("parser.jl")
  include("stack.jl")
  include("state.jl")
  include("interpreter.jl")

  # Initialise the instruction repository.
  instructions = Dict{Symbol, Function}()

  # Registers a given instruction.
  register(n::String, f::Function) = instructions[convert(Symbol, n)] = f

  # Load all the built-in instructions.
  include("instructions/boolean.jl")
  include("instructions/code.jl")
  include("instructions/exec.jl")
  include("instructions/float.jl")
  include("instructions/integer.jl")
  include("instructions/name.jl")
end