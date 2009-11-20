"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MOMatrixCoercion,
	#superclass : #MOMatrix,
	#instVars : [
		'number'
	],
	#category : #'Moose-Algos-LinearAlgebra'
}

{ #category : #'initialize-release' }
MOMatrixCoercion class >> with: aNumber [
	
	^(aNumber isKindOf: MOMatrix)
		ifTrue: [aNumber]
		ifFalse:
			[(self basicNew)
				setNumber: aNumber;
				yourself]
]

{ #category : #comparing }
MOMatrixCoercion >> = matrix [
	
	^self
		switch: matrix
		caseCoercion: [number = matrix asNumber]
		caseMatrix: [matrix = self]
]

{ #category : #converting }
MOMatrixCoercion >> asNumber [
	
	^number
]

{ #category : #accessing }
MOMatrixCoercion >> at: row and: column [
	
	^number
]

{ #category : #private }
MOMatrixCoercion >> checkInvariant [
	
	^number respondsToArithmetic
]

{ #category : #accessing }
MOMatrixCoercion >> columnSize [
	
	self noDimensionError
]

{ #category : #testing }
MOMatrixCoercion >> hasDimension: aDimension [
	
	^true
]

{ #category : #'initialize-release' }
MOMatrixCoercion >> initializeRows: m columns: n [
	
	^self noDimensionError
]

{ #category : #private }
MOMatrixCoercion >> noDimensionError [
	
	^self error: 'Coerced matrices do not have dimension.'
]

{ #category : #printing }
MOMatrixCoercion >> printOn: aStream [
	"Append to the argument aStream a sequence of characters that identifies the matrix."
	
	aStream
		print: self class;
		nextPutAll: ' with: ';
		print: number
]

{ #category : #accessing }
MOMatrixCoercion >> rowSize [
	
	self noDimensionError
]

{ #category : #'initialize-release' }
MOMatrixCoercion >> setNumber: aNumber [
	
	^number := aNumber
]

{ #category : #private }
MOMatrixCoercion >> switch: matrix caseCoercion: coercionBlock caseMatrix: matrixBlock [
	
	^(matrix isKindOf: MOMatrixCoercion)
		ifTrue: [coercionBlock value]
		ifFalse: [matrixBlock value]
]

{ #category : #enumerating }
MOMatrixCoercion >> with: matrix affect: aBlock [
	
	^self
		switch: matrix
		caseCoercion:
			[number := aBlock
				value: number
				value: matrix asNumber]
		caseMatrix: [Error raise]
]

{ #category : #enumerating }
MOMatrixCoercion >> with: matrix collect: aBlock [
	
	^self
		switch: matrix
		caseCoercion:
			[MOMatrixCoercion
				with:
					(aBlock
						value: number
						value: matrix asNumber)]
		caseMatrix:
			[matrix
				with: self
				collect: [:a :b | aBlock value: b value: a]]
]

{ #category : #enumerating }
MOMatrixCoercion >> with: matrix do: aBlock [
	
	^self
		switch: matrix
		caseCoercion:
			[aBlock
				value: number
				value: matrix asNumber]
		caseMatrix:
			[matrix
				with: self
				do: [:a :b | aBlock value: b value: a]]
]
