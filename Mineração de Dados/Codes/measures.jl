using DataFrames
# filename = "Mineração de Dados/dataSet/completa.csv"
# _in = readtable(filename, separator = ';', header = true)

function bestsUniversits(_in::DataFrame)
  _in = copy(_in)
  grouped = groupby(_in, [:no_ies])
  out = Array(Any ,length(grouped), 3)
  for i=1:length(grouped)
    data = grouped[i]
    out[i,1] = data[:no_ies][1]
    out[i,2] = mean(data[:nt_ger])
    out[i,3] = _in[:no_ies] .== out[i,1]
  end
  out = sortrows(out, rev = true , by= x -> (x[2]))
  indexs = out[[1:10], 3]
  index = indexs[1]
  for i=1:length(indexs)
    index = index | indexs[i]
  end
  return index
end
