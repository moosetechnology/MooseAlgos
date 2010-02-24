Class {
	#name : #MAFCAElement,
	#superclass : #Object,
	#instVars : [
		'index',
		'bits',
		'value'
	],
	#category : #'Moose-Algos-FormalConceptAnalysis'
}

{ #category : #'initialize-release' }
MAFCAElement class >> with: anObject [
	
	^self basicNew initialize: anObject
]

{ #category : #private }
MAFCAElement >> appendTo: aCollection [
	
	index := aCollection size.
	aCollection add: self
]

{ #category : #accessing }
MAFCAElement >> bits [
	
	^bits
]

{ #category : #'initialize-release' }
MAFCAElement >> initialize: anObject [
	
	value := anObject.
	index := nil.
	bits := 0
]

{ #category : #accessing }
MAFCAElement >> mask [
	
	^1 << index
]

{ #category : #printing }
MAFCAElement >> printOn: aStream [
	
	self value printOn: aStream
]

{ #category : #accessing }
MAFCAElement >> setBit: crossingElement [
	
	bits := bits maskSet: crossingElement mask
]

{ #category : #accessing }
MAFCAElement >> value [
	
	^value
]
