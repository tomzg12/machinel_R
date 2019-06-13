

  library(recommenderlab)
  library(ggplot2)
  
  data("MovieLense")

  # Subset de dataframe original
  rating_movies <- MovieLense[rowCounts(MovieLense)>50,
                              colCounts(MovieLense)>100]

  
  n_folds <- 4
  items_to_keep <- 15
  rating_treshold <- 3  
  eval_sets <- evaluationScheme(data = rating_movies,
                                method = 'cross-validation',
                                k = n_folds,
                                given = items_to_keep,
                                goodRating = rating_treshold)  
  
  size_Sets <- sapply(eval_sets@runsTrain, length)
  size_Sets  
  