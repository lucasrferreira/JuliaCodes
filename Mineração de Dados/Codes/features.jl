using DataFrames

function universitiesFeatures(_in::DataFrame)
  grouped = groupby(_in, :no_ies)
  featured = zeros(length(grouped), 4)
  map = Array(AbstractString,, length(grouped))
  for i=1:length(grouped)
    map[i] = grouped[i][:no_ies][1]
    featured[i] = mean(grouped[i][:nt_ger])
    fea
  end
end
