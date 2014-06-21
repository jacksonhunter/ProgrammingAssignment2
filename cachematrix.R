## this contains a function to create a cache matrix and a function to
## report the cached inverese of that matrix
## control for whether or not the inverse is calculated or if the cache is
## retrieved is in the cache matrix, rather than in the solveCache function

# makeCacheMatrix( x ) creates a list of 3 functions in an environment
# containing the varriables "x" (the matrix created in the arguments) and 
# "inverse" which contains the inverse of the matrix x if the function 
# getInverse() has been called, or NULL if the matrix is new.

makeCacheMatrix <- function(x = matrix()) {
    
    inverse <- NULL
    
    #this function returns the value of the marix x
    
    get <- function() {
        x
    }
    
    #this function replaces the matrix x with a new matrix
    #if the matricies are not identical the inverse is reset
    #put() gives more function to the cacheMatrix, but
    #it is unneed for minimum required function and unused.
    
    put <- function( y = matrix() ) {
        
        if( !identical( x, y ) ) {
        
            inverse <<- NULL  #inverse = NULL flags that a new solution is needed
        }
        x <<- y
        
    }
    
    #having 2 functions for getting and putting the inverse is needless
    #and complex.  here we have one function which gives the inverse if
    #cached and calculates the inverseif needed.
    
    getInverse <- function() {
                                   #putting the if here greatly simplifies code later        
        if( is.null( inverse ) ) { #inverese = NULL on 1st run or after put()
        	message( "solving...")
            inverse <<- solve( x )  #calculates inverse and stores it in cache
        }  
            
        inverse                   #returns the cached inverse    
        
    }
    
    list( get = get, put = put, getInverse = getInverse )
}


#cache solve is just a wraper which calls function to solve the inverse
#when it is needed or quickly report the cached inverse if it has already
#been solved.  since in my implementation getInverse() has an if statement
#that solves the inverse if nessicary, the function required here is very simple.

cacheSolve <- function(x, ...) {
    
    x$getInverse()
}
