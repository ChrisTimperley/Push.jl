peek{T}(v::Vector{T}) = v[end]

function shove!{T}(a::Vector{T}, i::Integer)
  ln = length(a)
  i = min(max(1, ln - i), ln + 1)
  pop!(insert!(a, i, a[end]))
  return a
end

function yank!{T}(a::Vector{T}, i::Integer)
  ln = length(a)
  i = min(max(1, ln - i), ln)
  push!(a, splice!(a, i))
end

function yankdup!{T}(a::Vector{T}, i::Integer)
  ln = length(a)
  i = min(max(1, ln - i), ln)
  push!(a, a[i])
end