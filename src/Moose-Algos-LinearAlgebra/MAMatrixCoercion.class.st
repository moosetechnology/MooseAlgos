"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MAMatrixCoercion,
	#superclass : #MAMatrix,
	#instVars : [
		'number'
	],
	#category : #'Moose-Algos-LinearAlgebra'
}

{ #category : #'initialize-release' }
MAMatrixCoercion class >> with: aNumber [
	
	^(aNumber isKindOf: MAMatrix)
		ifTrue: [aNumber]
		ifFalse:
			[(self basicNew)
				setNumber: aNumber;
				yourself]
]

{ #category : #comparing }
MAMatrixCoercion >> = matrix [
	
	^self
		switch: matrix
		caseCoercion: [number = matrix asNumber]
		caseMatrix: [matrix = self]
]

{ #category : #converting }
MAMatrixCoercion >> asNumber [
	
	^number
]

{ #category : #accessing }
MAMatrixCoercion >> at: row and: column [
	
	^number
]

{ #category : #private }
MAMatrixCoercion >> checkInvariant [
	
	^number respondsToArithmetic
]

{ #category : #accessing }
MAMatrixCoercion >> columnSize [
	
	self noDimensionError
]

{ #category : #testing }
MAMatrixCoercion >> hasDimension: aDimension [
	
	^true
]

{ #category : #'initialize-release' }
MAMatrixCoercion >> initializeRows: m columns: n [
	
	^self noDimensionError
]

{ #category : #private }
MAMatrixCoercion >> noDimensionError [
	
	^self error: 'Coerced matrices do not have dimension.'
]

{ #category : #printing }
MAMatrixCoercion >> printOn: aStream [
	"Append to the argument aStream a sequence of characters that identifies the matrix."
	
	aStream
		print: self class;
		nextPutAll: ' with: ';
		print: number
]

{ #category : #accessing }
MAMatrixCoercion >> rowSize [
	
	self noDimensionError
]

{ #category : #'initialize-release' }
MAMatrixCoercion >> setNumber: aNumber [
	
	^number := aNumber
]

{ #category : #private }
MAMatrixCoercion >> switch: matrix caseCoercion: coercionBlock caseMatrix: matrixBlock [
	
	^(matrix isKindOf: MAMatrixCoercion)
		ifTrue: [coercionBlock value]
		ifFalse: [matrixBlock value]
]

{ #category : #enumerating }
MAMatrixCoercion >> with: matrix affect: aBlock [
	
	^self
		switch: matrix
		caseCoercion:
			[number := aBlock
				value: number
				value: matrix asNumber]
		caseMatrix: [Error raise]
]

{ #category : #enumerating }
MAMatrixCoercion >> with: matrix collect: aBlock [
	
	^self
		switch: matrix
		caseCoercion:
			[MAMatrixCoercion
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
MAMatrixCoercion >> with: matrix do: aBlock [
	
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
