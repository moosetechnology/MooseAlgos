"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MOArrayMatrixTest,
	#superclass : #MOMatrixTest,
	#category : #'MooseAlgos-LinearAlgebra'
}

{ #category : #fixture }
MOArrayMatrixTest >> matrixClass [
	
	^MOArrayMatrix
]

{ #category : #test }
MOArrayMatrixTest >> testDeterminant [
	
	| matrix |
	matrix := MOArrayMatrix rows: 3 columns: 3.
	self
		assertBlock: [matrix determinant]
		raises: AssertionFailure.
	matrix := MOArrayMatrix rows: 2 columns: 2 withAll: #(3 6 9 2).
	self assert: matrix determinant = -48
]
