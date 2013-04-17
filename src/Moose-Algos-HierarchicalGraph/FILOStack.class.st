Class {
	#name : #FILOStack,
	#superclass : #Stack,
	#category : #'Moose-Algos-HierarchicalGraph'
}

{ #category : #adding }
FILOStack >> push: anObject [
	self addLast: anObject.
	^ anObject.
]
