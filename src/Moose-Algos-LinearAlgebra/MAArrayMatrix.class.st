"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MAArrayMatrix,
	#superclass : #MAMatrix,
	#instVars : [
		'array',
		'columnSize',
		'rowSize'
	],
	#category : #'Moose-Algos-LinearAlgebra'
}

{ #category : #accessing }
MAArrayMatrix >> at: row and: column [
	
	^array at: (row - 1) * self columnSize + column
]

{ #category : #accessing }
MAArrayMatrix >> at: row and: column put: aNumber [
	
	^array
		at: (row - 1) * self columnSize + column
		put: aNumber
]

{ #category : #private }
MAArrayMatrix >> checkInvariant [
	
	^array isCollection and: [(array size = rowSize) * columnSize]
]

{ #category : #accessing }
MAArrayMatrix >> columnSize [
	
	^columnSize
]

{ #category : #'initialize-release' }
MAArrayMatrix >> initializeRows: n columns: m [
	
	rowSize := n.
	columnSize := m.
	array := Array new: n * m.
	^self
]

{ #category : #accessing }
MAArrayMatrix >> rowSize [
	
	^rowSize
]
