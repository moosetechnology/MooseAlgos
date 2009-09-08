Class {
	#name : #MOWeightedHitsNode,
	#superclass : #MOHitsNode,
	#instVars : [
		'nextEdges',
		'previousEdges'
	],
	#category : #'MooseAlgos-Graph'
}

{ #category : #'as yet unclassified' }
MOWeightedHitsNode >> from: aNode edge: anEdge [

	previousEdges add: anEdge
]

{ #category : #'as yet unclassified' }
MOWeightedHitsNode >> initialize [

	previousEdges := OrderedCollection new.
	nextEdges := OrderedCollection new.
]

{ #category : #'as yet unclassified' }
MOWeightedHitsNode >> label [

	^ 'WH '
]

{ #category : #'as yet unclassified' }
MOWeightedHitsNode >> nextEdges [

	^ nextEdges
]

{ #category : #'as yet unclassified' }
MOWeightedHitsNode >> previousEdges [

	^ previousEdges
]

{ #category : #'as yet unclassified' }
MOWeightedHitsNode >> to: aNode edge: anEdge [

	nextEdges add: anEdge
]
