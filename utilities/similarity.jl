function cosine(a,b)
    if sum(a) == 0 || sum(b) == 0
        return 0;
    end

    return sum(a .* b) ./ (sqrt(sum(a.^2)) * sqrt(sum(b.^2)))
end

function unionCosine(a,b)
  index = intersect(find(r-> r != 0, a), find(r-> r != 0, b));
  if length(index) < 2
    return 0;
  else
    return cosine(a[index], b[index]);
  end
end

function pearsonCorrelation(a,b)
  index_a = find(r-> r != 0, a)
  index_b = find(r-> r != 0, b)

  index = intersect(index_a, index_b)

  if length(index) < 2
    return 0;
  end

  norm_a = a[index] .- mean(a[index_a])
  norm_b = b[index] .- mean(b[index_b])

  y = sqrt(sum(norm_a .^ 2)) .* sqrt(sum(norm_b .^ 2))

  if y == 0
    return 0
  end

  return sum(norm_a .* norm_b) ./ y
end

function significanceWeighting(a, b, similarity::Function; γ = 10)
  index = intersectRatings(a, b)
  return similarity(a,b) .* (min(γ, maximum(size(index))) ./ γ)
end

function intersectRatings(a, b)
  index_a = find(r-> r != 0, a)
  index_b = find(r-> r != 0, b)

  return intersect(index_a, index_b)
end
