using DataFrames
using MultivariateStats

filename = "Mineração de Dados/dataSet/completa.csv"
if !isfile(filename)
  filename = "dataSet/completa.csv"
  if !isfile(filename)
    filename = "../dataSet/completa.csv"
  end
end
data_in = readtable(filename, separator = ';', header = true)
names(data_in)
function bestUniversitys(data)

end

data_array = array(data_in[:,:])
