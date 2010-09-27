Class {
	#name : #MADominanceNode,
	#superclass : #MADisjointSetNode,
	#instVars : [
		'previousNodes',
		'uniqueSource'
	],
	#category : #'Moose-Algos-Graph'
}

{ #category : #accessing }
MADominanceNode >> dominantNode [

	^ self find
]

{ #category : #accessing }
MADominanceNode >> firstSource [

	^ previousNodes first
]

{ #category : #accessing }
MADominanceNode >> flagUnique [

	uniqueSource := true
]

{ #category : #accessing }
MADominanceNode >> from: sourceNode [

	previousNodes add: sourceNode 
]

{ #category : #accessing }
MADominanceNode >> hasUniqueSource [
	^ self previousNodes size = 1
]

{ #category : #accessing }
MADominanceNode >> initialize [

	previousNodes := OrderedCollection new.
	uniqueSource := false
]

{ #category : #accessing }
MADominanceNode >> isDominant [
	"A node is dominant if it has been flagged as the unique Source by one of its target
	 AND it is its own parent in the partition"
	^ uniqueSource and: [self find = self]
]

{ #category : #accessing }
MADominanceNode >> isDominated [

	^ self isDominant not and: [self find isDominant]
]

{ #category : #accessing }
MADominanceNode >> label [

	^ 'Dm '
]

{ #category : #accessing }
MADominanceNode >> previousNodes [
	^ previousNodes
]
