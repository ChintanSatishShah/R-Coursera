## Pair of functions that cache the inverse of a matrix.
## 1st Function creates a list that stores a numeric Matrix and 2nd function caches its Inverse, if not available.
## Assumption: Input matrix supplied is always invertible

## makeCacheMatrix creates a special "vector", which is actually a list containing a function to
## 1. set the value of the Matrix
## 2. get the value of the Matrix
## 3. set the value of the Inverse Matrix 
## 4. get the value of the Inverse Matrix 
makeCacheMatrix <- function(x = matrix()) {
	invMat <- NULL
	set <- function(y) {
		x <<- y
		invMat <<- NULL
	}
   	
	get <- function() x
    	
	setInvMat <- function(invert) invMat <<- invert
     
	getInvMat <- function() invMat

	list(set = set, get = get,
 		setInvMat = setInvMat,
		getInvMat = getInvMat)
}

## Calculates the Inverse of the special "matrix" created with the above function. 
## However, it first checks to see if the Inverse has already been calculated. 
## If so, it gets the Inverse from the cache and skips the computation. 
## Otherwise, it calculates the Inverse of the data and sets the value of the Inverse in the cache via the setInvMat function.
cacheSolve <- function(x, ...) {

	## Return a matrix that is the inverse of 'x'
	invMat <- x$getInvMat()
	
	if(!is.null(invMat)) {
		message("getting cached data")
		return(invMat)
     	}
        
	data <- x$get()
	message("Inverse not found in Cache. Calculating Inverse Matrix")
      invMat <- solve(data, ...)
      x$setInvMat(invMat)
      invMat
}
