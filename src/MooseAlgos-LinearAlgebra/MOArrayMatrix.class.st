"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MOArrayMatrix,
	#superclass : #MOMatrix,
	#instVars : [
		'array',
		'columnSize',
		'rowSize'
	],
	#category : #'MooseAlgos-LinearAlgebra'
}

{ #category : #accessing }
MOArrayMatrix >> at: row and: column [
	
	^array at: (row - 1) * self columnSize + column
]

{ #category : #accessing }
MOArrayMatrix >> at: row and: column put: aNumber [
	
	^array
		at: (row - 1) * self columnSize + column
		put: aNumber
]

{ #category : #private }
MOArrayMatrix >> checkInvariant [
	
	^array isCollection and: [(array size = rowSize) * columnSize]
]

{ #category : #accessing }
MOArrayMatrix >> columnSize [
	
	^columnSize
]

{ #category : #'initialize-release' }
MOArrayMatrix >> initializeRows: n columns: m [
	
	rowSize := n.
	columnSize := m.
	array := Array new: n * m.
	^self
]

{ #category : #accessing }
MOArrayMatrix >> rowSize [
	
	^rowSize
]
