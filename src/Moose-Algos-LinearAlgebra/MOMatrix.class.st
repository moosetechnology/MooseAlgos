"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MOMatrix,
	#superclass : #Object,
	#category : #'Moose-Algos-LinearAlgebra'
}

{ #category : #accessing }
MOMatrix class >> browserIcon [
"Answer icon to be displayed with matrix classes."
	
	^ nil
]

{ #category : #'instance creation' }
MOMatrix class >> new [
	"Create a new matrix with dimension zero."
	
	^self new: Number zero
]

{ #category : #'instance creation' }
MOMatrix class >> new: numberOrPoint [
	"Create a new square matrix with the given dimension."
	
	| point |
	point := numberOrPoint asPoint.
	^self
		rows: point x
		columns: point y
]

{ #category : #'instance creation' }
MOMatrix class >> new: numberOrPoint withAll: value [
	
	^(self new: numberOrPoint)
		atAllPut: value;
		yourself
]

{ #category : #'instance creation' }
MOMatrix class >> readFromDenseBinary: aBinaryStream [
	
	| m n matrix stream |
	stream := NetworkByteOrderStream wrap: aBinaryStream.
	m := stream nextLong.
	n := stream nextLong.
	matrix := self rows: m columns: n.
	1
		to: m
		do:
			[:row | 
			1
				to: n
				do:
					[:column | 
					matrix
						at: row
						and: column
						put: stream nextFloat]].
	^matrix
]

{ #category : #'instance creation' }
MOMatrix class >> readFromDenseText: aStream [
	
	| m n matrix |
	m := Integer readFrom: aStream skipSeparators.
	n := Integer readFrom: aStream skipSeparators.
	matrix := self rows: m columns: n.
	1
		to: m
		do:
			[:row | 
			1
				to: n
				do:
					[:column | 
					matrix
						at: row
						and: column
						put: (Number readSmalltalkAndCSyntaxFrom: aStream skipSeparators)]].
	^matrix
]

{ #category : #'instance creation' }
MOMatrix class >> readFromSparseText: aStream [
	
	| m n matrix |
	n := Integer readFrom: aStream skipSeparators.
	m := Integer readFrom: aStream skipSeparators.
	Integer readFrom: aStream skipSeparators.
	matrix := self
		rows: m
		columns: n
		withAll: Number zero.
	1
		to: m
		do:
			[:rows | 
			1
				to: (Integer readFrom: aStream skipSeparators)
				do:
					[:unused | 
					matrix
						at: rows
						and: (Integer readFrom: aStream skipSeparators) + 1
						put: (Number readFrom: aStream skipSeparators)]].
	^matrix
]

{ #category : #'instance creation' }
MOMatrix class >> rows: m columns: n [
	"Create a new matrix with m rows and n columns."
	
	^(self basicNew)
		initializeRows: m columns: n;
		yourself
]

{ #category : #'instance creation' }
MOMatrix class >> rows: m columns: n withAll: value [
	
	^(self rows: m columns: n)
		atAllPut: value;
		yourself
]

{ #category : #private }
MOMatrix class >> switch: anObject caseMatrix: matrixBlock caseNestedCollection: nestedColletionBlock caseCollection: collectionBlock default: defaultBlock [
	
	(anObject isKindOf: MOMatrix) ifTrue: [^matrixBlock value].
	(anObject isKindOf: Collection)
		ifTrue:
			[(anObject isEmpty not
				and:
					[anObject
						allSatisfy:
							[:each | (each isKindOf: Collection) and: [each size = anObject first size]]])
				ifTrue: [^nestedColletionBlock value]
				ifFalse: [^collectionBlock value]].
	^defaultBlock value
]

{ #category : #'constants access' }
MOMatrix class >> unity [
	
	^MOMatrixCoercion with: 1
]

{ #category : #private }
MOMatrix class >> vectorSpecies [
	
	^MOArrayVector
]

{ #category : #'instance creation' }
MOMatrix class >> withAll: object [
	
	| dimension |
	dimension := self
		switch: object
		caseMatrix: [object dimension]
		caseNestedCollection: [object size @ object first size]
		caseCollection: [1 @ object size]
		default: [0].
	^(self new: dimension)
		atAllPut: object;
		yourself
]

{ #category : #'constants access' }
MOMatrix class >> zero [
	
	^MOMatrixCoercion with: 0
]

{ #category : #arithmetic }
MOMatrix >> * aNumber [
	
	^aNumber productFromMatrix: self
]

{ #category : #arithmetic }
MOMatrix >> *= aNumber [
	
	^self
		with: (self coerce: aNumber)
		affect: [:a :b | a * b]
]

{ #category : #'matrix functions' }
MOMatrix >> *~ aMatrix [
	"Answer the matrix multiplication of the reciever with the argument."
	
	| newMatrix |
	self columnSize = aMatrix rowSize ifFalse: [Array new noMatchError].
	newMatrix := self species
		rows: self rowSize
		columns: aMatrix columnSize.	"workaround: this should be done in a more generic way with double dispatch."
	newMatrix
		putWithIndices:
			((aMatrix isKindOf: MODiagonalMatrix)
				ifTrue: [[:i :j | (self at: i and: j) * (aMatrix at: j and: j)]]
				ifFalse:
					[[:i :j | 
					(1 to: self columnSize)
						inject: 0
						into:
							[:sum :k | sum + ((self at: i and: k) * (aMatrix at: k and: j))]]]).
	^newMatrix
]

{ #category : #arithmetic }
MOMatrix >> + aNumber [
	
	^aNumber sumFromMatrix: self
]

{ #category : #arithmetic }
MOMatrix >> += aNumber [
	
	^self
		with: (self coerce: aNumber)
		affect: [:a :b | a + b]
]

{ #category : #arithmetic }
MOMatrix >> - aNumber [
	
	^aNumber differenceFromMatrix: self
]

{ #category : #arithmetic }
MOMatrix >> -= aNumber [
	
	^self
		with: (self coerce: aNumber)
		affect: [:a :b | a - b]
]

{ #category : #arithmetic }
MOMatrix >> / aNumber [
	
	^aNumber quotientFromMatrix: self
]

{ #category : #arithmetic }
MOMatrix >> /= aNumber [
	
	^self
		with: (self coerce: aNumber)
		affect: [:a :b | a / b]
]

{ #category : #comparing }
MOMatrix >> = matrix [
	"Answer whether the dimension of the receiver is the same as otherMatrix' dimension,
	and each of the receiver's elements equal the corresponding element of otherMatrix."
	
	^self == matrix
		or:
			[(matrix isKindOf: MOMatrix)
				and:
					[(matrix hasDimension: self dimension)
						and:
							[self
								with: matrix
								do: [:a :b | a = b ifFalse: [^false]].
							true]]]
]

{ #category : #resizing }
MOMatrix >> addColumn [
	"Add a column. Must implement if isExtendable returns true."
	
	self shouldNotImplement
]

{ #category : #resizing }
MOMatrix >> addColumnBeforeIndex: anIndex [
	"Insert a column before anIndex. Must implement if isResizebale returns true."
	
	self shouldNotImplement
]

{ #category : #resizing }
MOMatrix >> addRow [
	"Add a row. Must implement if isExtendable returns true."
	
	self shouldNotImplement
]

{ #category : #resizing }
MOMatrix >> addRowBeforeIndex: anIndex [
	"Insert a row before anIndex. Must implement if isResizebale returns true."
	
	self shouldNotImplement
]

{ #category : #converting }
MOMatrix >> asArray [
	
	| array stream |
	array := Array new: self rowSize * self columnSize.
	stream := WriteStream on: array.
	self do: [:each | stream nextPut: each].
	^array
]

{ #category : #accessing }
MOMatrix >> at: row and: column [
	"Answer the vakue at the given indices."
	
	^self subclassResponsibility
]

{ #category : #arithmetic }
MOMatrix >> at: row and: column add: aNumber [
	"Add aNumber to the element at row and column.  Answer the sum."
	
	^self
		at: row
		and: column
		put: (self at: row and: column) + aNumber
]

{ #category : #arithmetic }
MOMatrix >> at: row and: column divide: aNumber [
	"Divide the element at row and column by aNumber.  Answer the quotient."
	
	^self
		at: row
		and: column
		put: (self at: row and: column) / aNumber
]

{ #category : #arithmetic }
MOMatrix >> at: row and: column multiply: aNumber [
	"Multiply aNumber with the element at row and column.  Answer the product."
	
	^self
		at: row
		and: column
		put: (self at: row and: column) * aNumber
]

{ #category : #accessing }
MOMatrix >> at: row and: column put: aNumber [
	"Store the vakue at the given indices."
	
	^self subclassResponsibility
]

{ #category : #arithmetic }
MOMatrix >> at: row and: column subtract: aNumber [
	"Subtract aNumber from the element at row and column.  Answer the difference."
	
	^self
		at: row
		and: column
		put: (self at: row and: column) - aNumber
]

{ #category : #accessing }
MOMatrix >> atAllPut: object [
	
	self class
		switch: object
		caseMatrix:
			[self
				with: object
				affect: [:a :b | b]]
		caseNestedCollection:
			[object size = self rowSize
				ifTrue:
					[[object first size = self columnSize] assert.
					self putWithIndices: [:row :column | (object at: row) at: column]]
				ifFalse:
					[object size = self columnSize
						ifTrue:
							[[object first size = self rowSize] assert.
							self putWithIndices: [:row :column | (object at: column) at: row]]
						ifFalse: [Error raise]]]
		caseCollection:
			[| stream |
			[object size = (self rowSize * self columnSize)] assert.
			stream := ReadStream on: object.
			self
				withIndices:
					[:row :column | 
					self
						at: row
						and: column
						put: stream next]]
		default:
			[self withIndices: [:row :column | self at: row and: column put: object]].
	^object
]

{ #category : #accessing }
MOMatrix >> atPoint: rowColumnCoordinate [
	
	^self
		at: rowColumnCoordinate x
		and: rowColumnCoordinate y
]

{ #category : #accessing }
MOMatrix >> atPoint: rowColumnCoordinate put: aNumber [
	
	^self
		at: rowColumnCoordinate x
		and: rowColumnCoordinate y
		put: aNumber
]

{ #category : #private }
MOMatrix >> checkInvariant [
	
	^self subclassResponsibility
]

{ #category : #coercing }
MOMatrix >> coerce: aNumber [
	
	^MOMatrixCoercion with: aNumber
]

{ #category : #enumerating }
MOMatrix >> collect: aBlock [
	
	| newMatrix |
	newMatrix := self copyEmpty.
	self
		withIndices:
			[:row :column | 
			newMatrix
				at: row
				and: column
				put: (aBlock value: (self at: row and: column))].
	^newMatrix
]

{ #category : #'accessing vectorwise' }
MOMatrix >> columnAt: columnIndex [
	
	^MOMatrixPath column: columnIndex on: self
]

{ #category : #'accessing vectorwise' }
MOMatrix >> columnAt: columnIndex put: vector [
	
	vector doWithIndex: [:each :row | self at: row and: columnIndex put: each].
	^vector
]

{ #category : #accessing }
MOMatrix >> columnSize [
	
	^self subclassResponsibility
]

{ #category : #'accessing vectorwise' }
MOMatrix >> columns [
	
	| array |
	array := Array new: self columnSize.
	1
		to: self columnSize
		do:
			[:index | 
			array
				at: index
				put: (self columnAt: index)].
	^array
]

{ #category : #copying }
MOMatrix >> copyEmpty [
	"Answer a copy of the receiver that contains no elements."
	
	^self copyEmpty: self dimension
]

{ #category : #copying }
MOMatrix >> copyEmpty: dimension [
	"Answer a copy of the receiver that contains no elements."
	
	^self species new: dimension
]

{ #category : #copying }
MOMatrix >> deepCopy [
	
	^self species withAll: self
]

{ #category : #accessing }
MOMatrix >> density [
	
	^self sparseSize / self size
]

{ #category : #arithmetic }
MOMatrix >> determinant [
	
	| a11 a12 a21 a22 |
	[self hasDimension: 2 @ 2] assert.
	a11 := self atPoint: 1 @ 1.
	a12 := self atPoint: 1 @ 2.
	a21 := self atPoint: 2 @ 1.
	a22 := self atPoint: 2 @ 2.
	^a11 * a22 - (a12 * a21)
]

{ #category : #'accessing vectorwise' }
MOMatrix >> diagonal [
	
	^MOMatrixPath diagonalOn: self
]

{ #category : #'double dispatching' }
MOMatrix >> differenceFromDouble: aNumber [
	
	^self differenceFromNumber: aNumber
]

{ #category : #'double dispatching' }
MOMatrix >> differenceFromFixedPoint: aNumber [
	
	^self differenceFromNumber: aNumber
]

{ #category : #'double dispatching' }
MOMatrix >> differenceFromFloat: aNumber [
	
	^self differenceFromNumber: aNumber
]

{ #category : #'double dispatching' }
MOMatrix >> differenceFromFraction: aNumber [
	
	^self differenceFromNumber: aNumber
]

{ #category : #'double dispatching' }
MOMatrix >> differenceFromInteger: aNumber [
	
	^self differenceFromNumber: aNumber
]

{ #category : #'double dispatching' }
MOMatrix >> differenceFromMatrix: aMatrix [
	
	^aMatrix
		with: self
		collect: [:a :b | a - b]
]

{ #category : #'double dispatching' }
MOMatrix >> differenceFromNumber: aNumber [
	
	^self collect: [:b | aNumber - b]
]

{ #category : #'double dispatching' }
MOMatrix >> differenceFromPoint: aNumber [
	
	^self differenceFromNumber: aNumber
]

{ #category : #'double dispatching' }
MOMatrix >> differenceFromSmallDouble: aNumber [
	
	^self differenceFromNumber: aNumber
]

{ #category : #accessing }
MOMatrix >> dimension [
	
	^self rowSize @ self columnSize
]

{ #category : #enumerating }
MOMatrix >> do: aBlock [
	
	self
		withIndices: [:row :column | aBlock value: (self at: row and: column)].
	^self
]

{ #category : #enumerating }
MOMatrix >> doSparseWithIndices: eachRowColumnBlock [
	
	self
		doWithIndices:
			[:each :row :column | 
			each isZero
				ifFalse: [eachRowColumnBlock value: each value: row value: column]].
	^self
]

{ #category : #enumerating }
MOMatrix >> doWithIndices: eachRowColumnBlock [
	
	self
		withIndices:
			[:row :column | 
			eachRowColumnBlock
				value: (self at: row and: column)
				value: row
				value: column]
]

{ #category : #accessing }
MOMatrix >> first [
	
	^self at: 1 and: 1
]

{ #category : #coercing }
MOMatrix >> generality [
	
	^240
]

{ #category : #testing }
MOMatrix >> hasDimension: aDimension [
	
	^self dimension = aDimension
]

{ #category : #comparing }
MOMatrix >> hash [
	
	^(self dimension hash bitXor: (self at: 1) hash)
		bitXor: (self at: self dimension) hash
]

{ #category : #'initialize-release' }
MOMatrix >> initializeRows: m columns: n [
	
	^self subclassResponsibility
]

{ #category : #enumerating }
MOMatrix >> inject: value into: aBlock [
	
	| result |
	result := value.
	self do: [:each | result := aBlock value: result value: each].
	^result
]

{ #category : #testing }
MOMatrix >> isComplex [
	
	^false
]

{ #category : #testing }
MOMatrix >> isDiagonal [
	"Answer if the reciever is a diagonal matrix."
	
	self isSquare ifFalse: [^false].
	self
		doSparseWithIndices:
			[:value :row :column | row = column ifFalse: [^false]].
	^true
]

{ #category : #testing }
MOMatrix >> isResizeable [
	
	^false
]

{ #category : #testing }
MOMatrix >> isSquare [
	"Answer if the reciever is a square matrix."
	
	^self rowSize = self columnSize
]

{ #category : #testing }
MOMatrix >> isSymetric [
	"Answer if the reciever is a symetric matrix."
	
	self isSquare ifFalse: [^false].
	1
		to: self columnSize
		do:
			[:column | 
			1
				to: column
				do:
					[:row | (self at: column and: row) = (self at: row and: column) ifFalse: [^false]]].
	^true
]

{ #category : #testing }
MOMatrix >> isZero [
	"Answer if the reciever contains no non-zero numbers."
	
	self doSparseWithIndices: [:value :row :column | ^false].
	^true
]

{ #category : #testing }
MOMatrix >> isZeroAt: row and: column [
	
	^(self at: row and: column) isZero
]

{ #category : #accessing }
MOMatrix >> last [
	
	^self
		at: self rowSize
		and: self columnSize
]

{ #category : #private }
MOMatrix >> noMatchError [
	
	Error raise
]

{ #category : #private }
MOMatrix >> noModificationError [
	
	Error raise
]

{ #category : #printing }
MOMatrix >> printOn: aStream [
	"Append to the argument aStream a sequence of characters that identifies the matrix."
	
	| tooMany |
	tooMany := aStream position + 5000.
	aStream
		print: self class;
		space;
		print: self dimension;
		space;
		nextPut: $(.
	(1 to: self rowSize)
		do:
			[:row | 
			aStream nextPut: $(.
			(1 to: self columnSize)
				do:
					[:column | 
					aStream position > tooMany
						ifTrue:
							[aStream nextPutAll: (#etc << #dialogs >> '...etc...') asString , '))'.
							^self].
					aStream print: (self at: row and: column)]
				separatedBy: [aStream space].
			aStream nextPut: $)]
		separatedBy: [aStream space].
	aStream nextPut: $)
]

{ #category : #'double dispatching' }
MOMatrix >> productFromDouble: aNumber [
	
	^self productFromNumber: aNumber
]

{ #category : #'double dispatching' }
MOMatrix >> productFromFixedPoint: aNumber [
	
	^self productFromNumber: aNumber
]

{ #category : #'double dispatching' }
MOMatrix >> productFromFloat: aNumber [
	
	^self productFromNumber: aNumber
]

{ #category : #'double dispatching' }
MOMatrix >> productFromFraction: aNumber [
	
	^self productFromNumber: aNumber
]

{ #category : #'double dispatching' }
MOMatrix >> productFromInteger: aNumber [
	
	^self productFromNumber: aNumber
]

{ #category : #'double dispatching' }
MOMatrix >> productFromMatrix: aMatrix [
	
	^aMatrix
		with: self
		collect: [:a :b | a * b]
]

{ #category : #'double dispatching' }
MOMatrix >> productFromNumber: aNumber [
	
	^self collect: [:b | aNumber * b]
]

{ #category : #'double dispatching' }
MOMatrix >> productFromPoint: aNumber [
	
	^self productFromNumber: aNumber
]

{ #category : #'double dispatching' }
MOMatrix >> productFromSmallDouble: aNumber [
	
	^self productFromNumber: aNumber
]

{ #category : #enumerating }
MOMatrix >> putWithIndices: rowColumnBlock [
	
	self
		withIndices:
			[:row :column | 
			self
				at: row
				and: column
				put: (rowColumnBlock value: row value: column)].
	^self
]

{ #category : #'double dispatching' }
MOMatrix >> quotientFromDouble: aNumber [
	
	^self quotientFromNumber: aNumber
]

{ #category : #'double dispatching' }
MOMatrix >> quotientFromFixedPoint: aNumber [
	
	^self quotientFromNumber: aNumber
]

{ #category : #'double dispatching' }
MOMatrix >> quotientFromFloat: aNumber [
	
	^self quotientFromNumber: aNumber
]

{ #category : #'double dispatching' }
MOMatrix >> quotientFromFraction: aNumber [
	
	^self quotientFromNumber: aNumber
]

{ #category : #'double dispatching' }
MOMatrix >> quotientFromInteger: aNumber [
	
	^self quotientFromNumber: aNumber
]

{ #category : #'double dispatching' }
MOMatrix >> quotientFromMatrix: aMatrix [
	
	^aMatrix
		with: self
		collect: [:a :b | a / b]
]

{ #category : #'double dispatching' }
MOMatrix >> quotientFromNumber: aNumber [
	
	^self collect: [:b | aNumber / b]
]

{ #category : #'double dispatching' }
MOMatrix >> quotientFromPoint: aNumber [
	
	^self quotientFromNumber: aNumber
]

{ #category : #'double dispatching' }
MOMatrix >> quotientFromSmallDouble: aNumber [
	
	^self quotientFromNumber: aNumber
]

{ #category : #arithmetic }
MOMatrix >> reciprocal [
	
	^self
		collect:
			[:each | 
			each isZero
				ifTrue: [each]
				ifFalse: [each reciprocal]]
]

{ #category : #resizing }
MOMatrix >> removeColumnAtIndex: anIndex [
	
	self shouldNotImplement
]

{ #category : #resizing }
MOMatrix >> removeRowAtIndex: anIndex [
	
	self shouldNotImplement
]

{ #category : #testing }
MOMatrix >> respondsToArithmetic [
	"We are arithmetic, yes."
	
	^true
]

{ #category : #arithmetic }
MOMatrix >> roundTo: aNumber [
	
	^self collect: [:each | each roundTo: aNumber]
]

{ #category : #'accessing vectorwise' }
MOMatrix >> rowAt: rowIndex [
	
	^MOMatrixPath row: rowIndex on: self
]

{ #category : #'accessing vectorwise' }
MOMatrix >> rowAt: rowIndex put: vector [
	
	vector
		doWithIndex: [:each :column | self at: rowIndex and: column put: each].
	^vector
]

{ #category : #accessing }
MOMatrix >> rowSize [
	
	^self subclassResponsibility
]

{ #category : #'accessing vectorwise' }
MOMatrix >> rows [
	
	| array |
	array := Array new: self rowSize.
	1
		to: self rowSize
		do:
			[:index | 
			array
				at: index
				put: (self rowAt: index)].
	^array
]

{ #category : #accessing }
MOMatrix >> size [
	
	^self rowSize * self columnSize
]

{ #category : #accessing }
MOMatrix >> sparseSize [
	
	| tally |
	tally := 0.
	self do: [:each | each isZero ifTrue: [tally := tally + 1]].
	^tally
]

{ #category : #private }
MOMatrix >> species [
	
	^self class
]

{ #category : #printing }
MOMatrix >> storeDenseTextOn: aStream [
	"Append to the argument aStream a sequence of characters 
	that identifies the collection."
	
	aStream
		print: self rowSize;
		space;
		print: self columnSize;
		cr.
	1
		to: self rowSize
		do:
			[:row | 
			(1 to: self columnSize)
				do: [:column | aStream print: (self at: row and: column)]
				separatedBy: [aStream space].
			aStream cr]
]

{ #category : #printing }
MOMatrix >> storeSparseBinaryOn: aBinaryStream [
	
	| stream |
	stream := NetworkByteOrderStream wrap: aBinaryStream.
	stream
		nextLongPut: self columnSize;
		nextLongPut: self rowSize;
		nextLongPut: self sparseSize.
	self rows
		do:
			[:rows | 
			stream nextLongPut: rows sparseSize.
			rows
				doSparseWithIndex:
					[:value :index | 
					stream
						nextLongPut: index - 1;
						nextFloatPut: value]]
]

{ #category : #printing }
MOMatrix >> storeSparseTextOn: aStream [
	"Append to the argument aStream a sequence of characters 
	that identifies the collection."
	
	aStream
		print: self columnSize;
		space;
		print: self rowSize;
		space;
		print: self sparseSize;
		cr.
	self rows
		do:
			[:row | 
			aStream
				print: row sparseSize;
				cr.
			row
				doSparseWithIndex:
					[:value :index | 
					aStream
						print: index - 1;
						space;
						print: value;
						cr]]
]

{ #category : #printing }
MOMatrix >> storeTransposedSparseBinaryOn: aBinaryStream [
	
	| stream |
	stream := NetworkByteOrderStream wrap: aBinaryStream.
	stream
		nextLongPut: self rowSize;
		nextLongPut: self columnSize;
		nextLongPut: self sparseSize.
	self columns
		do:
			[:column | 
			stream nextLongPut: column sparseSize.
			column
				doSparseWithIndex:
					[:value :index | 
					stream
						nextLongPut: index - 1;
						nextFloatPut: value]]
]

{ #category : #'double dispatching' }
MOMatrix >> sumFromDouble: aNumber [
	
	^self sumFromNumber: aNumber
]

{ #category : #'double dispatching' }
MOMatrix >> sumFromFixedPoint: aNumber [
	
	^self sumFromNumber: aNumber
]

{ #category : #'double dispatching' }
MOMatrix >> sumFromFloat: aNumber [
	
	^self sumFromNumber: aNumber
]

{ #category : #'double dispatching' }
MOMatrix >> sumFromFraction: aNumber [
	
	^self sumFromNumber: aNumber
]

{ #category : #'double dispatching' }
MOMatrix >> sumFromInteger: aNumber [
	
	^self sumFromNumber: aNumber
]

{ #category : #'double dispatching' }
MOMatrix >> sumFromMatrix: aMatrix [
	
	^aMatrix
		with: self
		collect: [:a :b | a + b]
]

{ #category : #'double dispatching' }
MOMatrix >> sumFromNumber: aNumber [
	
	^self collect: [:b | aNumber + b]
]

{ #category : #'double dispatching' }
MOMatrix >> sumFromPoint: aNumber [
	
	^self sumFromNumber: aNumber
]

{ #category : #'double dispatching' }
MOMatrix >> sumFromSmallDouble: aNumber [
	
	^self sumFromNumber: aNumber
]

{ #category : #'matrix functions' }
MOMatrix >> transposed [
	
	^MOMatrixView transposeOn: self
]

{ #category : #private }
MOMatrix >> vectorSpecies [
	
	^self class vectorSpecies
]

{ #category : #enumerating }
MOMatrix >> with: aMatrix affect: eachOtherBlock [
	
	[aMatrix hasDimension: self dimension] assert.
	self
		putWithIndices:
			[:row :column | 
			eachOtherBlock
				value: (self at: row and: column)
				value: (aMatrix at: row and: column)]
]

{ #category : #enumerating }
MOMatrix >> with: aMatrix collect: eachOtherBlock [
	
	| newMatrix |
	[aMatrix hasDimension: self dimension] assert.
	newMatrix := self copyEmpty: self dimension.
	newMatrix
		putWithIndices:
			[:row :column | 
			eachOtherBlock
				value: (self at: row and: column)
				value: (aMatrix at: row and: column)].
	^newMatrix
]

{ #category : #enumerating }
MOMatrix >> with: aMatrix do: eachOtherBlock [
	
	[aMatrix hasDimension: self dimension] assert.
	self
		withIndices:
			[:row :column | 
			eachOtherBlock
				value: (self at: row and: column)
				value: (aMatrix at: row and: column)]
]

{ #category : #enumerating }
MOMatrix >> withIndices: aBlock [
	
	1
		to: self rowSize
		do:
			[:row | 
			1
				to: self columnSize
				do: [:column | aBlock value: row value: column]]
]
