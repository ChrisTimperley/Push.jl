#
# TODO:
# - Clear excess whitespace.
# - Configuration validation.
#
mutable struct Configuration
  parameters::Dict{String, String}
  types::Vector{String}
  instructions::Vector{String}

  Configuration() = new(Dict{String, Any}(), String[], Symbol[])
end

# Loads a configuration file at a given location.
load_configuration(f::String) = open(load_configuration, f)
function load_configuration(f::IOStream)
  c = Configuration()
  for ln in eachline(f)
    ln = strip(ln)

    # Ignore comments and empty lines.
    if !isempty(ln) && ln[1] != '#'
      k, v = split(ln)
      if k == "type" # Type declaration.
        push!(c.types, v)
      elseif k == "instruction" # Instruction declaration.
        push!(c.instructions, v)
      else # Parameter definition.
        c.parameters[k] = v
      end
    end
  end
  return c
end

# Creates and returns an initial state using a given configuration.
configure(f::String) = configure(load_configuration(f))
function configure(c::Configuration)
  s = State()

  # Instruction handling.
  for i in c.instructions
    enable_instruction!(s, i)
  end

  # Type handling.
  # - Means nothing for now.

  # Parameter handling.
  set!(s.parameters, c.parameters)

  return s
end