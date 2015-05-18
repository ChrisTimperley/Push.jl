# Searches for the (sub-)list containing a given needle within a provided list.
# If no such container can be found, an empty list is returned.
function container(haystack::Vector{Any}, needle::Any)
  q = {haystack}
  while !isempty(q)
    container = shift!(q)

    if in(needle, container)
      return container
    end

    for subcontainer in container
      if isa(subcontainer, Vector)
        push!(q, subcontainer)
      end
    end
  end
  return {}
end

# If the haystack isn't a vector, then return an empty list.
container(haystack::Any, needle::Any) = {}

# Calculates the number of points in a given Push expression.
function num_points(expr::Vector{Any})
  points = 1
  for sub in expr
    points += num_points(sub)
  end
  return points
end 
num_points(expr::Any) = 1

function insert_at_point!(v::Any, pt::Integer, r::Any) =
  pt = abs(pt) % num_points(v)
  pt == 0 ? r : insert_at_point!(v, pt, r, 0)
end

function insert_at_point!(v::Vector{Any}, pt::Integer, r::Any, i::Integer)
  j = 0
  while i < pt
    j += 1
    i += 1
    if i == pt
      vec[j] = replacement
    elseif isa(vec[j], Vector)
      i = insert_at_point!(vec[j], pt, r, i)
    end
  end
  return i
end
