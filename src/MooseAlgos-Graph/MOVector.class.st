"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MOVector,
	#superclass : #ArrayedCollection,
	#category : #'MooseAlgos-LinearAlgebra'
}

{ #category : #accessing }
MOVector class >> browserIcon [
"Answer icon to be displayed with matrix classes."
	
	^ nil
]

{ #category : #'instance creation' }
MOVector class >> new [
	
	^self new: Number zero
]

{ #category : #'instance creation' }
MOVector class >> new: aSize [
	
	^(self basicNew)
		initializeSize: aSize;
		yourself
]

{ #category : #'instance creation' }
MOVector class >> new: aSize withAll: value [
	
	^(self new: aSize)
		atAllPut: value;
		yourself
]

{ #category : #'instance creation' }
MOVector class >> readFromDenseText: aStream [
	
	| size vector |
	size := Integer readFrom: aStream skipSeparators.
	vector := self new: size.
	1
		to: size
		do:
			[:index | 
			vector
				at: index
				put: (Number readSmalltalkAndCSyntaxFrom: aStream skipSeparators)].
	^vector
]

{ #category : #'constants access' }
MOVector class >> unity [
	
	^MOVectorCoercion with: 1
]

{ #category : #'instance creation' }
MOVector class >> withAll: aCollection [
	
	^(self new: aCollection size)
		atAllPut: aCollection;
		yourself
]

{ #category : #'constants access' }
MOVector class >> zero [
	
	^MOVectorCoercion with: 0
]

{ #category : #arithmetic }
MOVector >> * aNumber [
	
	^aNumber productFromVector: self
]

{ #category : #arithmetic }
MOVector >> *= aNumber [
	
	^self
		with: (self coerce: aNumber)
		affect: [:a :b | a * b]
]

{ #category : #arithmetic }
MOVector >> + aNumber [
	
	^aNumber sumFromVector: self
]

{ #category : #arithmetic }
MOVector >> += aNumber [
	
	^self
		with: (self coerce: aNumber)
		affect: [:a :b | a + b]
]

{ #category : #arithmetic }
MOVector >> - aNumber [
	
	^aNumber differenceFromVector: self
]

{ #category : #arithmetic }
MOVector >> -= aNumber [
	
	^self
		with: (self coerce: aNumber)
		affect: [:a :b | a - b]
]

{ #category : #arithmetic }
MOVector >> / aNumber [
	
	^aNumber quotientFromVector: self
]

{ #category : #arithmetic }
MOVector >> /= aNumber [
	
	^self
		with: (self coerce: aNumber)
		affect: [:a :b | a / b]
]

{ #category : #comparing }
MOVector >> < aMagnitude [
	
	self error: 'Vectors are not ordered'
]

{ #category : #comparing }
MOVector >> = vector [
	
	^self == vector
		or:
			[(vector isKindOf: MOVector)
				and:
					[(vector hasSize: self size)
						and:
							[self
								with: vector
								do: [:a :b | a = b ifFalse: [^false]].
							true]]]
]

{ #category : #converting }
MOVector >> asVector [
	
	^self
]

{ #category : #accessing }
MOVector >> at: index [
	
	^self subclassResponsibility
]

{ #category : #arithmetic }
MOVector >> at: index add: aNumber [
	
	^self
		at: index
		put: (self at: index) + aNumber
]

{ #category : #accessing }
MOVector >> at: index ifNilPut: aBlock [
	"Answer the value at anIndex.  If the value is nil, set it to be
	the result of evaluating valueBlock, and answer that value."
	
	^(self at: index)
		ifNil:
			[self
				at: index
				put: aBlock value]
]

{ #category : #accessing }
MOVector >> at: index put: aNumber [
	
	^self subclassResponsibility
]

{ #category : #accessing }
MOVector >> atAllPut: collection [
	
	(collection isKindOf: Collection)
		ifTrue:
			[self
				with: collection
				affect: [:a :b | b]]
		ifFalse: [super atAllPut: collection]
]

{ #category : #coercing }
MOVector >> coerce: aNumber [
	
	^MOVectorCoercion with: aNumber
]

{ #category : #copying }
MOVector >> copyEmpty [
	
	^self copyEmpty: self size
]

{ #category : #copying }
MOVector >> copyEmpty: size [
	
	^self species new: size
]

{ #category : #'vector functions' }
MOVector >> cosine: aVector [
	
	^self unitVector dotProduct: aVector unitVector
]

{ #category : #copying }
MOVector >> deepCopy [
	
	^self species withAll: self
]

{ #category : #private }
MOVector >> defaultElement [
	
	^Float zero
]

{ #category : #'double dispatching' }
MOVector >> differenceFromDouble: aNumber [
	
	^self differenceFromNumber: aNumber
]

{ #category : #'double dispatching' }
MOVector >> differenceFromFixedPoint: aNumber [
	
	^self differenceFromNumber: aNumber
]

{ #category : #'double dispatching' }
MOVector >> differenceFromFloat: aNumber [
	
	^self differenceFromNumber: aNumber
]

{ #category : #'double dispatching' }
MOVector >> differenceFromFraction: aNumber [
	
	^self differenceFromNumber: aNumber
]

{ #category : #'double dispatching' }
MOVector >> differenceFromInteger: aNumber [
	
	^self differenceFromNumber: aNumber
]

{ #category : #'double dispatching' }
MOVector >> differenceFromNumber: aNumber [
	
	^self collect: [:b | aNumber - b]
]

{ #category : #'double dispatching' }
MOVector >> differenceFromPoint: aNumber [
	
	^self differenceFromNumber: aNumber
]

{ #category : #'double dispatching' }
MOVector >> differenceFromSmallDouble: aNumber [
	
	^self differenceFromNumber: aNumber
]

{ #category : #'double dispatching' }
MOVector >> differenceFromVector: aVector [
	
	^aVector
		with: self
		collect: [:a :b | a - b]
]

{ #category : #'vector functions' }
MOVector >> dist: aVector [
	
	| sum |
	sum := 0.
	self
		with: aVector
		do: [:a :b | sum := sum + ((a - b) ** 2)].
	^sum
]

{ #category : #enumerating }
MOVector >> do: aBlock [
	"Evaluate aBlock with each of the receiver's elements as the argument."
	
	1
		to: self size
		do: [:index | aBlock value: (self at: index)]
]

{ #category : #enumerating }
MOVector >> doSparseWithIndex: aBlock [
	
	self
		doWithIndex:
			[:each :index | each isZero ifFalse: [aBlock value: each value: index]].
	^self
]

{ #category : #'double dispatching' }
MOVector >> doesNotUnderstand: aMessage [
	
	^super doesNotUnderstand: aMessage
]

{ #category : #'vector functions' }
MOVector >> dotProduct: aVector [
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
MOVector >> generality [
	
	^210
]

{ #category : #testing }
MOVector >> hasSize: size [
	
	^self size = size
]

{ #category : #comparing }
MOVector >> hash [
	
	^(self size hash bitXor: (self at: 1) hash)
		bitXor: (self at: self size) hash
]

{ #category : #'initialize-release' }
MOVector >> initializeSize: aSize [
	
	^self subclassResponsibility
]

{ #category : #testing }
MOVector >> isZero [
	"comment stating purpose of message"
	
	^self allSatisfy: #isZero
]

{ #category : #testing }
MOVector >> isZeroAt: index [
	
	^(self at: index) isZero
]

{ #category : #'vector functions' }
MOVector >> length [
	"comment stating purpose of message"
	
	^(self dotProduct: self) sqrt
]

{ #category : #arithmetic }
MOVector >> negated [
	"comment stating purpose of message"
	
	^self collect: #negated
]

{ #category : #private }
MOVector >> noModificationError [
	
	Error raise
]

{ #category : #'vector functions' }
MOVector >> normalize [
	"comment stating purpose of message"
	
	| len |
	len := self length.
	len isZero
		ifTrue: [self atAllPut: len]
		ifFalse: [self /= self length].
	^self
]

{ #category : #'double dispatching' }
MOVector >> productFromDouble: aVector [
	
	^self productFromNumber: aVector
]

{ #category : #'double dispatching' }
MOVector >> productFromFixedPoint: aVector [
	
	^self productFromNumber: aVector
]

{ #category : #'double dispatching' }
MOVector >> productFromFloat: aVector [
	
	^self productFromNumber: aVector
]

{ #category : #'double dispatching' }
MOVector >> productFromFraction: aVector [
	
	^self productFromNumber: aVector
]

{ #category : #'double dispatching' }
MOVector >> productFromInteger: aVector [
	
	^self productFromNumber: aVector
]

{ #category : #'double dispatching' }
MOVector >> productFromNumber: aNumber [
	
	^self collect: [:b | aNumber * b]
]

{ #category : #'double dispatching' }
MOVector >> productFromPoint: aVector [
	
	^self productFromNumber: aVector
]

{ #category : #'double dispatching' }
MOVector >> productFromSmallDouble: aVector [
	
	^self productFromNumber: aVector
]

{ #category : #'double dispatching' }
MOVector >> productFromVector: aVector [
	
	^aVector
		with: self
		collect: [:a :b | a * b]
]

{ #category : #enumerating }
MOVector >> putWithIndex: aBlock [
	
	1
		to: self size
		do:
			[:index | 
			self
				at: index
				put: (aBlock value: index)]
]

{ #category : #'double dispatching' }
MOVector >> quotientFromDouble: aNumber [
	
	^self quotientFromNumber: aNumber
]

{ #category : #'double dispatching' }
MOVector >> quotientFromFixedPoint: aNumber [
	
	^self quotientFromNumber: aNumber
]

{ #category : #'double dispatching' }
MOVector >> quotientFromFloat: aNumber [
	
	^self quotientFromNumber: aNumber
]

{ #category : #'double dispatching' }
MOVector >> quotientFromFraction: aNumber [
	
	^self quotientFromNumber: aNumber
]

{ #category : #'double dispatching' }
MOVector >> quotientFromInteger: aNumber [
	
	^self quotientFromNumber: aNumber
]

{ #category : #'double dispatching' }
MOVector >> quotientFromNumber: aNumber [
	
	^self collect: [:b | aNumber / b]
]

{ #category : #'double dispatching' }
MOVector >> quotientFromPoint: aNumber [
	
	^self quotientFromNumber: aNumber
]

{ #category : #'double dispatching' }
MOVector >> quotientFromSmallDouble: aNumber [
	
	^self quotientFromNumber: aNumber
]

{ #category : #'double dispatching' }
MOVector >> quotientFromVector: aVector [
	
	^aVector
		with: self
		collect: [:a :b | a / b]
]

{ #category : #arithmetic }
MOVector >> reciprocal [
	"comment stating purpose of message"
	
	^self collect: #reciprocal
]

{ #category : #testing }
MOVector >> respondsToArithmetic [
	"We are arithmetic, yes."
	
	^true
]

{ #category : #accessing }
MOVector >> size [
	
	^self subclassResponsibility
]

{ #category : #accessing }
MOVector >> sparseSize [
	
	| tally |
	tally := 0.
	self doSparseWithIndex: [:each :index | tally := tally + 1].
	^tally
]

{ #category : #'mathematical functions' }
MOVector >> sqrt [
	
	^self collect: #sqrt
]

{ #category : #printing }
MOVector >> storeDenseTextOn: aStream [
	
	aStream
		print: self size;
		cr.
	self
		do: [:each | aStream print: each]
		separatedBy: [aStream space].
	aStream cr
]

{ #category : #'mathematical functions' }
MOVector >> sum [
	
	^self
		inject: 0
		into: [:sum :each | sum + each]
]

{ #category : #'double dispatching' }
MOVector >> sumFromDouble: aNumber [
	
	^self sumFromNumber: aNumber
]

{ #category : #'double dispatching' }
MOVector >> sumFromFixedPoint: aNumber [
	
	^self sumFromNumber: aNumber
]

{ #category : #'double dispatching' }
MOVector >> sumFromFloat: aNumber [
	
	^self sumFromNumber: aNumber
]

{ #category : #'double dispatching' }
MOVector >> sumFromFraction: aNumber [
	
	^self sumFromNumber: aNumber
]

{ #category : #'double dispatching' }
MOVector >> sumFromInteger: aNumber [
	
	^self sumFromNumber: aNumber
]

{ #category : #'double dispatching' }
MOVector >> sumFromNumber: aNumber [
	
	^self collect: [:b | aNumber + b]
]

{ #category : #'double dispatching' }
MOVector >> sumFromPoint: aNumber [
	
	^self collect: [:b | aNumber + b]
]

{ #category : #'double dispatching' }
MOVector >> sumFromSmallDouble: aNumber [
	
	^self sumFromNumber: aNumber
]

{ #category : #'double dispatching' }
MOVector >> sumFromVector: aVector [
	
	^aVector
		with: self
		collect: [:a :b | a + b]
]

{ #category : #'vector functions' }
MOVector >> unitVector [
	"comment stating purpose of message"
	
	self isZero ifTrue: [^self].
	^self / self length
]

{ #category : #enumerating }
MOVector >> with: vector affect: aBlock [
	
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
MOVector >> with: vector collect: aBlock [
	
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
MOVector >> with: vector do: aBlock [
	
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
