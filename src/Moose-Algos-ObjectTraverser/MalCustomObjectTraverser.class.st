Class {
	#name : #MalCustomObjectTraverser,
	#superclass : #MalObjectTraverser,
	#instVars : [
		'traversal'
	],
	#category : #'Moose-Algos-ObjectTraverser'
}

{ #category : #'instance creation' }
MalCustomObjectTraverser class >> with: aBlock [
	^ self new traversal: aBlock
]

{ #category : #private }
MalCustomObjectTraverser >> objectToTraverseFrom: anObject do: aBlock [
	^ (self traversal value: anObject) do: aBlock
]

{ #category : #accessing }
MalCustomObjectTraverser >> traversal [
	^ traversal
]

{ #category : #accessing }
MalCustomObjectTraverser >> traversal: aBlock [
	traversal := aBlock
]
