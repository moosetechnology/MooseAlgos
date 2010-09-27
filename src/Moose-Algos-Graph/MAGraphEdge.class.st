Class {
	#name : #MAGraphEdge,
	#superclass : #Object,
	#instVars : [
		'model',
		'from',
		'to'
	],
	#category : #'Moose-Algos-Graph'
}

{ #category : #'as yet unclassified' }
MAGraphEdge class >> with: aModel [

	^ self new model: aModel
]

{ #category : #accessing }
MAGraphEdge >> asTuple [

	^ {from model. to model}
]

{ #category : #accessing }
MAGraphEdge >> from [
	^ from
]

{ #category : #accessing }
MAGraphEdge >> from: anObject [
	from := anObject
]

{ #category : #accessing }
MAGraphEdge >> model [
	^ model
]

{ #category : #accessing }
MAGraphEdge >> model: aModel [
	
	model := aModel
]

{ #category : #accessing }
MAGraphEdge >> printString [

	^ self from printString, ' -> ', self to printString
]

{ #category : #accessing }
MAGraphEdge >> to [
	^ to
]

{ #category : #accessing }
MAGraphEdge >> to: anObject [
	to := anObject
]
