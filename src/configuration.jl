type Configuration
  types::Vector{String}
  instructions::Vector{Symbol}
end

# Creates and returns an initial state using a given configuration.
function configure(c::Configuration)
  s = State()

  # Instruction handling.
  for i in c.instructions
    enable_instruction!(state, i)
  end

  # Type handling.
  # - Means nothing for now.

  # Parameter handling.

  return s
end