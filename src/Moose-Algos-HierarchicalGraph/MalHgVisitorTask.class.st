Class {
	#name : #MalHgVisitorTask,
	#superclass : #Object,
	#category : #'Moose-Algos-HierarchicalGraph'
}

{ #category : #visitor }
MalHgVisitorTask >> finish [
	self subclassResponsibility 	
]

{ #category : #visitor }
MalHgVisitorTask >> visit: aNode [
	self subclassResponsibility 	
]
