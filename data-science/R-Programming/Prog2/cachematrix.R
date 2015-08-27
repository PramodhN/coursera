## Coursera - R Programming - Programming assignment 2

## Create a cache matrix

# The first function, makeVector creates a special "matrix", 
# which is really a list containing a function to
# 1. Set the value of the matrix
# 2. Get the value of the matrix
# 3. Set the value of the inverse matrix
# 4. Get the value of the inverse matrix
makeCacheMatrix <- function(x = matrix()) {
  inverse_matrix <- NULL
  
  set_matrix <- function(y) {
    x <<- y
    inverse_matrix <<- NULL
  }
  
  get_matrix <- function() x
  
  set_inverse_matrix <- function(solve_inverse) inverse_matrix <<- solve_inverse
  
  get_inverse_matrix <- function() inverse_matrix
  
  list(set_matrix = set_matrix, get_matrix = get_matrix, 
       set_inverse_matrix = set_inverse_matrix, 
       get_inverse_matrix = get_inverse_matrix)
}

# The following function calculates the inverse of the special "matrix"
# created with the above function. 
cacheSolve <- function(x, ...) {

  inverse_matrix <- x$get_inverse_matrix()
  
  if(!is.null(inverse_matrix)){
    message("Getting cached inverse...")
    return(inverse_matrix)
  }
  
  matrix <- x$get_matrix()
  
  inverse_matrix <- solve(matrix)
  
  x$set_inverse_matrix(inverse_matrix)
  
  inverse_matrix
}
