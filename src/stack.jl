peek(v::Vector{T}) where {T} = v[end]

function shove!(a::Vector{T}, i::Integer) where {T}
  ln = length(a)
  i = min(max(1, ln - i), ln + 1)
  pop!(insert!(a, i, a[end]))
  return a
end

function yank!(a::Vector{T}, i::Integer) where {T}
  ln = length(a)
  i = min(max(1, ln - i), ln)
  push!(a, splice!(a, i))
end

function yankdup!(a::Vector{T}, i::Integer) where {T}
  ln = length(a)
  i = min(max(1, ln - i), ln)
  push!(a, a[i])
end