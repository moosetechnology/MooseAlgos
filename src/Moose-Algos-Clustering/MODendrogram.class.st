"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MODendrogram,
	#superclass : #Collection,
	#instVars : [
		'parent'
	],
	#category : #'Moose-Algos-Clustering'
}

{ #category : #'instance creation' }
MODendrogram class >> with: anElement [
	
	^MODendrogramLeaf with: anElement
]

{ #category : #adding }
MODendrogram >> add: newObject [
	
	self shouldNotImplement
]

{ #category : #'break into clusters' }
MODendrogram >> breakAtThreshold: aNumber [
	
	| candidates |
	candidates := (self nodes select: [:each | each threshold < aNumber])
		, self leaves.
	^candidates reject: [:each | candidates includes: each parent]
]

{ #category : #'break into clusters' }
MODendrogram >> breakInto: numberOfClusters [
	
	| all candidates |
	"all := self nodes reverseSort: #threshold."
	all := self nodes sort: [:a :b | b threshold <= a threshold].
	candidates := IdentitySet with: all first.
	all
		do:
			[:each | 
			candidates remove: each.
			candidates add: each left.
			candidates add: each right.
			candidates size >= numberOfClusters ifTrue: [^candidates asArray]]
]

{ #category : #seriation }
MODendrogram >> dist: dendrogram [
	
	| sum |
	sum := MalAccumulator sum.
	self elements
		cross: dendrogram elements
		do: [:a :b | sum add: (a dist: b)].
	^sum average
]

{ #category : #enumerating }
MODendrogram >> do: aBlock [
	
	self elementsDo: aBlock
]

{ #category : #accessing }
MODendrogram >> elements [
	
	| stream |
	stream := Array new writeStream.
	self elementsDo: [:each | stream nextPut: each].
	^stream contents
]

{ #category : #enumerating }
MODendrogram >> elementsDo: aBlock [
	
	^self subclassResponsibility
]

{ #category : #accessing }
MODendrogram >> index [
	
	^self isRoot
		ifTrue: [1]
		ifFalse:
			[self isLeft
				ifTrue: [self parent index]
				ifFalse: [self parent index + self parent left size]]
]

{ #category : #testing }
MODendrogram >> isLeft [
	
	^self parent left == self
]

{ #category : #testing }
MODendrogram >> isRight [
	
	^self parent right == self
]

{ #category : #testing }
MODendrogram >> isRoot [
	
	^parent == nil
]

{ #category : #accessing }
MODendrogram >> leaves [
	
	| stream |
	stream := Array new writeStream.
	self leavesDo: [:each | stream nextPut: each].
	^stream contents
]

{ #category : #enumerating }
MODendrogram >> leavesDo: aBlock [
	
	^self subclassResponsibility
]

{ #category : #accessing }
MODendrogram >> left [
	
	^self subclassResponsibility
]

{ #category : #'instance creation' }
MODendrogram >> merge: dendrogram at: threshold [
	
	^MODendrogramNode with: self with: dendrogram at: threshold
]

{ #category : #accessing }
MODendrogram >> nodes [
	
	| stream |
	stream := Array new writeStream.
	self nodesDo: [:each | stream nextPut: each].
	^stream contents
]

{ #category : #enumerating }
MODendrogram >> nodesDo: aBlock [
	
	^self subclassResponsibility
]

{ #category : #seriation }
MODendrogram >> orderLeafs [
	
	^self subclassResponsibility
]

{ #category : #accessing }
MODendrogram >> parent [
	
	^parent
]

{ #category : #removing }
MODendrogram >> remove: oldObject ifAbsent: anExceptionBlock [
	
	self shouldNotImplement
]

{ #category : #accessing }
MODendrogram >> right [
	
	^self subclassResponsibility
]

{ #category : #accessing }
MODendrogram >> size [
	
	^self subclassResponsibility
]

{ #category : #private }
MODendrogram >> species [
	
	^OrderedCollection
]

{ #category : #seriation }
MODendrogram >> swap [
	
	^self subclassResponsibility
]

{ #category : #accessing }
MODendrogram >> threshold [
	
	^self subclassResponsibility
]
