include("types.jl")

type RecsysAlgorithm
  train_index::Array{Int32,1}
  test_index::Array{Int32,1}
  margin::Real

  dataset::Dataset

  getTrainData::Function
  getTestData::Function

  similarity::Function
  run::Function

    function RecsysAlgorithm(margin::Real = 0.8, dataset::Dataset = Dataset(), similarity::Function)
      this = new ()
      this.similarity = similarity
      this.dataset = dataset
      this.margin = margin

      index = shuffle([1:this.dataset.size])

      this.train_index = find(r -> r < this.dataset.size * margin, index)
      this.test_index = find(r -> r >= this.dataset.size * margin, index)

      this.getTrainData = function()
        return Dataset(this.dataset.file[this.train_index,:], this.dataset.users, this.dataset.items, this.dataset.preferences)
      end

      this.getTestData = function()
        return array(this.dataset.file[this.test_index,:])
      end

      # this.createModel()

      # --- Mudar A forma de rodar!!!
      # this.run = function(createModel::Function)
      #   tic();
      #   model::CFModel = createModel(this.getTrainData());
      #
      #   predict = model.predict(this.getTestData()[:,1:2]);
      #
      #   time = toq();
      #
      #   labels = this.getTestData()[:,3];
      #   predict_trunk = trunkRatings(predict, this.dataset.preferences);
      #
      #   df = DataFrame()
      #   df[:mae] = mae(labels, predict);
      #   df[:mae_trunk] = mae(labels, predict_trunk);
      #   df[:rmse] = rmse(labels, predict);
      #   df[:rmse_trunk] = rmse(labels, predict_trunk);
      #   df[:coverage] = coverage(predict);
      #   df[:time] = time;
      #
      #   return df
      # end

      return this
    end
end

type OMahonyModel
  w::SparseMatrixCSC
  neighbour::Array
  rating_averaged::Array
  rating_max::Int
  rating_min::Int
  th::Real

  c(r, p) = abs(r - p)/(rating_max - rating_min)
  weight::Function
  significance::Function

  function OMahonyModel(data::Dataset, th::Real)
    this = new()
    data_matrix = data.getMatrix()

    # nom_zero_index = find(r -> r != 0, data_matrix)
    rating_max = maximum(nonzeros(data_matrix));
    rating_min = minimum(nonzeros(data_matrix));

    rows = unique(rowvals(data_matrix))
    rating_averaged = zeros(length(rows))
    for i=1 : length(rows)
      rating_averaged[i] = mean(nonzeros(data_matrix[i,:]))

      # Aproveitar esse loop para outros calculos
    end

    return this
  end
end

dataset = Dataset()
