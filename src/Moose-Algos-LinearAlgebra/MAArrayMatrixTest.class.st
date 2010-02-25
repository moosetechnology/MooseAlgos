"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MAArrayMatrixTest,
	#superclass : #MAMatrixTest,
	#category : #'Moose-Algos-LinearAlgebra'
}

{ #category : #fixture }
MAArrayMatrixTest >> matrixClass [
	
	^MAArrayMatrix
]

{ #category : #test }
MAArrayMatrixTest >> testDeterminant [
	
	| matrix |
	matrix := MAArrayMatrix rows: 3 columns: 3.
	self
		assertBlock: [matrix determinant]
		raises: AssertionFailure.
	matrix := MAArrayMatrix rows: 2 columns: 2 withAll: #(3 6 9 2).
	self assert: matrix determinant = -48
]
