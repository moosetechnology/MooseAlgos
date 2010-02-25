"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MAMappedMatrix,
	#superclass : #MAMatrixDecorator,
	#instVars : [
		'columnMap',
		'rowMap'
	],
	#category : #'Moose-Algos-LinearAlgebra'
}

{ #category : #'instance creation' }
MAMappedMatrix class >> on: aMatrix [
	
	^self on: aMatrix rowMap: nil columnMap: nil
]

{ #category : #'instance creation' }
MAMappedMatrix class >> on: aMatrix columnMap: columnReindexing [
	
	^self on: aMatrix rowMap: nil columnMap: columnReindexing
]

{ #category : #'instance creation' }
MAMappedMatrix class >> on: aMatrix map: aReindexing [
	
	[aMatrix isSquare] assert.
	^self on: aMatrix rowMap: aReindexing columnMap: aReindexing
]

{ #category : #'instance creation' }
MAMappedMatrix class >> on: aMatrix rowMap: rowReindexing [
	
	^self on: aMatrix rowMap: rowReindexing columnMap: nil
]

{ #category : #'instance creation' }
MAMappedMatrix class >> on: aMatrix rowMap: rowReindexing columnMap: columnReindexing [
	
	^(super on: aMatrix)
		setRowMap: rowReindexing;
		setColumnMap: columnReindexing;
		yourself
]

{ #category : #accessing }
MAMappedMatrix >> at: row and: column [
	
	^matrix
		at: (rowMap at: row)
		and: (columnMap at: column)
]

{ #category : #accessing }
MAMappedMatrix >> at: row and: column put: aNumber [
	
	^matrix
		at: (rowMap at: row)
		and: (columnMap at: column)
		put: aNumber
]

{ #category : #accessing }
MAMappedMatrix >> columnSize [
	
	^columnMap size
]

{ #category : #accessing }
MAMappedMatrix >> rowSize [
	
	^rowMap size
]

{ #category : #'initialize-release' }
MAMappedMatrix >> setColumnMap: mapping [
	
	columnMap := mapping ifNil: [MANumberMapping new: matrix columnSize]
]

{ #category : #'initialize-release' }
MAMappedMatrix >> setRowMap: mapping [
	
	rowMap := mapping ifNil: [MANumberMapping new: matrix rowSize]
]
