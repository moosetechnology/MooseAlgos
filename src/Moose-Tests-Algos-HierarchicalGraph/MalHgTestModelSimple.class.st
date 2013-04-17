Class {
	#name : #MalHgTestModelSimple,
	#superclass : #MalHgEntityWrapper,
	#instVars : [
		'parent',
		'children',
		'level'
	],
	#category : #'Moose-Tests-Algos-HierarchicalGraph'
}

{ #category : #accessing }
MalHgTestModelSimple >> children [
	^ children
]

{ #category : #accessing }
MalHgTestModelSimple >> children: anObject [
	children := anObject
]

{ #category : #'initialize-release' }
MalHgTestModelSimple >> initialize [
	children := OrderedCollection new.
]

{ #category : #accessing }
MalHgTestModelSimple >> level [
	^ level
]

{ #category : #accessing }
MalHgTestModelSimple >> level: aNumber [
	level := aNumber.
]

{ #category : #accessing }
MalHgTestModelSimple >> parent [
	^ parent
]

{ #category : #accessing }
MalHgTestModelSimple >> parent: anObject [
	parent := anObject
]

{ #category : #accessing }
MalHgTestModelSimple >> printOn: aStream [
	aStream
		nextPutAll: 'Test: ';
		nextPutAll: entity asString.
]
