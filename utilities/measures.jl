#Mean absolute error (MAE)
mae(labels, predicted) = mean(abs(predicted[find(r -> r > 0, predicted),1] - labels[find(r -> r > 0, predicted),1]));


#Root mean squared error (RMSE)
function rmse(labels, predicted)
  s = 0.0

  A = predicted[find(r -> r > 0, predicted),1] - labels[find(r -> r > 0, predicted),1];

  for a in A
    s += a*a
  end
  return sqrt(s / length(A))
end

#Coverage
coverage(predicted) = length(find(r-> r > 0, predicted[:,1])) ./ length(predicted[:,1]);
