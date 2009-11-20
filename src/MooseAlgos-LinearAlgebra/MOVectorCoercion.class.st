"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MOVectorCoercion,
	#superclass : #MOVector,
	#instVars : [
		'number'
	],
	#category : #'MooseAlgos-LinearAlgebra'
}

{ #category : #'initialize-release' }
MOVectorCoercion class >> with: aNumber [
	
	^(aNumber isKindOf: MOVector)
		ifTrue: [aNumber]
		ifFalse:
			[(self basicNew)
				setNumber: aNumber;
				yourself]
]

{ #category : #converting }
MOVectorCoercion >> asNumber [
	
	^number
]

{ #category : #accessing }
MOVectorCoercion >> at: index [
	
	^number
]

{ #category : #testing }
MOVectorCoercion >> hasSize: aSize [
	
	^true
]

{ #category : #'initialize-release' }
MOVectorCoercion >> initializeSize: aSize [
	
	^self noDimensionError
]

{ #category : #private }
MOVectorCoercion >> noDimensionError [
	
	^self error: 'Coerced matrices do not have dimension.'
]

{ #category : #printing }
MOVectorCoercion >> printOn: aStream [
	
	aStream
		print: self class;
		nextPutAll: ' with: ';
		print: number
]

{ #category : #'initialize-release' }
MOVectorCoercion >> setNumber: aNumber [
	
	^number := aNumber
]

{ #category : #accessing }
MOVectorCoercion >> size [
	
	^self noDimensionError
]

{ #category : #'mathematical functions' }
MOVectorCoercion >> sum [
	
	^self noDimensionError
]

{ #category : #private }
MOVectorCoercion >> switch: matrix caseCoercion: coercionBlock caseVector: vectorBlock [
	
	^(matrix isKindOf: MOVectorCoercion)
		ifTrue: [coercionBlock value]
		ifFalse: [vectorBlock value]
]

{ #category : #enumerating }
MOVectorCoercion >> with: vector affect: aBlock [
	
	^self
		switch: vector
		caseCoercion:
			[number := aBlock
				value: number
				value: vector asNumber]
		caseVector: [Error raise]
]

{ #category : #enumerating }
MOVectorCoercion >> with: vector collect: aBlock [
	
	^self
		switch: vector
		caseCoercion:
			[MOMatrixCoercion
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
MOVectorCoercion >> with: vector do: aBlock [
	
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
