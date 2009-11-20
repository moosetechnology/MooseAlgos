Class {
	#name : #MOGraphEdge,
	#superclass : #Object,
	#instVars : [
		'model',
		'from',
		'to'
	],
	#category : #'Moose-Algos-Graph'
}

{ #category : #'as yet unclassified' }
MOGraphEdge class >> with: aModel [

	^ self new model: aModel
]

{ #category : #accessing }
MOGraphEdge >> asTuple [

	^ {from model. to model}
]

{ #category : #accessing }
MOGraphEdge >> from [
	^ from
]

{ #category : #accessing }
MOGraphEdge >> from: anObject [
	from := anObject
]

{ #category : #accessing }
MOGraphEdge >> model [
	^ model
]

{ #category : #accessing }
MOGraphEdge >> model: aModel [
	
	model := aModel
]

{ #category : #accessing }
MOGraphEdge >> printString [

	^ self from printString, ' -> ', self to printString
]

{ #category : #accessing }
MOGraphEdge >> to [
	^ to
]

{ #category : #accessing }
MOGraphEdge >> to: anObject [
	to := anObject
]
