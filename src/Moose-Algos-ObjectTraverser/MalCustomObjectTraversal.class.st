"
This class simply defines the traversal through a block that gets executed for each object
"
Class {
	#name : #MalCustomObjectTraversal,
	#superclass : #MalObjectTraversal,
	#instVars : [
		'traversalBlock'
	],
	#category : #'Moose-Algos-ObjectTraverser'
}

{ #category : #'instance creation' }
MalCustomObjectTraversal class >> with: aBlock [
	^ self new 
		traversalBlock: aBlock
]

{ #category : #private }
MalCustomObjectTraversal >> objectsToTraverseFrom: anObject do: aBlock [
	^ (traversalBlock value: anObject) do: aBlock
]

{ #category : #accessing }
MalCustomObjectTraversal >> traversalBlock: aBlock [
	traversalBlock := aBlock
]
