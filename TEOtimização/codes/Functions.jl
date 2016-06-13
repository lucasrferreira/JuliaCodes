function populationGerator(_in::Vector, qnt::Int)
  _out = Array(Array{Int},qnt)
  for i=1:qnt
    _out[i] = shuffle(_in)
  end
  return _out
end


function Crossover(dad::Array, mon::Array)
  _length = length(dad)
  cut1 = rand(1:_length)
  cut2 = rand(cut1:_length)

  partInDad = dad[cut1:cut2]
  partInMon = mon[cut1:cut2]
  initDad = dad[1:cut1-1]
  initMon = mon[1:cut1-1]
  endDad = dad[cut2+1:end]
  endMon = mon[cut2+1:end]

  @show dad
  @show initDad
  @show partInDad
  @show endDad

  son1 = zeros(Int, _length)
  son2 = zeros(Int, _length)

  son1[cut1:cut2] = partInDad
  son2[cut1:cut2] = partInMon


  for i=1:length(initDad)
    while initDad[i] in partInMon
      @show i
      @show initDad[i]
      index = find(x-> x == initDad[i], partInMon)[1]
      @show index, son2[index]
      @show partInDad[index]
      initDad[i] = partInDad[index]
      print();
    end

    while initMon[i] in partInDad
      index = find(x-> x == initMon[i], partInDad)[1]
      initMon[i] = partInMon[index]
    end
  end

  for i=1:length(endDad)
    while endDad[i] in partInMon
      index = find(x-> x == endDad[i], partInMon)[1]
      endDad[i] = partInDad[index]
    end

    while endMon[i] in partInDad
      index = find(x-> x == endMon[i], partInDad)[1]
      endMon[i] = partInMon[index]
    end
  end

  son1[1:cut1-1] = initMon
  son2[1:cut1-1] = initDad
  son1[cut2+1:end] = endMonv  son2[cut2+1:end] = endDad

  return (dad, mon, son1, son2)
end

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
    sorted[i,2] = fitness(sorted[i,1], some)
  end

  return sortrows(sorted, by=x->(x[2]))
end
