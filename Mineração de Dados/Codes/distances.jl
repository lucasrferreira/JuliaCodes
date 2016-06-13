using Distances
Dis = Distances

type EuclideanDistMatrix
  num_of_itens::Int
  num_of_features::Int
  itens_features
  distanceMatrix
  function EuclideanDistMatrix(itens_features)
    this = new()
    this.itens_features = itens_features
    this.num_of_itens = size(itens_features)[1]
    this.num_of_features = size(itens_features)[2]
    this.distanceMatrix = zeros(this.num_of_itens, this.num_of_itens)
    for i=1:this.num_of_itens
      for j=1:this.num_of_itens
        this.distanceMatrix[i,j] = Dis.evaluate(Dis.Euclidean(), itens_features[i,:][:], itens_features[j,:][:])
      end
    end

    return this
  end
end
