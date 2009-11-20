"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MOColumnMatrix,
	#superclass : #MOMatrix,
	#instVars : [
		'columns'
	],
	#category : #'MooseAlgos-LinearAlgebra'
}

{ #category : #accessing }
MOColumnMatrix >> at: row and: column [
	
	^(columns at: column) at: row
]

{ #category : #accessing }
MOColumnMatrix >> at: row and: column put: aNumber [
	
	^(columns at: column) at: row put: aNumber
]

{ #category : #private }
MOColumnMatrix >> checkInvariant [
	
	^columns isCollection
		and:
			[(columns allSatisfy: [:vector | vector isKindOf: self vectorSpecies])
				and: [columns allSatisfy: [:vector | vector size = self rowSize]]]
]

{ #category : #'accessing vectorwise' }
MOColumnMatrix >> columnAt: column [
	
	^columns at: column
]

{ #category : #accessing }
MOColumnMatrix >> columnSize [
	
	^columns size
]

{ #category : #'accessing vectorwise' }
MOColumnMatrix >> columns [
	
	^columns
]

{ #category : #'initialize-release' }
MOColumnMatrix >> initializeRows: m columns: n [
	
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
MOColumnMatrix >> rowSize [
	
	^columns isEmpty
		ifTrue: [0]
		ifFalse: [columns last size]
]
