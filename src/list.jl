# Searches for the (sub-)list containing a given needle within a provided list.
# If no such container can be found, an empty list is returned.
function container(haystack::Vector{Any}, needle::Any)
  # Search all sub-containers for the needle, recursively.
  cnt = []
  for sub in haystack
    cnt = container(sub, needle)
    if !isempty(cnt)
      return cnt
    end
  end

  # Once we've finished searching the bottom of the haystack,
  # look at the container we're in.
  if in(needle, haystack)
    return haystack
  end

  # If we can't find the needle, then return the empty list.
  return []
end

# If the haystack isn't a vector, then return an empty list.
container(haystack::Any, needle::Any) = []

# Calculates the number of points in a given Push expression.
function num_points(expr::Vector{Any})
  points = 1
  for sub in expr
    points += num_points(sub)
  end
  return points
end
num_points(expr::Any) = 1

function insert_at_point!(v::Any, r::Any, pt::Integer)
  pt = abs(pt) % num_points(v)
  if pt == 0
    return r
  else
    insert_at_point!(v, r, pt, 0)
    return v
  end
end

function insert_at_point!(v::Vector{Any}, r::Any, pt::Integer, i::Integer)
  j = 0
  l = length(v)
  while i < pt && j < l
    j += 1
    i += 1
    if i == pt
      v[j] = r
    elseif isa(v[j], Vector)
      i = insert_at_point!(v[j], r, pt, i)
    end
  end
  return i
end

function position(haystack::Vector{Any}, needle::Any)
end
