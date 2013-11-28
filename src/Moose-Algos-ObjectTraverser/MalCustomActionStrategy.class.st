"
This class models a custom action that can be parameterized through blocks:
- the objectAction is a block triggered for every traversed object
- the relationAction is a block that takes two arguments and it is triggered for each object relation
"
Class {
	#name : #MalCustomActionStrategy,
	#superclass : #MalActionStrategy,
	#instVars : [
		'objectAction',
		'relationAction'
	],
	#category : #'Moose-Algos-ObjectTraverser'
}

{ #category : #hooks }
MalCustomActionStrategy >> executeOnObject: anObject [
	^ self objectAction value: anObject
]

{ #category : #hooks }
MalCustomActionStrategy >> executeOnRelationFrom: originObject to: targetObject [
	^ self relationAction value: originObject value: targetObject
]

{ #category : #initialization }
MalCustomActionStrategy >> initialize [
	objectAction := [ :object | ].
	relationAction := [ :origin :target | ]
]

{ #category : #hooks }
MalCustomActionStrategy >> objectAction [
	^ objectAction
]

{ #category : #hooks }
MalCustomActionStrategy >> objectAction: aBlockWithOneArgument [
	objectAction := aBlockWithOneArgument
]

{ #category : #hooks }
MalCustomActionStrategy >> relationAction [
	^ relationAction
]

{ #category : #hooks }
MalCustomActionStrategy >> relationAction: aBlockWithTwoArguments [
	relationAction := aBlockWithTwoArguments
]
