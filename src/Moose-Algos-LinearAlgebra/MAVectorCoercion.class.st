"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MAVectorCoercion,
	#superclass : #MAVector,
	#instVars : [
		'number'
	],
	#category : #'Moose-Algos-LinearAlgebra'
}

{ #category : #'initialize-release' }
MAVectorCoercion class >> with: aNumber [
	
	^(aNumber isKindOf: MAVector)
		ifTrue: [aNumber]
		ifFalse:
			[(self basicNew)
				setNumber: aNumber;
				yourself]
]

{ #category : #converting }
MAVectorCoercion >> asNumber [
	
	^number
]

{ #category : #accessing }
MAVectorCoercion >> at: index [
	
	^number
]

{ #category : #testing }
MAVectorCoercion >> hasSize: aSize [
	
	^true
]

{ #category : #'initialize-release' }
MAVectorCoercion >> initializeSize: aSize [
	
	^self noDimensionError
]

{ #category : #private }
MAVectorCoercion >> noDimensionError [
	
	^self error: 'Coerced matrices do not have dimension.'
]

{ #category : #printing }
MAVectorCoercion >> printOn: aStream [
	
	aStream
		print: self class;
		nextPutAll: ' with: ';
		print: number
]

{ #category : #'initialize-release' }
MAVectorCoercion >> setNumber: aNumber [
	
	^number := aNumber
]

{ #category : #accessing }
MAVectorCoercion >> size [
	
	^self noDimensionError
]

{ #category : #'mathematical functions' }
MAVectorCoercion >> sum [
	
	^self noDimensionError
]

{ #category : #private }
MAVectorCoercion >> switch: matrix caseCoercion: coercionBlock caseVector: vectorBlock [
	
	^(matrix isKindOf: MAVectorCoercion)
		ifTrue: [coercionBlock value]
		ifFalse: [vectorBlock value]
]

{ #category : #enumerating }
MAVectorCoercion >> with: vector affect: aBlock [
	
	^self
		switch: vector
		caseCoercion:
			[number := aBlock
				value: number
				value: vector asNumber]
		caseVector: [Error raise]
]

{ #category : #enumerating }
MAVectorCoercion >> with: vector collect: aBlock [
	
	^self
		switch: vector
		caseCoercion:
			[MAMatrixCoercion
				with:
					(aBlock
						value: number
						value: vector asNumber)]
		caseVector:
			[vector
				with: self
				collect: [:a :b | aBlock value: b value: a]]
]

{ #category : #enumerating }
MAVectorCoercion >> with: vector do: aBlock [
	
	^self
		switch: vector
		caseCoercion:
			[aBlock
				value: number
				value: vector asNumber]
		caseVector:
			[vector
				with: self
				do: [:a :b | aBlock value: b value: a]]
]
