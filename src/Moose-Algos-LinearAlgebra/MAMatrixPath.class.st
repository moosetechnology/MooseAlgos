"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MAMatrixPath,
	#superclass : #MAVector,
	#instVars : [
		'matrix',
		'mapBlock',
		'size'
	],
	#category : #'Moose-Algos-LinearAlgebra'
}

{ #category : #'instance creation' }
MAMatrixPath class >> column: columnIndex on: matrix [
	
	^(super new: matrix rowSize)
		setMatrix: matrix;
		setMapBlock: [:index | index @ columnIndex];
		yourself
]

{ #category : #'instance creation' }
MAMatrixPath class >> diagonalOn: matrix [
	
	[matrix isSquare] assert.
	^(super new: matrix columnSize)
		setMatrix: matrix;
		setMapBlock: [:index | index @ index];
		yourself
]

{ #category : #'instance creation' }
MAMatrixPath class >> row: rowIndex on: matrix [
	
	^(super new: matrix columnSize)
		setMatrix: matrix;
		setMapBlock: [:index | rowIndex @ index];
		yourself
]

{ #category : #accessing }
MAMatrixPath >> at: index [
	
	^matrix atPoint: (mapBlock value: index)
]

{ #category : #accessing }
MAMatrixPath >> at: index put: aNumber [
	
	^matrix
		atPoint: (mapBlock value: index)
		put: aNumber
]

{ #category : #'initialize-release' }
MAMatrixPath >> initializeSize: aSize [
	
	^size := aSize
]

{ #category : #'initialize-release' }
MAMatrixPath >> setMapBlock: aBlock [
	
	^mapBlock := aBlock
]

{ #category : #'initialize-release' }
MAMatrixPath >> setMatrix: aMatrix [
	
	^matrix := aMatrix
]

{ #category : #accessing }
MAMatrixPath >> size [
	
	^size
]

{ #category : #'initialize-release' }
MAMatrixPath >> species [
	
	^matrix vectorSpecies
]
