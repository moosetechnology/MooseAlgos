"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MOMatrixDecorator,
	#superclass : #MOMatrix,
	#instVars : [
		'matrix'
	],
	#category : #'Moose-Algos-LinearAlgebra'
}

{ #category : #'instance creation' }
MOMatrixDecorator class >> on: aMatrix [
	
	^(self basicNew)
		setMatrix: aMatrix;
		yourself
]

{ #category : #accessing }
MOMatrixDecorator >> at: row and: column [
	
	^matrix at: row and: column
]

{ #category : #accessing }
MOMatrixDecorator >> at: row and: column put: aNumber [
	
	^matrix at: row and: column put: aNumber
]

{ #category : #private }
MOMatrixDecorator >> checkInvariant [
	
	^matrix checkInvariant
]

{ #category : #accessing }
MOMatrixDecorator >> columnSize [
	
	^matrix columnSize
]

{ #category : #'initialize-release' }
MOMatrixDecorator >> initializeRows: m columns: n [
	
	self shouldNotImplement
]

{ #category : #accessing }
MOMatrixDecorator >> rowSize [
	
	^matrix rowSize
]

{ #category : #'initialize-release' }
MOMatrixDecorator >> setMatrix: aMatrix [
	
	^matrix := aMatrix
]

{ #category : #'initialize-release' }
MOMatrixDecorator >> species [
	
	^matrix species
]
