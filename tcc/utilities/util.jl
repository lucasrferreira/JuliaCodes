function checkParameters(params::Dict, args...)
  for key in keys(params)
    found = false;
    for parameter in args
      if key == parameter
        found = true;
        break
      end
    end
    if !found
      warn("Not found key $key.");
    end
  end
end

function calculateMean(data, elements, column)
  mean_elements = zeros(elements, 1);

  global_mean = mean(data[find(r-> r != 0, data)]);

  for i=1:elements
    if column == 1
      mean_elements[i,1] = mean(data[i, find(r -> r != 0, data[i,:])]);
    else
      mean_elements[i,1] = mean(data[find(r -> r != 0, data[:, i]), i]);
    end
    if isnan(mean_elements[i,1])
      mean_elements[i,1] = global_mean;
    end
  end

  return mean_elements
end

function checkingRatingsBoundary!(predictions::Array, preferences::Array)
  predictions[find(r-> r > maximum(preferences), predictions)] = maximum(preferences);
  predictions[find(r-> r < minimum(preferences), predictions)] = minimum(preferences);
end

function splitKFold(y, num_folds)
  i = shuffle([1:y]);
  fold_size = int(floor(y/num_folds));
  remainder = y-num_folds*fold_size;
  groups = zeros(Int, y);
  cursor = 1;
  group = 1;

  while cursor<=y
    this_fold_size = group <= remainder ? fold_size+1:fold_size;
    groups[i[cursor:cursor+this_fold_size-1]] = group;
    group += 1;
    cursor += this_fold_size;
  end

  return groups;
end

function trunkRatings(predicted, preferences)
  n = size(predicted)[1]

  predicted_trunk = zeros(n,1)

  for i=1:n
    predicted_trunk[i,1] = preferences[find(r->r == minimum(abs(predicted[i]-preferences)), abs(predicted[i]-preferences))][1]
  end

  return predicted_trunk
end
