Class {
	#name : #MalFCAElement,
	#superclass : #Object,
	#instVars : [
		'index',
		'bits',
		'value'
	],
	#category : #'Moose-Algos-FormalConceptAnalysis'
}

{ #category : #initialization }
MalFCAElement class >> with: anObject [
	
	^self basicNew initialize: anObject
]

{ #category : #private }
MalFCAElement >> appendTo: aCollection [
	
	index := aCollection size.
	aCollection add: self
]

{ #category : #accessing }
MalFCAElement >> bits [
	
	^bits
]

{ #category : #initialization }
MalFCAElement >> initialize: anObject [
	
	value := anObject.
	index := nil.
	bits := 0
]

{ #category : #accessing }
MalFCAElement >> mask [
	
	^1 << index
]

{ #category : #printing }
MalFCAElement >> printOn: aStream [
	
	self value printOn: aStream
]

{ #category : #accessing }
MalFCAElement >> setBit: crossingElement [
	
	bits := bits maskSet: crossingElement mask
]

{ #category : #evaluating }
MalFCAElement >> value [
	
	^value
]
