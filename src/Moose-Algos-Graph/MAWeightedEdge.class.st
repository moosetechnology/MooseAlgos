Class {
	#name : #MAWeightedEdge,
	#superclass : #MAGraphEdge,
	#instVars : [
		'weight'
	],
	#category : #'Moose-Algos-Graph'
}

{ #category : #accessing }
MAWeightedEdge >> asTuple [

	^ {from model. to model. weight}
]

{ #category : #accessing }
MAWeightedEdge >> printString [

	^ self from printString, ' -> ', self to printString, ' (', self weight printString, ')'
]

{ #category : #accessing }
MAWeightedEdge >> weight [
	^ weight
]

{ #category : #accessing }
MAWeightedEdge >> weight: anObject [
	weight := anObject
]
