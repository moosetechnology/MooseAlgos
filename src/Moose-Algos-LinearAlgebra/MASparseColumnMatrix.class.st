"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MASparseColumnMatrix,
	#superclass : #MAColumnMatrix,
	#category : #'Moose-Algos-LinearAlgebra'
}

{ #category : #'instance creation' }
MASparseColumnMatrix class >> onColumns: columnCollection [
	
	| new |
	new := self basicNew.
	new
		instVarNamed: 'columns'
		put: columnCollection asArray.
	[new checkInvariant] assert.
	^new
]

{ #category : #private }
MASparseColumnMatrix class >> vectorSpecies [
	
	^MASparseVector
]

{ #category : #adding }
MASparseColumnMatrix >> addColumn [
	
	columns := columns copyWith: (self vectorSpecies new: self rowSize)
]

{ #category : #adding }
MASparseColumnMatrix >> addRow [
	
	columns do: #addLast
]

{ #category : #enumerating }
MASparseColumnMatrix >> doSparseWithIndices: trinaryBlock [
	
	columns
		doWithIndex:
			[:vector :column | 
			vector
				doSparseWithIndex:
					[:each :row | trinaryBlock value: each value: row value: column]].
	^self
]

{ #category : #testing }
MASparseColumnMatrix >> isZeroAt: row and: column [
	
	^(columns at: column) isZeroAt: row
]

{ #category : #accessing }
MASparseColumnMatrix >> sparseSize [
	
	^columns
		inject: 0
		into: [:sum :each | sum + each sparseSize]
]

{ #category : #printing }
MASparseColumnMatrix >> storeOn: stream [
	
	| text |
	text := String new writeStream.
	self storeSparseTextOn: text.
	stream
		print: self class;
		space;
		nextPutAll: #readFromSparseText:;
		space;
		print:
				(text contents
						replaceAll: Character cr
						with: Character space);
		space;
		nextPutAll: 'readStream'
]

{ #category : #'SVD decomposing' }
MASparseColumnMatrix >> storeSVDSparseBinaryOn: aStream [
	
	self storeTransposedSparseBinaryOn: aStream
]
