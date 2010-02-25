"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MAMatrixView,
	#superclass : #MAMatrixDecorator,
	#instVars : [
		'rowSize',
		'columnSize',
		'mapBlock'
	],
	#category : #'Moose-Algos-LinearAlgebra'
}

{ #category : #'instance creation' }
MAMatrixView class >> from: top to: bottom on: matrix [
	
	^(self new: bottom - top + 1)
		setMatrix: matrix;
		setMapBlock: [:row :column | row @ column - top + 1];
		yourself
]

{ #category : #'As yet unclassified' }
MAMatrixView class >> fromColumn: start to: end on: matrix [
	
	^self
		from: 1
		to: matrix rowSize @ end
		on: matrix
]

{ #category : #'instance creation' }
MAMatrixView class >> transposeOn: matrix [
	
	^(self new: matrix dimension transpose)
		setMatrix: matrix;
		setMapBlock: [:row :column | column @ row];
		yourself
]

{ #category : #accessing }
MAMatrixView >> at: row and: column [
	
	^matrix atPoint: (mapBlock value: row value: column)
]

{ #category : #accessing }
MAMatrixView >> at: row and: column put: aNumber [
	
	self noModificationError
]

{ #category : #accessing }
MAMatrixView >> columnSize [
	
	^columnSize
]

{ #category : #'initialize-release' }
MAMatrixView >> initializeRows: m columns: n [
	
	rowSize := m.
	columnSize := n
]

{ #category : #accessing }
MAMatrixView >> rowSize [
	
	^rowSize
]

{ #category : #'initialize-release' }
MAMatrixView >> setMapBlock: block [
	
	^mapBlock := block
]
