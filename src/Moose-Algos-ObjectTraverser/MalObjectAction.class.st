"
This class models an action that is triggered both on each traversed object, and on each relation between two objects. The action is triggered exactly once per object/relation occurrence.
"
Class {
	#name : #MalObjectAction,
	#superclass : #Object,
	#category : #'Moose-Algos-ObjectTraverser'
}

{ #category : #hooks }
MalObjectAction >> executeOnObject: anObject [
	self subclassResponsibility 
]

{ #category : #hooks }
MalObjectAction >> executeOnRelationFrom: originObject to: targetObject [
	self subclassResponsibility
]
