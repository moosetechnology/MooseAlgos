"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MASparseRowMatrix,
	#superclass : #MARowMatrix,
	#category : #'Moose-Algos-LinearAlgebra'
}

{ #category : #private }
MASparseRowMatrix class >> onRows: rowCollection [
	
	| new |
	new := self basicNew.
	new
		instVarNamed: 'rows'
		put: rowCollection asArray.
	[new checkInvariant] assert.
	^new
]

{ #category : #private }
MASparseRowMatrix class >> vectorSpecies [
	
	^MASparseVector
]

{ #category : #adding }
MASparseRowMatrix >> addColumn [
	
	rows do: #addLast
]

{ #category : #adding }
MASparseRowMatrix >> addRow [
	
	rows := rows copyWith: (self vectorSpecies new: self columnSize)
]

{ #category : #enumerating }
MASparseRowMatrix >> doSparseWithIndices: trinaryBlock [
	
	rows
		doWithIndex:
			[:vector :row | 
			vector
				doSparseWithIndex:
					[:each :column | trinaryBlock value: each value: row value: column]].
	^self
]

{ #category : #testing }
MASparseRowMatrix >> isZeroAt: row and: column [
	
	^(rows at: row) isZeroAt: column
]

{ #category : #accessing }
MASparseRowMatrix >> sparseSize [
	
	^rows
		inject: 0
		into: [:sum :each | sum + each sparseSize]
]

{ #category : #printing }
MASparseRowMatrix >> storeOn: stream [
	
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
MASparseRowMatrix >> storeSVDSparseBinaryOn: aStream [
	
	self storeSparseBinaryOn: aStream
]
