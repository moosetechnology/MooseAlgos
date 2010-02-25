"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MAColumnMatrix,
	#superclass : #MAMatrix,
	#instVars : [
		'columns'
	],
	#category : #'Moose-Algos-LinearAlgebra'
}

{ #category : #accessing }
MAColumnMatrix >> at: row and: column [
	
	^(columns at: column) at: row
]

{ #category : #accessing }
MAColumnMatrix >> at: row and: column put: aNumber [
	
	^(columns at: column) at: row put: aNumber
]

{ #category : #private }
MAColumnMatrix >> checkInvariant [
	
	^columns isCollection
		and:
			[(columns allSatisfy: [:vector | vector isKindOf: self vectorSpecies])
				and: [columns allSatisfy: [:vector | vector size = self rowSize]]]
]

{ #category : #'accessing vectorwise' }
MAColumnMatrix >> columnAt: column [
	
	^columns at: column
]

{ #category : #accessing }
MAColumnMatrix >> columnSize [
	
	^columns size
]

{ #category : #'accessing vectorwise' }
MAColumnMatrix >> columns [
	
	^columns
]

{ #category : #'initialize-release' }
MAColumnMatrix >> initializeRows: m columns: n [
	
	columns := Array new: n.
	1
		to: n
		do:
			[:index | 
			columns
				at: index
				put: (self vectorSpecies new: m)]
]

{ #category : #accessing }
MAColumnMatrix >> rowSize [
	
	^columns isEmpty
		ifTrue: [0]
		ifFalse: [columns last size]
]
