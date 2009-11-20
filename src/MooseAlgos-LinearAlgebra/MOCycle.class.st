Class {
	#name : #MOCycle,
	#superclass : #Object,
	#instVars : [
		'nodes',
		'edges',
		'similarCycles'
	],
	#category : #'MooseAlgos-DependencyTable'
}

{ #category : #'as yet unclassified' }
MOCycle class >> withNodes: aCollection withEdges: aCollection2 [

	^ self new nodes: aCollection; edges: aCollection2; yourself
]

{ #category : #similarity }
MOCycle >> addCycle: aCycle withSimilarity: sim [
	similarCycles add: {aCycle. sim}
]

{ #category : #similarity }
MOCycle >> addIfSimilar: aCycle [
	
	| sim |
	sim := self similarity: aCycle.
	sim > 0 ifTrue: [self addCycle: aCycle withSimilarity: sim ]
]

{ #category : #similarity }
MOCycle >> commonNodes: aCycle [ 
	^ self nodes intersection: aCycle nodes
]

{ #category : #similarity }
MOCycle >> detectCommonEdges: colorQueue [ 
	| e |
	self similarCycles do: 
		[ :c | 
		(self commonNodes: c) do: 
			[ :cl | 
			e := self edgeFrom: cl.
			(c edges includes: e) ifTrue: [ e color ifNil: [ e color: (colorQueue nextColor alpha: 0.5) ] ] ] ]
]

{ #category : #accessing }
MOCycle >> edgeFrom: aNode [

	^ self edges detect: [:e| e from = aNode] ifNone: [nil]
]

{ #category : #accessing }
MOCycle >> edges [
	^ edges
]

{ #category : #accessing }
MOCycle >> edges: anObject [
	edges := anObject
]

{ #category : #accessing }
MOCycle >> firstNode [
	^ (edges asSortedCollection: [ :e1 :e2 | e1 weight > e2 weight ]) first from
]

{ #category : #accessing }
MOCycle >> firstNodeSequence [

	^ self nodeSequenceStarting: self firstNode
]

{ #category : #'initialize-release' }
MOCycle >> initialize [
	similarCycles := OrderedCollection new.
]

{ #category : #accessing }
MOCycle >> length [

	^ nodes size
]

{ #category : #similarity }
MOCycle >> maxSimilarity [

	^ similarCycles inject: 0 into: [:m :t | m max: t second]
]

{ #category : #accessing }
MOCycle >> nodeSequenceStarting: aNode [ 
	| nodeSequence e next |
	nodeSequence := OrderedCollection new.
	next := aNode.
	
	[ nodeSequence addLast: next.
	e := self edgeFrom: next.
	next := e to ] doWhileFalse: [ next == aNode ].
	^ nodeSequence
]

{ #category : #accessing }
MOCycle >> nodes [
	^ nodes
]

{ #category : #accessing }
MOCycle >> nodes: anObject [
	nodes := anObject
]

{ #category : #similarity }
MOCycle >> similarCycles [

	^ self similarCyclesAsTuples collect: [:tuple | tuple first]
]

{ #category : #similarity }
MOCycle >> similarCyclesAsTuples [
	"not sure about the behavior of SortedCollection, but we might try"
	^ (similarCycles asSortedCollection: [ :tuple1 :tuple2 | tuple1 first length > tuple2 first length ]) asSortedCollection: 
		[ :tuple1 :tuple2 | 
		tuple1 second > tuple2 second
		"^ similarCycles asSortedCollection: [:tuple1 :tuple2 | tuple1 second > tuple2 second]" ]
]

{ #category : #similarity }
MOCycle >> similarity: aCycle [ 
	^ (self commonNodes: aCycle) size
]
