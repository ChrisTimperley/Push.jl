# Convenience data structure for holding all global parameters
# in a single container.
type Parameters

  # The minimum value produced by a call to FLOAT.RAND.
  min_random_float::Float32
  
  # The maximum value produced by a call to FLOAT.RAND.
  max_random_float::Float32

  # The maximum value produced by a call to INTEGER.RAND.
  max_random_integer::Int32

  # The minimum value produced by a call to INTEGER.RAND.
  min_random_integer::Int32

  # The maximum number of points that will be executed in a single
  # top-level call to the interpreter.
  eval_push_limit::Int32

  # The probability that the selection of the ephemeral random NAME constant
  # for inclusion in randomly generated code will yield a new name, rather than
  # an existing name.
  new_erc_name_probability::Float32

  # The maximum number of points in an expression produced by CODE.RAND.
  max_points_in_random_expressions::Int32

  # The maximum number of points that may occur in any program on the CODE
  # stack. Instructions which would violate this limit act as NOOPs.
  # If this parameter is set to -1, then no such limit is enforced.
  max_points_in_program::Int32

  # When this flag is set to true, all code passed to the top level of the
  # interpreter will be pushed onto the CODE stack prior to execution.
  top_level_push_code::Bool

  # When this flag is set to true, the CODE stack will be popped at the
  # end of top level calls to the interpreter.
  top_level_pop_code::Bool

  # Creates a new set of default parameters.
  Parameters() =
    new(typemin(Float32), typemax(Float32),
      typemin(Int32), typemax(Int32),
      500, 0.001, 10, 10, true, false)

end

# Adjusts the parameters of a given parameter object using a parameter table.
set!(p::Parameters, params::Dict{String, String}) = for (k, v) in params
  set!(p, k, v)
end

# Adjusts the value of a single parameter, k, to a given value, v.
set!(p::Parameters, k::String, v::String) = return