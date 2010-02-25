"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MOCorrelationVector,
	#superclass : #MAVector,
	#type : #bytes,
	#category : #'Moose-Algos-Clustering'
}

{ #category : #'instance creation' }
MOCorrelationVector class >> new: size [
	
	^self basicNew: size << 1
]

{ #category : #accessing }
MOCorrelationVector >> at: anIndex [
	"Answer a number between 1.0 and -1.0 at the given index.
	The numbers are internally stored as 16-bit integer; and nil as zero."
	
	| short |
	short := self unsignedShortAt: (anIndex << 1) - 1.
	^0 == short
		ifTrue: [nil]
		ifFalse: [(short - 16r8000) asFloat / 16r7FFF]
]

{ #category : #accessing }
MOCorrelationVector >> at: anIndex put: aNumber [
	"Store a number between 1.0 and -1.0 at the given index.
	The number is stores as 16-bit integer; nil is stored as zero."
	
	self
		unsignedShortAt: (anIndex << 1) - 1
		put:
			(nil == aNumber
				ifTrue: [0]
				ifFalse: [(aNumber * 16r7FFF + 16r8000) truncated]).
	^aNumber
]

{ #category : #private }
MOCorrelationVector >> defaultElement [
	
	^nil
]

{ #category : #'As yet unclassified' }
MOCorrelationVector >> min [
	
	^(self reject: #isNil)
		inject: Unlimited positive
		into: [:each :min | min min: each]
]

{ #category : #accessing }
MOCorrelationVector >> size [
	
	^self basicSize >> 1
]

{ #category : #private }
MOCorrelationVector >> unsignedShortAt: byteIndex [
	
	<primitive: 540>
	^self primitiveFailed
]

{ #category : #private }
MOCorrelationVector >> unsignedShortAt: byteIndex put: anUnsignedShort [
	
	<primitive: 541>
	^self primitiveFailed
]
