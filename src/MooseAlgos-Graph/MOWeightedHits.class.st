Class {
	#name : #MOWeightedHits,
	#superclass : #MOHits,
	#category : #'MooseAlgos-Graph'
}

{ #category : #running }
MOWeightedHits >> computeAuthoritiesFor: aNode [

	aNode auth: (aNode previousEdges inject: 0 into: [:s :e| s + (e weight * e from hub)])
]

{ #category : #running }
MOWeightedHits >> computeHubsFor: aNode [

	aNode hub: (aNode nextEdges inject: 0 into: [:s :e| s + (e weight * e to auth)])
]

{ #category : #configuration }
MOWeightedHits >> edgeClass [

	^ MOWeightedEdge
]

{ #category : #configuration }
MOWeightedHits >> nodeClass [

	^ MOWeightedHitsNode 
]
