"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MAMatrixDecorator,
	#superclass : #MAMatrix,
	#instVars : [
		'matrix'
	],
	#category : #'Moose-Algos-LinearAlgebra'
}

{ #category : #'instance creation' }
MAMatrixDecorator class >> on: aMatrix [
	
	^(self basicNew)
		setMatrix: aMatrix;
		yourself
]

{ #category : #accessing }
MAMatrixDecorator >> at: row and: column [
	
	^matrix at: row and: column
]

{ #category : #accessing }
MAMatrixDecorator >> at: row and: column put: aNumber [
	
	^matrix at: row and: column put: aNumber
]

{ #category : #private }
MAMatrixDecorator >> checkInvariant [
	
	^matrix checkInvariant
]

{ #category : #accessing }
MAMatrixDecorator >> columnSize [
	
	^matrix columnSize
]

{ #category : #'initialize-release' }
MAMatrixDecorator >> initializeRows: m columns: n [
	
	self shouldNotImplement
]

{ #category : #accessing }
MAMatrixDecorator >> rowSize [
	
	^matrix rowSize
]

{ #category : #'initialize-release' }
MAMatrixDecorator >> setMatrix: aMatrix [
	
	^matrix := aMatrix
]

{ #category : #'initialize-release' }
MAMatrixDecorator >> species [
	
	^matrix species
]
