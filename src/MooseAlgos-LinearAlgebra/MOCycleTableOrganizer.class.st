Class {
	#name : #MOCycleTableOrganizer,
	#superclass : #Object,
	#instVars : [
		'nodeRows',
		'cycleColumns',
		'firstPriority',
		'secondPriority'
	],
	#category : #'MooseAlgos-DependencyTable'
}

{ #category : #accessing }
MOCycleTableOrganizer >> cycleColumns [
	^ cycleColumns
]

{ #category : #'running-private' }
MOCycleTableOrganizer >> initializePriorityQueuesWith: cycles [ 
	"sort cycles by highest similarity and by length"

	secondPriority := ((cycles asSortedCollection: [ :c1 :c2 | c1 length > c2 length ]) 
										asSortedCollection: [ :c1 :c2 | c1 maxSimilarity > c2 maxSimilarity ]) asOrderedCollection.
	firstPriority := OrderedCollection new

]

{ #category : #running }
MOCycleTableOrganizer >> initializeRowsAndColumnsWith: cycles [ 
	| cycle firstNode colorQueue |
	cycleColumns := OrderedCollection new.
	nodeRows := OrderedCollection new.
	colorQueue := MOCircularColors new.
	self initializePriorityQueuesWith: cycles.
	cycle := self popStarterCycle.
	cycleColumns add: cycle.
	"take node with highest weight to begin with"
	firstNode := cycle firstNode.
	"add all nodes of first cycle, in cycle sequence"
	nodeRows addAll: (cycle nodeSequenceStarting: firstNode).
	"reorder to put similar stuff in front"
	self pullSimilarCyclesOf: cycle.
	cycle detectCommonEdges: colorQueue.
	"end of bootstrap"

	"main loop while there is some cycles to place"
	[ self isEmpty ] whileFalse: 
		[ "first one is always good"
		cycle := self popCycle.
		cycleColumns add: cycle.
		"start node sequence with first node already in rows - can help to get a straight sequence"
		firstNode := (nodeRows intersection: cycle nodes) 
			ifNotEmpty: [ :inter | inter first ]
			ifEmpty: [ cycle firstNode ].
		"add node to rows only if not already in"
		(cycle nodeSequenceStarting: firstNode) do: [ :n | (nodeRows includes: n) ifFalse: [ nodeRows addLast: n ] ].
		"reorder to put similar stuff in front"
		self pullSimilarCyclesOf: cycle.
		cycle detectCommonEdges: colorQueue ]
]

{ #category : #'running-private' }
MOCycleTableOrganizer >> isEmpty [

	^ firstPriority isEmpty and: [secondPriority isEmpty]
]

{ #category : #accessing }
MOCycleTableOrganizer >> nodeRows [
	^ nodeRows
]

{ #category : #'running-private' }
MOCycleTableOrganizer >> popCycle [

	^ firstPriority isEmpty
		ifFalse: [firstPriority removeFirst]
		ifTrue: [secondPriority removeFirst]
]

{ #category : #'running-private' }
MOCycleTableOrganizer >> popStarterCycle [
	"first cycle is one with one single similar cycle and high similarity"
	| firstCycle |
	firstCycle := secondPriority 
		detect: [ :c | c similarCycles size = 1 ]
		ifNone: [ secondPriority first ].
	secondPriority remove: firstCycle.
	^ firstCycle
]

{ #category : #'running-private' }
MOCycleTableOrganizer >> pullSimilarCyclesOf: aCycle [
	"pull similar cycles of aCycle in first priority queue"
	
	aCycle similarCycles do: [ :c | 
		(secondPriority includes: c) ifTrue: [
			secondPriority remove: c.
			firstPriority addLast: c
		] "ifFalse: c already done or in first priority"
	]
]
