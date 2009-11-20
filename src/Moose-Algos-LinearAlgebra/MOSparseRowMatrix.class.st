"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MOSparseRowMatrix,
	#superclass : #MORowMatrix,
	#category : #'Moose-Algos-LinearAlgebra'
}

{ #category : #private }
MOSparseRowMatrix class >> onRows: rowCollection [
	
	| new |
	new := self basicNew.
	new
		instVarNamed: 'rows'
		put: rowCollection asArray.
	[new checkInvariant] assert.
	^new
]

{ #category : #private }
MOSparseRowMatrix class >> vectorSpecies [
	
	^MOSparseVector
]

{ #category : #adding }
MOSparseRowMatrix >> addColumn [
	
	rows do: #addLast
]

{ #category : #adding }
MOSparseRowMatrix >> addRow [
	
	rows := rows copyWith: (self vectorSpecies new: self columnSize)
]

{ #category : #enumerating }
MOSparseRowMatrix >> doSparseWithIndices: trinaryBlock [
	
	rows
		doWithIndex:
			[:vector :row | 
			vector
				doSparseWithIndex:
					[:each :column | trinaryBlock value: each value: row value: column]].
	^self
]

{ #category : #testing }
MOSparseRowMatrix >> isZeroAt: row and: column [
	
	^(rows at: row) isZeroAt: column
]

{ #category : #accessing }
MOSparseRowMatrix >> sparseSize [
	
	^rows
		inject: 0
		into: [:sum :each | sum + each sparseSize]
]

{ #category : #printing }
MOSparseRowMatrix >> storeOn: stream [
	
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
MOSparseRowMatrix >> storeSVDSparseBinaryOn: aStream [
	
	self storeSparseBinaryOn: aStream
]
