"
This class models no action with a null pattern.
"
Class {
	#name : #MalNullActionStrategy,
	#superclass : #MalActionStrategy,
	#category : #'Moose-Algos-ObjectTraverser'
}

{ #category : #hooks }
MalNullActionStrategy >> executeOnObject: anInteger [ 
	"do nothing"
]

{ #category : #hooks }
MalNullActionStrategy >> executeOnRelationFrom: originObject to: targetObject [
	"do nothing"
	
]
