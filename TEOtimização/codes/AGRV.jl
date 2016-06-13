include("Problem.jl")
include("Dataset.jl")
include("Functions.jl")

some = Problem()
some.getIds()


initialPopulation = populationGerator(some.getIds(), 100)
initialPopulation[1]
unique(initialPopulation)
find(x-> x==initialPopulation[1][6] ,initialPopulation[1])

v = Crossover(initialPopulation[1], initialPopulation[2])

initialPopulation[end][end]

sortByFitness(initialPopulation[1], fitness, some)

function fitness(person::Array, problem::Problem)
  fit = problem.weight(1, person[1])
  for i=1:(length(person)-1)
    fit += problem.weight(person[i], person[i+1])
  end
  fit += problem.weight(person[end], 1)
  return fit
end

function sortByFitness(population, fitness::Function, problem::Problem)
  l = length(population)
  sorted = Array(Any, l,2)

  sorted[:,1] = population
  for i=1:l
    sorted[i,2] = fitness(sorted[i,1])
  end

  return sortrows(sorted, by=x->(x[2]))
end

s = Array(Any, 3,2)
s[1] = 1
s[2] = 4
s[3] = 2
s[4] = 4
s[:,1] = initialPopulation[1:2]
s[:,2] = [2 4]
sortrows(s, by=x->(x[2]), rev=true)
