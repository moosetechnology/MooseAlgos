Class {
	#name : #MOWeightedHitsNode,
	#superclass : #MOHitsNode,
	#traits : 'MATEdgeNode',
	#classTraits : 'MATEdgeNode classTrait',
	#instVars : [
		'nextEdges',
		'previousEdges'
	],
	#category : #'Moose-Algos-Graph'
}

{ #category : #initialization }
MOWeightedHitsNode >> initialize [

	previousEdges := OrderedCollection new.
	nextEdges := OrderedCollection new.
]

{ #category : #printing }
MOWeightedHitsNode >> label [

	^ 'WH '
]

{ #category : #accessing }
MOWeightedHitsNode >> nextEdges [

	^ nextEdges
]

{ #category : #accessing }
MOWeightedHitsNode >> previousEdges [

	^ previousEdges
]
