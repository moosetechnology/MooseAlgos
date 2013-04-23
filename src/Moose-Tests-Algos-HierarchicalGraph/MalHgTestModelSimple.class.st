Class {
	#name : #MalHgTestModelSimple,
	#superclass : #Object,
	#instVars : [
		'model',
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
MalHgTestModelSimple >> model [
	^ model
]

{ #category : #accessing }
MalHgTestModelSimple >> model: anObject [
	model := anObject
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
		nextPutAll: model asString.
]
