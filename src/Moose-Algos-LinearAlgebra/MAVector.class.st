"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MAVector,
	#superclass : #ArrayedCollection,
	#category : #'Moose-Algos-LinearAlgebra'
}

{ #category : #accessing }
MAVector class >> browserIcon [
"Answer icon to be displayed with matrix classes."
	
	^ nil
]

{ #category : #'instance creation' }
MAVector class >> new [
	
	^self new: 0
]

{ #category : #'instance creation' }
MAVector class >> new: aSize [
	
	^(self basicNew)
		initializeSize: aSize;
		yourself
]

{ #category : #'instance creation' }
MAVector class >> new: aSize withAll: value [
	
	^(self new: aSize)
		atAllPut: value;
		yourself
]

{ #category : #'instance creation' }
MAVector class >> readFromDenseText: aStream [
	
	| size vector |
	size := Integer readFrom: aStream skipSeparators.
	vector := self new: size.
	1
		to: size
		do:
			[:index | 
			vector
				at: index
				"put: (Number readSmalltalkAndCSyntaxFrom: aStream skipSeparators)"
				put: (Number readFrom: aStream skipSeparators)].
	^vector
]

{ #category : #'constants access' }
MAVector class >> unity [
	
	^MAVectorCoercion with: 1
]

{ #category : #'instance creation' }
MAVector class >> withAll: aCollection [
	
	^(self new: aCollection size)
		atAllPut: aCollection;
		yourself
]

{ #category : #'constants access' }
MAVector class >> zero [
	
	^MAVectorCoercion with: 0
]

{ #category : #arithmetic }
MAVector >> * aNumber [
	
	^aNumber productFromVector: self
]

{ #category : #arithmetic }
MAVector >> *= aNumber [
	
	^self
		with: (self coerce: aNumber)
		affect: [:a :b | a * b]
]

{ #category : #arithmetic }
MAVector >> + aNumber [
	
	^aNumber sumFromVector: self
]

{ #category : #arithmetic }
MAVector >> += aNumber [
	
	^self
		with: (self coerce: aNumber)
		affect: [:a :b | a + b]
]

{ #category : #arithmetic }
MAVector >> - aNumber [
	
	^aNumber differenceFromVector: self
]

{ #category : #arithmetic }
MAVector >> -= aNumber [
	
	^self
		with: (self coerce: aNumber)
		affect: [:a :b | a - b]
]

{ #category : #arithmetic }
MAVector >> / aNumber [
	
	^aNumber quotientFromVector: self
]

{ #category : #arithmetic }
MAVector >> /= aNumber [
	
	^self
		with: (self coerce: aNumber)
		affect: [:a :b | a / b]
]

{ #category : #comparing }
MAVector >> < aMagnitude [
	
	self error: 'Vectors are not ordered'
]

{ #category : #comparing }
MAVector >> = vector [
	
	^self == vector
		or:
			[(vector isKindOf: MAVector)
				and:
					[(vector hasSize: self size)
						and:
							[self
								with: vector
								do: [:a :b | a = b ifFalse: [^false]].
							true]]]
]

{ #category : #converting }
MAVector >> asVector [
	
	^self
]

{ #category : #accessing }
MAVector >> at: index [
	
	^self subclassResponsibility
]

{ #category : #arithmetic }
MAVector >> at: index add: aNumber [
	
	^self
		at: index
		put: (self at: index) + aNumber
]

{ #category : #accessing }
MAVector >> at: index ifNilPut: aBlock [
	"Answer the value at anIndex.  If the value is nil, set it to be
	the result of evaluating valueBlock, and answer that value."
	
	^(self at: index)
		ifNil:
			[self
				at: index
				put: aBlock value]
]

{ #category : #accessing }
MAVector >> at: index put: aNumber [
	
	^self subclassResponsibility
]

{ #category : #accessing }
MAVector >> atAllPut: collection [
	
	(collection isKindOf: Collection)
		ifTrue:
			[self
				with: collection
				affect: [:a :b | b]]
		ifFalse: [super atAllPut: collection]
]

{ #category : #coercing }
MAVector >> coerce: aNumber [
	
	^MAVectorCoercion with: aNumber
]

{ #category : #copying }
MAVector >> copyEmpty [
	
	^self copyEmpty: self size
]

{ #category : #copying }
MAVector >> copyEmpty: size [
	
	^self species new: size
]

{ #category : #'vector functions' }
MAVector >> cosine: aVector [
	
	^self unitVector dotProduct: aVector unitVector
]

{ #category : #copying }
MAVector >> deepCopy [
	
	^self species withAll: self
]

{ #category : #private }
MAVector >> defaultElement [
	
	^Float zero
]

{ #category : #'double dispatching' }
MAVector >> differenceFromDouble: aNumber [
	
	^self differenceFromNumber: aNumber
]

{ #category : #'double dispatching' }
MAVector >> differenceFromFixedPoint: aNumber [
	
	^self differenceFromNumber: aNumber
]

{ #category : #'double dispatching' }
MAVector >> differenceFromFloat: aNumber [
	
	^self differenceFromNumber: aNumber
]

{ #category : #'double dispatching' }
MAVector >> differenceFromFraction: aNumber [
	
	^self differenceFromNumber: aNumber
]

{ #category : #'double dispatching' }
MAVector >> differenceFromInteger: aNumber [
	
	^self differenceFromNumber: aNumber
]

{ #category : #'double dispatching' }
MAVector >> differenceFromNumber: aNumber [
	
	^self collect: [:b | aNumber - b]
]

{ #category : #'double dispatching' }
MAVector >> differenceFromPoint: aNumber [
	
	^self differenceFromNumber: aNumber
]

{ #category : #'double dispatching' }
MAVector >> differenceFromSmallDouble: aNumber [
	
	^self differenceFromNumber: aNumber
]

{ #category : #'double dispatching' }
MAVector >> differenceFromVector: aVector [
	
	^aVector
		with: self
		collect: [:a :b | a - b]
]

{ #category : #'vector functions' }
MAVector >> dist: aVector [
	
	| sum |
	sum := 0.
	self
		with: aVector
		do: [:a :b | sum := sum + ((a - b) ** 2)].
	^sum
]

{ #category : #enumerating }
MAVector >> do: aBlock [
	"Evaluate aBlock with each of the receiver's elements as the argument."
	
	1
		to: self size
		do: [:index | aBlock value: (self at: index)]
]

{ #category : #enumerating }
MAVector >> doSparseWithIndex: aBlock [
	
	self
		doWithIndex:
			[:each :index | each isZero ifFalse: [aBlock value: each value: index]].
	^self
]

{ #category : #'double dispatching' }
MAVector >> doesNotUnderstand: aMessage [
	
	^super doesNotUnderstand: aMessage
]

{ #category : #'vector functions' }
MAVector >> dotProduct: aVector [
	"comment stating purpose of message"
	
	| sum |
	(aVector hasSize: self size) ifFalse: [^self noMatchError].
	sum := 0.
	self
		with: aVector
		do: [:a :b | sum := sum + (a * b)].
	^sum
]

{ #category : #coercing }
MAVector >> generality [
	
	^210
]

{ #category : #testing }
MAVector >> hasSize: size [
	
	^self size = size
]

{ #category : #comparing }
MAVector >> hash [
	
	^(self size hash bitXor: (self at: 1) hash)
		bitXor: (self at: self size) hash
]

{ #category : #'initialize-release' }
MAVector >> initializeSize: aSize [
	
	^self subclassResponsibility
]

{ #category : #testing }
MAVector >> isZero [
	"comment stating purpose of message"
	
	^self allSatisfy: #isZero
]

{ #category : #testing }
MAVector >> isZeroAt: index [
	
	^(self at: index) isZero
]

{ #category : #'vector functions' }
MAVector >> length [
	"comment stating purpose of message"
	
	^(self dotProduct: self) sqrt
]

{ #category : #arithmetic }
MAVector >> negated [
	"comment stating purpose of message"
	
	^self collect: #negated
]

{ #category : #private }
MAVector >> noModificationError [
	
	Error raise
]

{ #category : #'vector functions' }
MAVector >> normalize [
	"comment stating purpose of message"
	
	| len |
	len := self length.
	len isZero
		ifTrue: [self atAllPut: len]
		ifFalse: [self /= self length].
	^self
]

{ #category : #'double dispatching' }
MAVector >> productFromDouble: aVector [
	
	^self productFromNumber: aVector
]

{ #category : #'double dispatching' }
MAVector >> productFromFixedPoint: aVector [
	
	^self productFromNumber: aVector
]

{ #category : #'double dispatching' }
MAVector >> productFromFloat: aVector [
	
	^self productFromNumber: aVector
]

{ #category : #'double dispatching' }
MAVector >> productFromFraction: aVector [
	
	^self productFromNumber: aVector
]

{ #category : #'double dispatching' }
MAVector >> productFromInteger: aVector [
	
	^self productFromNumber: aVector
]

{ #category : #'double dispatching' }
MAVector >> productFromNumber: aNumber [
	
	^self collect: [:b | aNumber * b]
]

{ #category : #'double dispatching' }
MAVector >> productFromPoint: aVector [
	
	^self productFromNumber: aVector
]

{ #category : #'double dispatching' }
MAVector >> productFromSmallDouble: aVector [
	
	^self productFromNumber: aVector
]

{ #category : #'double dispatching' }
MAVector >> productFromVector: aVector [
	
	^aVector
		with: self
		collect: [:a :b | a * b]
]

{ #category : #enumerating }
MAVector >> putWithIndex: aBlock [
	
	1
		to: self size
		do:
			[:index | 
			self
				at: index
				put: (aBlock value: index)]
]

{ #category : #'double dispatching' }
MAVector >> quotientFromDouble: aNumber [
	
	^self quotientFromNumber: aNumber
]

{ #category : #'double dispatching' }
MAVector >> quotientFromFixedPoint: aNumber [
	
	^self quotientFromNumber: aNumber
]

{ #category : #'double dispatching' }
MAVector >> quotientFromFloat: aNumber [
	
	^self quotientFromNumber: aNumber
]

{ #category : #'double dispatching' }
MAVector >> quotientFromFraction: aNumber [
	
	^self quotientFromNumber: aNumber
]

{ #category : #'double dispatching' }
MAVector >> quotientFromInteger: aNumber [
	
	^self quotientFromNumber: aNumber
]

{ #category : #'double dispatching' }
MAVector >> quotientFromNumber: aNumber [
	
	^self collect: [:b | aNumber / b]
]

{ #category : #'double dispatching' }
MAVector >> quotientFromPoint: aNumber [
	
	^self quotientFromNumber: aNumber
]

{ #category : #'double dispatching' }
MAVector >> quotientFromSmallDouble: aNumber [
	
	^self quotientFromNumber: aNumber
]

{ #category : #'double dispatching' }
MAVector >> quotientFromVector: aVector [
	
	^aVector
		with: self
		collect: [:a :b | a / b]
]

{ #category : #arithmetic }
MAVector >> reciprocal [
	"comment stating purpose of message"
	
	^self collect: #reciprocal
]

{ #category : #testing }
MAVector >> respondsToArithmetic [
	"We are arithmetic, yes."
	
	^true
]

{ #category : #accessing }
MAVector >> size [
	
	^self subclassResponsibility
]

{ #category : #accessing }
MAVector >> sparseSize [
	
	| tally |
	tally := 0.
	self doSparseWithIndex: [:each :index | tally := tally + 1].
	^tally
]

{ #category : #'mathematical functions' }
MAVector >> sqrt [
	
	^self collect: #sqrt
]

{ #category : #printing }
MAVector >> storeDenseTextOn: aStream [
	
	aStream
		print: self size;
		cr.
	self
		do: [:each | aStream print: each]
		separatedBy: [aStream space].
	aStream cr
]

{ #category : #'mathematical functions' }
MAVector >> sum [
	
	^self
		inject: 0
		into: [:sum :each | sum + each]
]

{ #category : #'double dispatching' }
MAVector >> sumFromDouble: aNumber [
	
	^self sumFromNumber: aNumber
]

{ #category : #'double dispatching' }
MAVector >> sumFromFixedPoint: aNumber [
	
	^self sumFromNumber: aNumber
]

{ #category : #'double dispatching' }
MAVector >> sumFromFloat: aNumber [
	
	^self sumFromNumber: aNumber
]

{ #category : #'double dispatching' }
MAVector >> sumFromFraction: aNumber [
	
	^self sumFromNumber: aNumber
]

{ #category : #'double dispatching' }
MAVector >> sumFromInteger: aNumber [
	
	^self sumFromNumber: aNumber
]

{ #category : #'double dispatching' }
MAVector >> sumFromNumber: aNumber [
	
	^self collect: [:b | aNumber + b]
]

{ #category : #'double dispatching' }
MAVector >> sumFromPoint: aNumber [
	
	^self collect: [:b | aNumber + b]
]

{ #category : #'double dispatching' }
MAVector >> sumFromSmallDouble: aNumber [
	
	^self sumFromNumber: aNumber
]

{ #category : #'double dispatching' }
MAVector >> sumFromVector: aVector [
	
	^aVector
		with: self
		collect: [:a :b | a + b]
]

{ #category : #'vector functions' }
MAVector >> unitVector [
	"comment stating purpose of message"
	
	self isZero ifTrue: [^self].
	^self / self length
]

{ #category : #enumerating }
MAVector >> with: vector affect: aBlock [
	
	(vector hasSize: self size) ifFalse: [^self noMatchError].
	1
		to: self size
		do:
			[:index | 
			self
				at: index
				put:
					(aBlock
						value: (self at: index)
						value: (vector at: index))].
	^self
]

{ #category : #enumerating }
MAVector >> with: vector collect: aBlock [
	
	| newVector |
	(vector hasSize: self size) ifFalse: [^self noMatchError].
	newVector := self species new: self size.
	1
		to: self size
		do:
			[:index | 
			newVector
				at: index
				put:
					(aBlock
						value: (self at: index)
						value: (vector at: index))].
	^newVector
]

{ #category : #enumerating }
MAVector >> with: vector do: aBlock [
	
	(vector hasSize: self size) ifFalse: [^self noMatchError].
	1
		to: self size
		do:
			[:index | 
			aBlock
				value: (self at: index)
				value: (vector at: index)].
	^self
]
