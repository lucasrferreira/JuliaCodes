using DataFrames


type Dataset
  file::DataFrame
  num_of_cost::Int32

	getArray::Function
  getMatrix::Function

  function Dataset(filename = "instances/r101.in")
    this = new()
    if !isfile(filename)
      if isfile(string("../",filename))
        filename = string("../",filename);
      end
    end

    this.file = readtable(filename, separator = ' ', header = false)

    names!(this.file, [:no_cost, :x, :y, :demand, :ready_time, :due_time, :service_time])
    this.file = this.file[[:no_cost, :x, :y, :demand]]
    this.num_of_cost = maximum(this.file[:no_cost])

    this.getMatrix = function()
        return createMatrix(this)
    end

		this.getArray = function()
      	return array(this.file[:,:])
    end

    return this
  end
end

function createMatrix(data::Dataset)
  return sparse(data.file[:user], data.file[:item], data.file[:rating], data.users, data.items);
end
