"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MAAccumulator,
	#superclass : #Object,
	#instVars : [
		'accumulateBlock',
		'size',
		'value',
		'index'
	],
	#category : #'Moose-Algos-LinearAlgebra'
}

{ #category : #'instance creation' }
MAAccumulator class >> extreme [
	
	^self
		value: 0
		using:
			[:extreme :each | 
			extreme abs > each abs
				ifTrue: [extreme]
				ifFalse: [each]]
]

{ #category : #'instance creation' }
MAAccumulator class >> maximum [
	
	^self
		value: Unlimited negative
		using: [:max :each | max max: each]
]

{ #category : #'instance creation' }
MAAccumulator class >> minimum [
	
	^self
		value: Unlimited positive
		using: [:min :each | min min: each]
]

{ #category : #'instance creation' }
MAAccumulator class >> new [
	
	self shouldNotImplement
]

{ #category : #'instance creation' }
MAAccumulator class >> squaredSum [
	
	^self
		value: 0
		using: [:sum :each | sum + each squared]
]

{ #category : #'instance creation' }
MAAccumulator class >> sum [
	
	^self
		value: 0
		using: [:sum :each | sum + each]
]

{ #category : #'instance creation' }
MAAccumulator class >> using: anAccumulationBlock [
	
	^self
		value: Number zero
		using: anAccumulationBlock
]

{ #category : #'instance creation' }
MAAccumulator class >> value: initialValue using: anAccumulationBlock [
	
	^(self basicNew)
		setAccumulateBlock: anAccumulationBlock;
		resetValue: initialValue;
		yourself
]

{ #category : #accumulate }
MAAccumulator >> accumulate: aValue [
	
	size := size + 1.
	^value := accumulateBlock value: value value: aValue
]

{ #category : #accumulate }
MAAccumulator >> accumulate: aValue withIndex: anIndex [
	
	size := size + 1.
	^(value = (value := accumulateBlock value: value value: aValue))
		ifFalse: [index := anIndex]
]

{ #category : #accumulate }
MAAccumulator >> add: aValue [
	
	^self accumulate: aValue
]

{ #category : #accessing }
MAAccumulator >> average [
	
	^value / size
]

{ #category : #accumulate }
MAAccumulator >> enumerate: aCollection [
	
	aCollection do: [:each | self accumulate: each].
	^value
]

{ #category : #accumulate }
MAAccumulator >> enumerate: aCollection atAll: indices [
	
	indices do: [:key | self accumulate: (aCollection at: key)].
	^value
]

{ #category : #accumulate }
MAAccumulator >> enumerate: aMatrix atAll: rowIndices andAll: columnIndices [
	
	rowIndices
		do:
			[:row | 
			columnIndices
				do: [:column | self accumulate: (aMatrix at: row and: column)]].
	^value
]

{ #category : #accumulate }
MAAccumulator >> enumerateWithIndex: aSequencableCollection [
	
	aSequencableCollection
		doWithIndex: [:each :index0 | self accumulate: each withIndex: index0].
	^value
]

{ #category : #accumulate }
MAAccumulator >> from: start to: end do: aBlock [
	
	start
		to: end
		do: [:each | self accumulate: (aBlock value: each)].
	^value
]

{ #category : #accessing }
MAAccumulator >> index [
	
	^index
]

{ #category : #'initialize-release' }
MAAccumulator >> merge: anAccumulator [
	
	size := size + anAccumulator size.
	^self
		accumulate: anAccumulator value
		withIndex: anAccumulator index
]

{ #category : #printing }
MAAccumulator >> printOn: stream [
	
	| method |
	method := accumulateBlock method outerMethod.
	stream
		nextPutAll:
				(method mclass == MAAccumulator class
						ifTrue: [method selector]
						ifFalse: ['custom']);
		space;
		nextPut: $=;
		space;
		print: value
]

{ #category : #'initialize-release' }
MAAccumulator >> resetValue: aValue [
	
	size := 0.
	index := nil.
	value := aValue
]

{ #category : #'initialize-release' }
MAAccumulator >> setAccumulateBlock: aBlock [
	
	accumulateBlock := aBlock
]

{ #category : #'initialize-release' }
MAAccumulator >> setValue: aValue [
	
	size := 0.
	^value := value
]

{ #category : #accessing }
MAAccumulator >> size [
	
	^size
]

{ #category : #accumulate }
MAAccumulator >> upTo: end do: aBlock [
	
	^self from: 1 to: end do: aBlock
]

{ #category : #accessing }
MAAccumulator >> value [
	
	^value
]
