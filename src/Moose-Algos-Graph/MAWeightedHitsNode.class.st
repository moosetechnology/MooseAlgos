Class {
	#name : #MAWeightedHitsNode,
	#superclass : #MAHitsNode,
	#traits : 'MATEdgeNode',
	#classTraits : 'MATEdgeNode classTrait',
	#instVars : [
		'nextEdges',
		'previousEdges'
	],
	#category : #'Moose-Algos-Graph'
}

{ #category : #initialization }
MAWeightedHitsNode >> initialize [

	previousEdges := OrderedCollection new.
	nextEdges := OrderedCollection new.
]

{ #category : #printing }
MAWeightedHitsNode >> label [

	^ 'WH '
]

{ #category : #accessing }
MAWeightedHitsNode >> nextEdges [

	^ nextEdges
]

{ #category : #accessing }
MAWeightedHitsNode >> previousEdges [

	^ previousEdges
]
