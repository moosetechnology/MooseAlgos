"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MOAccumulator,
	#superclass : #Object,
	#instVars : [
		'accumulateBlock',
		'size',
		'value',
		'index'
	],
	#category : #'MooseAlgos-LinearAlgebra'
}

{ #category : #'instance creation' }
MOAccumulator class >> extreme [
	
	^self
		value: 0
		using:
			[:extreme :each | 
			extreme abs > each abs
				ifTrue: [extreme]
				ifFalse: [each]]
]

{ #category : #'instance creation' }
MOAccumulator class >> maximum [
	
	^self
		value: Unlimited negative
		using: [:max :each | max max: each]
]

{ #category : #'instance creation' }
MOAccumulator class >> minimum [
	
	^self
		value: Unlimited positive
		using: [:min :each | min min: each]
]

{ #category : #'instance creation' }
MOAccumulator class >> new [
	
	self shouldNotImplement
]

{ #category : #'instance creation' }
MOAccumulator class >> squaredSum [
	
	^self
		value: 0
		using: [:sum :each | sum + each squared]
]

{ #category : #'instance creation' }
MOAccumulator class >> sum [
	
	^self
		value: 0
		using: [:sum :each | sum + each]
]

{ #category : #'instance creation' }
MOAccumulator class >> using: anAccumulationBlock [
	
	^self
		value: Number zero
		using: anAccumulationBlock
]

{ #category : #'instance creation' }
MOAccumulator class >> value: initialValue using: anAccumulationBlock [
	
	^(self basicNew)
		setAccumulateBlock: anAccumulationBlock;
		resetValue: initialValue;
		yourself
]

{ #category : #accumulate }
MOAccumulator >> accumulate: aValue [
	
	size := size + 1.
	^value := accumulateBlock value: value value: aValue
]

{ #category : #accumulate }
MOAccumulator >> accumulate: aValue withIndex: anIndex [
	
	size := size + 1.
	^(value = (value := accumulateBlock value: value value: aValue))
		ifFalse: [index := anIndex]
]

{ #category : #accumulate }
MOAccumulator >> add: aValue [
	
	^self accumulate: aValue
]

{ #category : #accessing }
MOAccumulator >> average [
	
	^value / size
]

{ #category : #accumulate }
MOAccumulator >> enumerate: aCollection [
	
	aCollection do: [:each | self accumulate: each].
	^value
]

{ #category : #accumulate }
MOAccumulator >> enumerate: aCollection atAll: indices [
	
	indices do: [:key | self accumulate: (aCollection at: key)].
	^value
]

{ #category : #accumulate }
MOAccumulator >> enumerate: aMatrix atAll: rowIndices andAll: columnIndices [
	
	rowIndices
		do:
			[:row | 
			columnIndices
				do: [:column | self accumulate: (aMatrix at: row and: column)]].
	^value
]

{ #category : #accumulate }
MOAccumulator >> enumerateWithIndex: aSequencableCollection [
	
	aSequencableCollection
		doWithIndex: [:each :index0 | self accumulate: each withIndex: index0].
	^value
]

{ #category : #accumulate }
MOAccumulator >> from: start to: end do: aBlock [
	
	start
		to: end
		do: [:each | self accumulate: (aBlock value: each)].
	^value
]

{ #category : #accessing }
MOAccumulator >> index [
	
	^index
]

{ #category : #'initialize-release' }
MOAccumulator >> merge: anAccumulator [
	
	size := size + anAccumulator size.
	^self
		accumulate: anAccumulator value
		withIndex: anAccumulator index
]

{ #category : #printing }
MOAccumulator >> printOn: stream [
	
	| method |
	method := accumulateBlock method outerMethod.
	stream
		nextPutAll:
				(method mclass == MOAccumulator class
						ifTrue: [method selector]
						ifFalse: ['custom']);
		space;
		nextPut: $=;
		space;
		print: value
]

{ #category : #'initialize-release' }
MOAccumulator >> resetValue: aValue [
	
	size := 0.
	index := nil.
	value := aValue
]

{ #category : #'initialize-release' }
MOAccumulator >> setAccumulateBlock: aBlock [
	
	accumulateBlock := aBlock
]

{ #category : #'initialize-release' }
MOAccumulator >> setValue: aValue [
	
	size := 0.
	^value := value
]

{ #category : #accessing }
MOAccumulator >> size [
	
	^size
]

{ #category : #accumulate }
MOAccumulator >> upTo: end do: aBlock [
	
	^self from: 1 to: end do: aBlock
]

{ #category : #accessing }
MOAccumulator >> value [
	
	^value
]
