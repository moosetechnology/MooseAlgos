"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MARowMatrix,
	#superclass : #MAMatrix,
	#instVars : [
		'rows'
	],
	#category : #'Moose-Algos-LinearAlgebra'
}

{ #category : #accessing }
MARowMatrix >> at: row and: column [
	
	^(rows at: row) at: column
]

{ #category : #accessing }
MARowMatrix >> at: row and: column put: aNumber [
	
	^(rows at: row) at: column put: aNumber
]

{ #category : #private }
MARowMatrix >> checkInvariant [
	
	^rows isCollection
		and:
			[(rows allSatisfy: [:row | row isKindOf: self vectorSpecies])
				and: [rows allSatisfy: [:row | row size = self columnSize]]]
]

{ #category : #accessing }
MARowMatrix >> columnSize [
	
	^rows isEmpty
		ifTrue: [0]
		ifFalse: [rows first size]
]

{ #category : #'initialize-release' }
MARowMatrix >> initializeRows: m columns: n [
	
	rows := Array new: m.
	1
		to: m
		do:
			[:index | 
			rows
				at: index
				put: (self vectorSpecies new: n)]
]

{ #category : #'accessing vectorwise' }
MARowMatrix >> rowAt: rowIndex [
	
	^rows at: rowIndex
]

{ #category : #accessing }
MARowMatrix >> rowSize [
	
	^rows size
]

{ #category : #'accessing vectorwise' }
MARowMatrix >> rows [
	
	^rows
]
