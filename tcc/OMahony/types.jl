using DataFrames

type Dataset
  file::DataFrame
  users::Int32
  items::Int32
  size::Int32
  preferences::Array

  getMatrix::Function

  function Dataset()
    this = new()
    local filename = "datasets/user.data"
    if !isfile(filename)
      if !isfile("/datasets/user.data")
        if isfile("../datasets/user.data")
          filename = string("../datasets/user.data");
        end
      end
    end


    this.file = readtable(filename, separator = '\t', header = false)

    names!(this.file, [:user, :item, :rating, :time])

    this.users = maximum(this.file[:user])

    this.items = maximum(this.file[:item])

    this.size = size(this.file)[1]

    this.preferences = sort(unique(this.file[:rating]));

    this.getMatrix = function()
        return createMatrix(this);
    end

    return this
  end

  function Dataset(data::DataFrame, users, items, preferences)
    this = new()

    this.file = data;

    this.users = users

    this.items = items

    this.preferences = preferences;

    this.size = size(this.file)[1];

    this.getMatrix = function()
        return createMatrix(this);
    end

    return this
  end
end

function createMatrix(data::Dataset)
  return sparse(data.file[:user], data.file[:item], data.file[:rating], data.users, data.items);
end
