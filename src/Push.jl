module Push
  export register, run

  include("stack.jl")
  include("parser.jl")
  include("parameters.jl")
  include("state.jl")
  include("configuration.jl")
  include("execute.jl")
  include("random.jl")
  include("list.jl")

  # Initialise the instruction repository.
  instructions = Dict{Symbol, Function}()

  # Registers a given instruction.
  register(n::String, f::Function) = instructions[convert(Symbol, n)] = f

  # Fetches a given instruction.
  fetch_instruction(n::String) = fetch_instruction(convert(Symbol, n))
  fetch_instruction(n::Symbol) = instructions[n]

  # Load all the built-in instructions.
  include("instructions/boolean.jl")
  include("instructions/code.jl")
  include("instructions/exec.jl")
  include("instructions/float.jl")
  include("instructions/integer.jl")
  include("instructions/name.jl")

  # Load and store the default configuration.
  default_configuration = load_configuration(joinpath(dirname(@__FILE__), "default.cfg"))
end
