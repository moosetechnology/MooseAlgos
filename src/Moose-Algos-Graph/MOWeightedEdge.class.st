Class {
	#name : #MOWeightedEdge,
	#superclass : #MOGraphEdge,
	#instVars : [
		'weight'
	],
	#category : #'Moose-Algos-Graph'
}

{ #category : #accessing }
MOWeightedEdge >> asTuple [

	^ {from model. to model. weight}
]

{ #category : #accessing }
MOWeightedEdge >> printString [

	^ self from printString, ' -> ', self to printString, ' (', self weight printString, ')'
]

{ #category : #accessing }
MOWeightedEdge >> weight [
	^ weight
]

{ #category : #accessing }
MOWeightedEdge >> weight: anObject [
	weight := anObject
]
