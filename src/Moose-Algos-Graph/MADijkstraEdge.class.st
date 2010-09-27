Class {
	#name : #MADijkstraEdge,
	#superclass : #MAWeightedEdge,
	#instVars : [
		'visited'
	],
	#category : #'Moose-Algos-Graph'
}

{ #category : #initialization }
MADijkstraEdge >> initialize [ 

	super initialize.
	weight := 1.
	visited := false
]

{ #category : #accessing }
MADijkstraEdge >> isVisited [

	^ visited
]

{ #category : #accessing }
MADijkstraEdge >> visited: aBoolean [

	visited := aBoolean 
]
