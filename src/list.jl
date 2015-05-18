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
