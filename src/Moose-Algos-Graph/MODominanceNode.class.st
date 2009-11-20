Class {
	#name : #MODominanceNode,
	#superclass : #MODisjointSetNode,
	#instVars : [
		'previousNodes',
		'uniqueSource'
	],
	#category : #'Moose-Algos-Graph'
}

{ #category : #accessing }
MODominanceNode >> dominantNode [

	^ self find
]

{ #category : #accessing }
MODominanceNode >> firstSource [

	^ previousNodes first
]

{ #category : #accessing }
MODominanceNode >> flagUnique [

	uniqueSource := true
]

{ #category : #accessing }
MODominanceNode >> from: sourceNode [

	previousNodes add: sourceNode 
]

{ #category : #accessing }
MODominanceNode >> hasUniqueSource [
	^ self previousNodes size = 1
]

{ #category : #accessing }
MODominanceNode >> initialize [

	previousNodes := OrderedCollection new.
	uniqueSource := false
]

{ #category : #accessing }
MODominanceNode >> isDominant [
	"A node is dominant if it has been flagged as the unique Source by one of its target
	 AND it is its own parent in the partition"
	^ uniqueSource and: [self find = self]
]

{ #category : #accessing }
MODominanceNode >> isDominated [

	^ self isDominant not and: [self find isDominant]
]

{ #category : #accessing }
MODominanceNode >> label [

	^ 'Dm '
]

{ #category : #accessing }
MODominanceNode >> previousNodes [
	^ previousNodes
]
