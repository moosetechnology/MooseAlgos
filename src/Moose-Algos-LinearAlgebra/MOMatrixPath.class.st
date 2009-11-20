"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MOMatrixPath,
	#superclass : #MOVector,
	#instVars : [
		'matrix',
		'mapBlock',
		'size'
	],
	#category : #'Moose-Algos-LinearAlgebra'
}

{ #category : #'instance creation' }
MOMatrixPath class >> column: columnIndex on: matrix [
	
	^(super new: matrix rowSize)
		setMatrix: matrix;
		setMapBlock: [:index | index @ columnIndex];
		yourself
]

{ #category : #'instance creation' }
MOMatrixPath class >> diagonalOn: matrix [
	
	[matrix isSquare] assert.
	^(super new: matrix columnSize)
		setMatrix: matrix;
		setMapBlock: [:index | index @ index];
		yourself
]

{ #category : #'instance creation' }
MOMatrixPath class >> row: rowIndex on: matrix [
	
	^(super new: matrix columnSize)
		setMatrix: matrix;
		setMapBlock: [:index | rowIndex @ index];
		yourself
]

{ #category : #accessing }
MOMatrixPath >> at: index [
	
	^matrix atPoint: (mapBlock value: index)
]

{ #category : #accessing }
MOMatrixPath >> at: index put: aNumber [
	
	^matrix
		atPoint: (mapBlock value: index)
		put: aNumber
]

{ #category : #'initialize-release' }
MOMatrixPath >> initializeSize: aSize [
	
	^size := aSize
]

{ #category : #'initialize-release' }
MOMatrixPath >> setMapBlock: aBlock [
	
	^mapBlock := aBlock
]

{ #category : #'initialize-release' }
MOMatrixPath >> setMatrix: aMatrix [
	
	^matrix := aMatrix
]

{ #category : #accessing }
MOMatrixPath >> size [
	
	^size
]

{ #category : #'initialize-release' }
MOMatrixPath >> species [
	
	^matrix vectorSpecies
]
