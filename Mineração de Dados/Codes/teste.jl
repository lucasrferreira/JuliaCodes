using MultivariateStats
using Gadfly
using Distances
include("distances.jl")

dist = Distances

A = rand(1:10, 10,100)
size(A)[1]
dist = EuclideanDistMatrix(A)
dist.distanceMatrix

G = dmat2gram(A)
H = gram2dmat!(H, A)
xy = classical_mds(dist.distanceMatrix, 1)
Gadfly.plot(x= xy[1,:], y = Array(AbstractString, 10))

using DataFrames
using MultivariateStats

include("measures.jl")
filename = "Mineração de Dados/dataSet/completa.csv"
if !isfile(filename)
  filename = "dataSet/completa.csv"
  if !isfile(filename)
    filename = "../dataSet/completa.csv"
  end
end
data_in = readtable(filename, separator = ';', header = true)
names(data_in)
data_in[[1:10],:]
bestsUniversits(data_in)
gouped = groupby(data_in, [:no_ies])
bests = bestsUniversits(data_in)

groupby(data_in[bests, : ], :no_ies)
