"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MORowMatrix,
	#superclass : #MOMatrix,
	#instVars : [
		'rows'
	],
	#category : #'MooseAlgos-LinearAlgebra'
}

{ #category : #accessing }
MORowMatrix >> at: row and: column [
	
	^(rows at: row) at: column
]

{ #category : #accessing }
MORowMatrix >> at: row and: column put: aNumber [
	
	^(rows at: row) at: column put: aNumber
]

{ #category : #private }
MORowMatrix >> checkInvariant [
	
	^rows isCollection
		and:
			[(rows allSatisfy: [:row | row isKindOf: self vectorSpecies])
				and: [rows allSatisfy: [:row | row size = self columnSize]]]
]

{ #category : #accessing }
MORowMatrix >> columnSize [
	
	^rows isEmpty
		ifTrue: [0]
		ifFalse: [rows first size]
]

{ #category : #'initialize-release' }
MORowMatrix >> initializeRows: m columns: n [
	
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
MORowMatrix >> rowAt: rowIndex [
	
	^rows at: rowIndex
]

{ #category : #accessing }
MORowMatrix >> rowSize [
	
	^rows size
]

{ #category : #'accessing vectorwise' }
MORowMatrix >> rows [
	
	^rows
]
