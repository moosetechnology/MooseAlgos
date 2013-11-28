"
This class models no action with a null pattern.
"
Class {
	#name : #MalNullObjectAction,
	#superclass : #MalObjectAction,
	#category : #'Moose-Algos-ObjectTraverser'
}

{ #category : #hooks }
MalNullObjectAction >> executeOnObject: anInteger [ 
	"do nothing"
]

{ #category : #hooks }
MalNullObjectAction >> executeOnRelationFrom: originObject to: targetObject [
	"do nothing"
	
]
