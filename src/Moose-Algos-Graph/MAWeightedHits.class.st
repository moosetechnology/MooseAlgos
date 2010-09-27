Class {
	#name : #MAWeightedHits,
	#superclass : #MAHits,
	#category : #'Moose-Algos-Graph'
}

{ #category : #running }
MAWeightedHits >> computeAuthoritiesFor: aNode [

	aNode auth: (aNode previousEdges inject: 0 into: [:s :e| s + (e weight * e from hub)])
]

{ #category : #running }
MAWeightedHits >> computeHubsFor: aNode [

	aNode hub: (aNode nextEdges inject: 0 into: [:s :e| s + (e weight * e to auth)])
]

{ #category : #configuration }
MAWeightedHits >> edgeClass [

	^ MAWeightedEdge
]

{ #category : #configuration }
MAWeightedHits >> nodeClass [

	^ MAWeightedHitsNode 
]
