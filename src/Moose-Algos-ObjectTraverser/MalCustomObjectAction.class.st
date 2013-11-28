"
This class models a custom action that can be parameterized through blocks:
- the objectAction is a block triggered for every traversed object
- the relationAction is a block that takes two arguments and it is triggered for each object relation
"
Class {
	#name : #MalCustomObjectAction,
	#superclass : #MalObjectAction,
	#instVars : [
		'objectAction',
		'relationAction'
	],
	#category : #'Moose-Algos-ObjectTraverser'
}

{ #category : #hooks }
MalCustomObjectAction >> executeOnObject: anObject [
	^ self objectAction value: anObject
]

{ #category : #hooks }
MalCustomObjectAction >> executeOnRelationFrom: originObject to: targetObject [
	^ self relationAction value: originObject value: targetObject
]

{ #category : #initialization }
MalCustomObjectAction >> initialize [
	objectAction := [ :object | ].
	relationAction := [ :origin :target | ]
]

{ #category : #hooks }
MalCustomObjectAction >> objectAction [
	^ objectAction
]

{ #category : #hooks }
MalCustomObjectAction >> objectAction: aBlockWithOneArgument [
	objectAction := aBlockWithOneArgument
]

{ #category : #hooks }
MalCustomObjectAction >> relationAction [
	^ relationAction
]

{ #category : #hooks }
MalCustomObjectAction >> relationAction: aBlockWithTwoArguments [
	relationAction := aBlockWithTwoArguments
]
