"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MOSparseColumnMatrix,
	#superclass : #MOColumnMatrix,
	#category : #'Moose-Algos-LinearAlgebra'
}

{ #category : #'instance creation' }
MOSparseColumnMatrix class >> onColumns: columnCollection [
	
	| new |
	new := self basicNew.
	new
		instVarNamed: 'columns'
		put: columnCollection asArray.
	[new checkInvariant] assert.
	^new
]

{ #category : #private }
MOSparseColumnMatrix class >> vectorSpecies [
	
	^MOSparseVector
]

{ #category : #adding }
MOSparseColumnMatrix >> addColumn [
	
	columns := columns copyWith: (self vectorSpecies new: self rowSize)
]

{ #category : #adding }
MOSparseColumnMatrix >> addRow [
	
	columns do: #addLast
]

{ #category : #enumerating }
MOSparseColumnMatrix >> doSparseWithIndices: trinaryBlock [
	
	columns
		doWithIndex:
			[:vector :column | 
			vector
				doSparseWithIndex:
					[:each :row | trinaryBlock value: each value: row value: column]].
	^self
]

{ #category : #testing }
MOSparseColumnMatrix >> isZeroAt: row and: column [
	
	^(columns at: column) isZeroAt: row
]

{ #category : #accessing }
MOSparseColumnMatrix >> sparseSize [
	
	^columns
		inject: 0
		into: [:sum :each | sum + each sparseSize]
]

{ #category : #printing }
MOSparseColumnMatrix >> storeOn: stream [
	
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
MOSparseColumnMatrix >> storeSVDSparseBinaryOn: aStream [
	
	self storeTransposedSparseBinaryOn: aStream
]
