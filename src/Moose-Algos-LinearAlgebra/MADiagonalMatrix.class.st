"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MADiagonalMatrix,
	#superclass : #MASymetricMatrix,
	#category : #'Moose-Algos-LinearAlgebra'
}

{ #category : #'instance creation' }
MADiagonalMatrix class >> withDiagonal: vector [
	
	| newMatrix |
	newMatrix := self new: vector size.
	1
		to: vector size
		do:
			[:index | 
			newMatrix
				at: index
				and: index
				put: (vector at: index)].
	^newMatrix
]

{ #category : #accessing }
MADiagonalMatrix >> at: row and: column [
	
	^row = column
		ifTrue: [partialColumns at: column]
		ifFalse: [0]
]

{ #category : #accessing }
MADiagonalMatrix >> at: row and: column put: aNumber [
	
	^row = column
		ifTrue: [partialColumns at: column put: aNumber]
		ifFalse:
			[aNumber isZero
				ifFalse:
					[self error: ('can not put <1p> off diagonal' expandMacrosWith: aNumber)].
			aNumber]
]

{ #category : #private }
MADiagonalMatrix >> checkInvariant [
	
	^partialColumns isCollection	"(DiagonalMatrix new: 10) checkInvariant"
]

{ #category : #accessing }
MADiagonalMatrix >> columnSize [
	
	^partialColumns size
]

{ #category : #'initialize-release' }
MADiagonalMatrix >> initializeRows: m columns: n [
	
	m = n ifFalse: [Array new noMatchError].
	partialColumns := Array new: m.
	^self
]

{ #category : #accessing }
MADiagonalMatrix >> rowSize [
	
	^partialColumns size
]
