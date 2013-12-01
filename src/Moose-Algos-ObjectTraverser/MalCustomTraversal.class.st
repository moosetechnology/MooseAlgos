"
This class simply defines the traversal through a block that gets executed for each object
"
Class {
	#name : #MalCustomTraversal,
	#superclass : #MalTraversal,
	#instVars : [
		'traversalBlock'
	],
	#category : #'Moose-Algos-ObjectTraverser'
}

{ #category : #'instance creation' }
MalCustomTraversal class >> with: aBlock [
	^ self new 
		traversalBlock: aBlock
]

{ #category : #private }
MalCustomTraversal >> objectsToTraverseFrom: anObject do: aBlock [
	^ (traversalBlock value: anObject) asOrderedCollection do: aBlock
]

{ #category : #accessing }
MalCustomTraversal >> traversalBlock: aBlock [
	traversalBlock := aBlock
]
