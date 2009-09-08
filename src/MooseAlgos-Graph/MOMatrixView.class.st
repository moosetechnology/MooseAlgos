"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MOMatrixView,
	#superclass : #MOMatrixDecorator,
	#instVars : [
		'rowSize',
		'columnSize',
		'mapBlock'
	],
	#category : #'MooseAlgos-LinearAlgebra'
}

{ #category : #'instance creation' }
MOMatrixView class >> from: top to: bottom on: matrix [
	
	^(self new: bottom - top + 1)
		setMatrix: matrix;
		setMapBlock: [:row :column | row @ column - top + 1];
		yourself
]

{ #category : #'As yet unclassified' }
MOMatrixView class >> fromColumn: start to: end on: matrix [
	
	^self
		from: 1
		to: matrix rowSize @ end
		on: matrix
]

{ #category : #'instance creation' }
MOMatrixView class >> transposeOn: matrix [
	
	^(self new: matrix dimension transpose)
		setMatrix: matrix;
		setMapBlock: [:row :column | column @ row];
		yourself
]

{ #category : #accessing }
MOMatrixView >> at: row and: column [
	
	^matrix atPoint: (mapBlock value: row value: column)
]

{ #category : #accessing }
MOMatrixView >> at: row and: column put: aNumber [
	
	self noModificationError
]

{ #category : #accessing }
MOMatrixView >> columnSize [
	
	^columnSize
]

{ #category : #'initialize-release' }
MOMatrixView >> initializeRows: m columns: n [
	
	rowSize := m.
	columnSize := n
]

{ #category : #accessing }
MOMatrixView >> rowSize [
	
	^rowSize
]

{ #category : #'initialize-release' }
MOMatrixView >> setMapBlock: block [
	
	^mapBlock := block
]
