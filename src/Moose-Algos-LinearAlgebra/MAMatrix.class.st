"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MAMatrix,
	#superclass : #Object,
	#category : #'Moose-Algos-LinearAlgebra'
}

{ #category : #accessing }
MAMatrix class >> browserIcon [
"Answer icon to be displayed with matrix classes."
	
	^ nil
]

{ #category : #'instance creation' }
MAMatrix class >> new [
	"Create a new matrix with dimension zero."
	
	^self new: Number zero
]

{ #category : #'instance creation' }
MAMatrix class >> new: numberOrPoint [
	"Create a new square matrix with the given dimension."
	
	| point |
	point := numberOrPoint asPoint.
	^self
		rows: point x
		columns: point y
]

{ #category : #'instance creation' }
MAMatrix class >> new: numberOrPoint withAll: value [
	
	^(self new: numberOrPoint)
		atAllPut: value;
		yourself
]

{ #category : #'instance creation' }
MAMatrix class >> readFromDenseText: aStream [
	
	| m n matrix tmp |
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
						"put: (tmp := (Number readSmalltalkAndCSyntaxFrom: aStream skipSeparators))."
						put: (tmp := (Number readFrom: aStream skipSeparators)).
						
						]].
	^matrix
]

{ #category : #'instance creation' }
MAMatrix class >> readFromSparseText: aStream [
	
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
MAMatrix class >> rows: m columns: n [
	"Create a new matrix with m rows and n columns."
	
	^(self basicNew)
		initializeRows: m columns: n;
		yourself
]

{ #category : #'instance creation' }
MAMatrix class >> rows: m columns: n withAll: value [
	
	^(self rows: m columns: n)
		atAllPut: value;
		yourself
]

{ #category : #private }
MAMatrix class >> switch: anObject caseMatrix: matrixBlock caseNestedCollection: nestedColletionBlock caseCollection: collectionBlock default: defaultBlock [
	
	(anObject isKindOf: MAMatrix) ifTrue: [^matrixBlock value].
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
MAMatrix class >> unity [
	
	^MAMatrixCoercion with: 1
]

{ #category : #private }
MAMatrix class >> vectorSpecies [
	
	^MAArrayVector
]

{ #category : #'instance creation' }
MAMatrix class >> withAll: object [
	
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
MAMatrix class >> zero [
	
	^MAMatrixCoercion with: 0
]

{ #category : #arithmetic }
MAMatrix >> * aNumber [
	
	^aNumber productFromMatrix: self
]

{ #category : #arithmetic }
MAMatrix >> *= aNumber [
	
	^self
		with: (self coerce: aNumber)
		affect: [:a :b | a * b]
]

{ #category : #'matrix functions' }
MAMatrix >> *~ aMatrix [
	"Answer the matrix multiplication of the reciever with the argument."
	
	| newMatrix |
	self columnSize = aMatrix rowSize ifFalse: [Array new noMatchError].
	newMatrix := self species
		rows: self rowSize
		columns: aMatrix columnSize.	"workaround: this should be done in a more generic way with double dispatch."
	newMatrix
		putWithIndices:
			((aMatrix isKindOf: MADiagonalMatrix)
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
MAMatrix >> + aNumber [
	
	^aNumber sumFromMatrix: self
]

{ #category : #arithmetic }
MAMatrix >> += aNumber [
	
	^self
		with: (self coerce: aNumber)
		affect: [:a :b | a + b]
]

{ #category : #arithmetic }
MAMatrix >> - aNumber [
	
	^aNumber differenceFromMatrix: self
]

{ #category : #arithmetic }
MAMatrix >> -= aNumber [
	
	^self
		with: (self coerce: aNumber)
		affect: [:a :b | a - b]
]

{ #category : #arithmetic }
MAMatrix >> / aNumber [
	
	^aNumber quotientFromMatrix: self
]

{ #category : #arithmetic }
MAMatrix >> /= aNumber [
	
	^self
		with: (self coerce: aNumber)
		affect: [:a :b | a / b]
]

{ #category : #comparing }
MAMatrix >> = matrix [
	"Answer whether the dimension of the receiver is the same as otherMatrix' dimension,
	and each of the receiver's elements equal the corresponding element of otherMatrix."
	
	^self == matrix
		or:
			[(matrix isKindOf: MAMatrix)
				and:
					[(matrix hasDimension: self dimension)
						and:
							[self
								with: matrix
								do: [:a :b | a = b ifFalse: [^false]].
							true]]]
]

{ #category : #arithmetic }
MAMatrix >> adaptToNumber: rcvr andSend: selector [

	^ self perform: selector with: rcvr
]

{ #category : #arithmetic }
MAMatrix >> adaptToPoint: rcvr andSend: selector [

	^ self perform: selector with: rcvr
]

{ #category : #resizing }
MAMatrix >> addColumn [
	"Add a column. Must implement if isExtendable returns true."
	
	self shouldNotImplement
]

{ #category : #resizing }
MAMatrix >> addColumnBeforeIndex: anIndex [
	"Insert a column before anIndex. Must implement if isResizebale returns true."
	
	self shouldNotImplement
]

{ #category : #resizing }
MAMatrix >> addRow [
	"Add a row. Must implement if isExtendable returns true."
	
	self shouldNotImplement
]

{ #category : #resizing }
MAMatrix >> addRowBeforeIndex: anIndex [
	"Insert a row before anIndex. Must implement if isResizebale returns true."
	
	self shouldNotImplement
]

{ #category : #converting }
MAMatrix >> asArray [
	
	| array stream |
	array := Array new: self rowSize * self columnSize.
	stream := WriteStream on: array.
	self do: [:each | stream nextPut: each].
	^array
]

{ #category : #accessing }
MAMatrix >> at: row and: column [
	"Answer the vakue at the given indices."
	
	^self subclassResponsibility
]

{ #category : #arithmetic }
MAMatrix >> at: row and: column add: aNumber [
	"Add aNumber to the element at row and column.  Answer the sum."
	
	^self
		at: row
		and: column
		put: (self at: row and: column) + aNumber
]

{ #category : #arithmetic }
MAMatrix >> at: row and: column divide: aNumber [
	"Divide the element at row and column by aNumber.  Answer the quotient."
	
	^self
		at: row
		and: column
		put: (self at: row and: column) / aNumber
]

{ #category : #arithmetic }
MAMatrix >> at: row and: column multiply: aNumber [
	"Multiply aNumber with the element at row and column.  Answer the product."
	
	^self
		at: row
		and: column
		put: (self at: row and: column) * aNumber
]

{ #category : #accessing }
MAMatrix >> at: row and: column put: aNumber [
	"Store the vakue at the given indices."
	
	^self subclassResponsibility
]

{ #category : #arithmetic }
MAMatrix >> at: row and: column subtract: aNumber [
	"Subtract aNumber from the element at row and column.  Answer the difference."
	
	^self
		at: row
		and: column
		put: (self at: row and: column) - aNumber
]

{ #category : #accessing }
MAMatrix >> atAllPut: object [
	
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
MAMatrix >> atPoint: rowColumnCoordinate [
	
	^self
		at: rowColumnCoordinate x
		and: rowColumnCoordinate y
]

{ #category : #accessing }
MAMatrix >> atPoint: rowColumnCoordinate put: aNumber [
	
	^self
		at: rowColumnCoordinate x
		and: rowColumnCoordinate y
		put: aNumber
]

{ #category : #private }
MAMatrix >> checkInvariant [
	
	^self subclassResponsibility
]

{ #category : #coercing }
MAMatrix >> coerce: aNumber [
	
	^MAMatrixCoercion with: aNumber
]

{ #category : #enumerating }
MAMatrix >> collect: aBlock [
	
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
MAMatrix >> columnAt: columnIndex [
	
	^MAMatrixPath column: columnIndex on: self
]

{ #category : #'accessing vectorwise' }
MAMatrix >> columnAt: columnIndex put: vector [
	
	vector doWithIndex: [:each :row | self at: row and: columnIndex put: each].
	^vector
]

{ #category : #accessing }
MAMatrix >> columnSize [
	
	^self subclassResponsibility
]

{ #category : #'accessing vectorwise' }
MAMatrix >> columns [
	
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
MAMatrix >> copyEmpty [
	"Answer a copy of the receiver that contains no elements."
	
	^self copyEmpty: self dimension
]

{ #category : #copying }
MAMatrix >> copyEmpty: dimension [
	"Answer a copy of the receiver that contains no elements."
	
	^self species new: dimension
]

{ #category : #copying }
MAMatrix >> deepCopy [
	
	^self species withAll: self
]

{ #category : #accessing }
MAMatrix >> density [
	
	^self sparseSize / self size
]

{ #category : #arithmetic }
MAMatrix >> determinant [
	
	| a11 a12 a21 a22 |
	[self hasDimension: 2 @ 2] assert.
	a11 := self atPoint: 1 @ 1.
	a12 := self atPoint: 1 @ 2.
	a21 := self atPoint: 2 @ 1.
	a22 := self atPoint: 2 @ 2.
	^a11 * a22 - (a12 * a21)
]

{ #category : #'accessing vectorwise' }
MAMatrix >> diagonal [
	
	^MAMatrixPath diagonalOn: self
]

{ #category : #'double dispatching' }
MAMatrix >> differenceFromDouble: aNumber [
	
	^self differenceFromNumber: aNumber
]

{ #category : #'double dispatching' }
MAMatrix >> differenceFromFixedPoint: aNumber [
	
	^self differenceFromNumber: aNumber
]

{ #category : #'double dispatching' }
MAMatrix >> differenceFromFloat: aNumber [
	
	^self differenceFromNumber: aNumber
]

{ #category : #'double dispatching' }
MAMatrix >> differenceFromFraction: aNumber [
	
	^self differenceFromNumber: aNumber
]

{ #category : #'double dispatching' }
MAMatrix >> differenceFromInteger: aNumber [
	
	^self differenceFromNumber: aNumber
]

{ #category : #'double dispatching' }
MAMatrix >> differenceFromMatrix: aMatrix [
	
	^aMatrix
		with: self
		collect: [:a :b | a - b]
]

{ #category : #'double dispatching' }
MAMatrix >> differenceFromNumber: aNumber [
	
	^self collect: [:b | aNumber - b]
]

{ #category : #'double dispatching' }
MAMatrix >> differenceFromPoint: aNumber [
	
	^self differenceFromNumber: aNumber
]

{ #category : #'double dispatching' }
MAMatrix >> differenceFromSmallDouble: aNumber [
	
	^self differenceFromNumber: aNumber
]

{ #category : #accessing }
MAMatrix >> dimension [
	
	^self rowSize @ self columnSize
]

{ #category : #enumerating }
MAMatrix >> do: aBlock [
	
	self
		withIndices: [:row :column | aBlock value: (self at: row and: column)].
	^self
]

{ #category : #enumerating }
MAMatrix >> doSparseWithIndices: eachRowColumnBlock [
	
	self
		doWithIndices:
			[:each :row :column | 
			each isZero
				ifFalse: [eachRowColumnBlock value: each value: row value: column]].
	^self
]

{ #category : #enumerating }
MAMatrix >> doWithIndices: eachRowColumnBlock [
	
	self
		withIndices:
			[:row :column | 
			eachRowColumnBlock
				value: (self at: row and: column)
				value: row
				value: column]
]

{ #category : #accessing }
MAMatrix >> first [
	
	^self at: 1 and: 1
]

{ #category : #coercing }
MAMatrix >> generality [
	
	^240
]

{ #category : #testing }
MAMatrix >> hasDimension: aDimension [
	
	^self dimension = aDimension
]

{ #category : #comparing }
MAMatrix >> hash [
	
	^(self dimension hash bitXor: (self at: 1) hash)
		bitXor: (self at: self dimension) hash
]

{ #category : #'initialize-release' }
MAMatrix >> initializeRows: m columns: n [
	
	^self subclassResponsibility
]

{ #category : #enumerating }
MAMatrix >> inject: value into: aBlock [
	
	| result |
	result := value.
	self do: [:each | result := aBlock value: result value: each].
	^result
]

{ #category : #testing }
MAMatrix >> isComplex [
	
	^false
]

{ #category : #testing }
MAMatrix >> isDiagonal [
	"Answer if the reciever is a diagonal matrix."
	
	self isSquare ifFalse: [^false].
	self
		doSparseWithIndices:
			[:value :row :column | row = column ifFalse: [^false]].
	^true
]

{ #category : #testing }
MAMatrix >> isResizeable [
	
	^false
]

{ #category : #testing }
MAMatrix >> isSquare [
	"Answer if the reciever is a square matrix."
	
	^self rowSize = self columnSize
]

{ #category : #testing }
MAMatrix >> isSymetric [
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
MAMatrix >> isZero [
	"Answer if the reciever contains no non-zero numbers."
	
	self doSparseWithIndices: [:value :row :column | ^false].
	^true
]

{ #category : #testing }
MAMatrix >> isZeroAt: row and: column [
	
	^(self at: row and: column) isZero
]

{ #category : #accessing }
MAMatrix >> last [
	
	^self
		at: self rowSize
		and: self columnSize
]

{ #category : #private }
MAMatrix >> noMatchError [
	
	Error raise
]

{ #category : #private }
MAMatrix >> noModificationError [
	
	Error raise
]

{ #category : #printing }
MAMatrix >> printOn: aStream [
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
MAMatrix >> productFromDouble: aNumber [
	
	^self productFromNumber: aNumber
]

{ #category : #'double dispatching' }
MAMatrix >> productFromFixedPoint: aNumber [
	
	^self productFromNumber: aNumber
]

{ #category : #'double dispatching' }
MAMatrix >> productFromFloat: aNumber [
	
	^self productFromNumber: aNumber
]

{ #category : #'double dispatching' }
MAMatrix >> productFromFraction: aNumber [
	
	^self productFromNumber: aNumber
]

{ #category : #'double dispatching' }
MAMatrix >> productFromInteger: aNumber [
	
	^self productFromNumber: aNumber
]

{ #category : #'double dispatching' }
MAMatrix >> productFromMatrix: aMatrix [
	
	^aMatrix
		with: self
		collect: [:a :b | a * b]
]

{ #category : #'double dispatching' }
MAMatrix >> productFromNumber: aNumber [
	
	^self collect: [:b | aNumber * b]
]

{ #category : #'double dispatching' }
MAMatrix >> productFromPoint: aNumber [
	
	^self productFromNumber: aNumber
]

{ #category : #'double dispatching' }
MAMatrix >> productFromSmallDouble: aNumber [
	
	^self productFromNumber: aNumber
]

{ #category : #enumerating }
MAMatrix >> putWithIndices: rowColumnBlock [
	
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
MAMatrix >> quotientFromDouble: aNumber [
	
	^self quotientFromNumber: aNumber
]

{ #category : #'double dispatching' }
MAMatrix >> quotientFromFixedPoint: aNumber [
	
	^self quotientFromNumber: aNumber
]

{ #category : #'double dispatching' }
MAMatrix >> quotientFromFloat: aNumber [
	
	^self quotientFromNumber: aNumber
]

{ #category : #'double dispatching' }
MAMatrix >> quotientFromFraction: aNumber [
	
	^self quotientFromNumber: aNumber
]

{ #category : #'double dispatching' }
MAMatrix >> quotientFromInteger: aNumber [
	
	^self quotientFromNumber: aNumber
]

{ #category : #'double dispatching' }
MAMatrix >> quotientFromMatrix: aMatrix [
	
	^aMatrix
		with: self
		collect: [:a :b | a / b]
]

{ #category : #'double dispatching' }
MAMatrix >> quotientFromNumber: aNumber [
	
	^self collect: [:b | aNumber / b]
]

{ #category : #'double dispatching' }
MAMatrix >> quotientFromPoint: aNumber [
	
	^self quotientFromNumber: aNumber
]

{ #category : #'double dispatching' }
MAMatrix >> quotientFromSmallDouble: aNumber [
	
	^self quotientFromNumber: aNumber
]

{ #category : #arithmetic }
MAMatrix >> reciprocal [
	
	^self
		collect:
			[:each | 
			each isZero
				ifTrue: [each]
				ifFalse: [each reciprocal]]
]

{ #category : #converting }
MAMatrix >> remap: mapping [
	
	^MAMappedMatrix on: self rowMap: mapping columnMap: mapping
]

{ #category : #resizing }
MAMatrix >> removeColumnAtIndex: anIndex [
	
	self shouldNotImplement
]

{ #category : #resizing }
MAMatrix >> removeRowAtIndex: anIndex [
	
	self shouldNotImplement
]

{ #category : #testing }
MAMatrix >> respondsToArithmetic [
	"We are arithmetic, yes."
	
	^true
]

{ #category : #arithmetic }
MAMatrix >> roundTo: aNumber [
	
	^self collect: [:each | each roundTo: aNumber]
]

{ #category : #'accessing vectorwise' }
MAMatrix >> rowAt: rowIndex [
	
	^MAMatrixPath row: rowIndex on: self
]

{ #category : #'accessing vectorwise' }
MAMatrix >> rowAt: rowIndex put: vector [
	
	vector
		doWithIndex: [:each :column | self at: rowIndex and: column put: each].
	^vector
]

{ #category : #accessing }
MAMatrix >> rowSize [
	
	^self subclassResponsibility
]

{ #category : #'accessing vectorwise' }
MAMatrix >> rows [
	
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
MAMatrix >> size [
	
	^self rowSize * self columnSize
]

{ #category : #accessing }
MAMatrix >> sparseSize [
	
	| tally |
	tally := 0.
	self do: [:each | each isZero ifTrue: [tally := tally + 1]].
	^tally
]

{ #category : #private }
MAMatrix >> species [
	
	^self class
]

{ #category : #printing }
MAMatrix >> storeDenseTextOn: aStream [
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
MAMatrix >> storeSparseTextOn: aStream [
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

{ #category : #'double dispatching' }
MAMatrix >> sumFromDouble: aNumber [
	
	^self sumFromNumber: aNumber
]

{ #category : #'double dispatching' }
MAMatrix >> sumFromFixedPoint: aNumber [
	
	^self sumFromNumber: aNumber
]

{ #category : #'double dispatching' }
MAMatrix >> sumFromFloat: aNumber [
	
	^self sumFromNumber: aNumber
]

{ #category : #'double dispatching' }
MAMatrix >> sumFromFraction: aNumber [
	
	^self sumFromNumber: aNumber
]

{ #category : #'double dispatching' }
MAMatrix >> sumFromInteger: aNumber [
	
	^self sumFromNumber: aNumber
]

{ #category : #'double dispatching' }
MAMatrix >> sumFromMatrix: aMatrix [
	
	^aMatrix
		with: self
		collect: [:a :b | a + b]
]

{ #category : #'double dispatching' }
MAMatrix >> sumFromNumber: aNumber [
	
	^self collect: [:b | aNumber + b]
]

{ #category : #'double dispatching' }
MAMatrix >> sumFromPoint: aNumber [
	
	^self sumFromNumber: aNumber
]

{ #category : #'double dispatching' }
MAMatrix >> sumFromSmallDouble: aNumber [
	
	^self sumFromNumber: aNumber
]

{ #category : #'matrix functions' }
MAMatrix >> transposed [
	
	^MAMatrixView transposeOn: self
]

{ #category : #private }
MAMatrix >> vectorSpecies [
	
	^self class vectorSpecies
]

{ #category : #enumerating }
MAMatrix >> with: aMatrix affect: eachOtherBlock [
	
	[aMatrix hasDimension: self dimension] assert.
	self
		putWithIndices:
			[:row :column | 
			eachOtherBlock
				value: (self at: row and: column)
				value: (aMatrix at: row and: column)]
]

{ #category : #enumerating }
MAMatrix >> with: aMatrix collect: eachOtherBlock [
	
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
MAMatrix >> with: aMatrix do: eachOtherBlock [
	
	[aMatrix hasDimension: self dimension] assert.
	self
		withIndices:
			[:row :column | 
			eachOtherBlock
				value: (self at: row and: column)
				value: (aMatrix at: row and: column)]
]

{ #category : #enumerating }
MAMatrix >> withIndices: aBlock [
	
	1
		to: self rowSize
		do:
			[:row | 
			1
				to: self columnSize
				do: [:column | aBlock value: row value: column]]
]
