include("Dataset.jl")

type Problem
  instance::Array
  root::Array
  getIds::Function
  weight::Function
  getIndex::Function
  getDemand::Function

  function Problem(dataSet = Dataset(), size = 25)
    this = new()
    this.instance = dataSet.getArray()[1:size+1, :]
    this.root = dataSet.getArray()[1,:]
    this.weight = function(i, j)
      return sqrt( (this.instance[i, 2] - this.instance[j, 2])^2 + (this.instance[i, 3] - this.instance[i, 3])^2 )
    end
    this.getIndex = function(i)
      return this.instance[i, :]
    end
    this.getIds = function()
      return this.instance[2:end,1]
    end
    this.getDemand = function(i)
      return this.instance[i, 4]
    end
    return this
  end
end
