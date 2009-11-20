"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MOSymetricMatrix,
	#superclass : #MOMatrix,
	#instVars : [
		'partialColumns'
	],
	#category : #'Moose-Algos-LinearAlgebra'
}

{ #category : #accessing }
MOSymetricMatrix >> at: row and: column [
	
	^row < column
		ifTrue: [(partialColumns at: column) at: row]
		ifFalse: [(partialColumns at: row) at: column]
]

{ #category : #accessing }
MOSymetricMatrix >> at: row and: column put: aNumber [
	
	^row < column
		ifTrue: [(partialColumns at: column) at: row put: aNumber]
		ifFalse: [(partialColumns at: row) at: column put: aNumber]
]

{ #category : #private }
MOSymetricMatrix >> checkInvariant [
	
	^partialColumns isCollection
		and:
			[(partialColumns
				allSatisfy: [:vector | vector isKindOf: self vectorSpecies])
				and:
					[(1 to: self columnSize)
						allSatisfy: [:index | (partialColumns at: index) size = index]]]	"(SymetricMatrix new: 10) checkInvariant"
]

{ #category : #accessing }
MOSymetricMatrix >> columnSize [
	
	^partialColumns size
]

{ #category : #'initialize-release' }
MOSymetricMatrix >> initializeRows: m columns: n [
	
	m = n ifFalse: [Array new noMatchError].
	partialColumns := Array new: n.
	1
		to: n
		do:
			[:index | 
			partialColumns
				at: index
				put: (self vectorSpecies new: index)]
]

{ #category : #testing }
MOSymetricMatrix >> isSquare [
	"Each symatric matrix is square."
	
	^true
]

{ #category : #testing }
MOSymetricMatrix >> isSymetric [
	"Each symetric matrix is symatric."
	
	^true
]

{ #category : #accessing }
MOSymetricMatrix >> rowSize [
	
	^partialColumns size	"since we are square"
]

{ #category : #'matrix functions' }
MOSymetricMatrix >> transposed [
	"Answer self, since symatric matrices are invariant under transposition."
	
	^self
]

{ #category : #enumerating }
MOSymetricMatrix >> upperTriangleDoWithIndices: aBlock [
	
	1
		to: self columnSize
		do:
			[:column | 
			1
				to: column
				do:
					[:row | 
					aBlock
						value: (self at: row and: column)
						value: row
						value: column]]
]
