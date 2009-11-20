Class {
	#name : #MOCycleTableTest,
	#superclass : #TestCase,
	#instVars : [
		'cycle1',
		'cycle2',
		'cycle3'
	],
	#category : #'MooseAlgos-DependencyTable'
}

{ #category : #history }
MOCycleTableTest class >> lastStoredRun [
	^ ((Dictionary new) add: (#passed->((Set new) add: #testBasics; add: #testEdgeTraversal; add: #testNodeSequence; add: #testCommonEdges; add: #testRowsAndColumns; add: #testFirstNode; add: #testBasicSimilarity; add: #testSimilarity; add: #testQueuePulling; yourself)); add: (#timeStamp->'6 July 2009 4:38:46 pm' asTimeStamp); add: (#failures->((Set new))); add: (#errors->((Set new))); yourself)
]

{ #category : #running }
MOCycleTableTest >> setUp [

	| builder nodes cycles edges cycle4 |
	builder := MOGraphStructure new nodeClass: MOGraphNode; edgeClass: MOCycleEdge.
	builder nodes: #(A B C D E F).
	builder 	edges: #((A B 10) (B E 9) (B C 4) (C A 3) (C D 1) (D C 1) (E A 11) (C F 1) (F B 1))
				from: #first
				to: #second
				weight: #third.
	
	nodes := #(A B C) collect: [:m| builder findNode: m].
	edges := #(1 3 4) collect: [:i| builder edges at: i]. 
	cycle1 := MOCycle withNodes: nodes withEdges: edges.
	
	nodes := #(A B E) collect: [:m| builder findNode: m].
	edges := #(1 2 7) collect: [:i| builder edges at: i]. 
	cycle2 := MOCycle withNodes: nodes withEdges: edges.

	nodes := #(C D) collect: [:m| builder findNode: m].
	edges := #(5 6) collect: [:i| builder edges at: i]. 
	cycle3 := MOCycle withNodes: nodes withEdges: edges.

	nodes := #(B C F) collect: [:m| builder findNode: m].
	edges := #(3 8 9) collect: [:i| builder edges at: i]. 
	cycle4 := MOCycle withNodes: nodes withEdges: edges.

	cycles := {cycle1. cycle2. cycle3}.
	cycles do: [:c1 |
		cycles do: [:c2 | c1 ~~ c2 ifTrue: [c1 addIfSimilar: c2 ]]].
	^ cycles
]

{ #category : #'tests-mocycle' }
MOCycleTableTest >> testBasicSimilarity [
	self assert: (cycle1 similarity: cycle2) = 2.
	self assert: (cycle2 similarity: cycle1) = 2.
	self assert: (cycle1 similarity: cycle3) = 1.
	self assert: (cycle2 similarity: cycle3) = 0.
	self assert: (((cycle1 commonNodes: cycle2) collect: [ :i | i model ]) includesAll: #(#A #B )).
	self assert: (((cycle3 commonNodes: cycle1) collect: [ :i | i model ]) includesAll: #(#C ))
]

{ #category : #'tests-mocycle' }
MOCycleTableTest >> testBasics [

	self assert: cycle1 length = 3.
	self assert: ((cycle1 nodes collect: [:n| n model]) includesAll: #(A B C)).
	
	self assert: cycle2 length = 3.
	self assert: ((cycle2 nodes collect: [:n| n model]) includesAll: #(A B E)).

	self assert: cycle3 length = 2.
	self assert: ((cycle3 nodes collect: [:n| n model]) includesAll: #(C D)).

]

{ #category : #'tests-mocycle' }
MOCycleTableTest >> testCommonEdges [
	| e1 e2 e3 |
	cycle1 detectCommonEdges: MOCircularColors new.
	e1 := cycle1 edgeFrom: cycle1 firstNode.
	self assert: e1 color notNil.
	e2 := cycle1 edgeFrom: e1 to.
	self assert: e2 color isNil.
	e3 := cycle1 edgeFrom: e2 to.
	self assert: e3 color isNil.
	e1 := cycle2 edgeFrom: cycle2 firstNode.
	self assert: e1 color isNil.
	e2 := cycle2 edgeFrom: e1 to.
	self assert: e2 color notNil
]

{ #category : #'tests-mocycle' }
MOCycleTableTest >> testEdgeTraversal [

	| e1 e2 e3 |
	e1 := cycle1 edgeFrom: cycle1 firstNode.
	self assert: e1 from model = #A.
	self assert: e1 to model = #B.
	self assert: e1 weight = 10.
	e2 := cycle1 edgeFrom: e1 to.
	self assert: e2 from model = #B.
	self assert: e2 to model = #C.
	self assert: e2 weight = 4.
	e3 := cycle1 edgeFrom: e2 to.
	self assert: e3 from model = #C.
	self assert: e3 to model = #A.
	self assert: e3 weight = 3.

	self assert: (cycle1 edgeFrom: #E) isNil
]

{ #category : #'tests-mocycle' }
MOCycleTableTest >> testFirstNode [

	self assert: cycle1 firstNode model = #A. 
	self assert: cycle2 firstNode model = #E.
	self assert: (cycle3 firstNode model = #C or: [cycle3 firstNode model = #D]). 
]

{ #category : #'tests-mocycle' }
MOCycleTableTest >> testNodeSequence [

	self assert: ((cycle1 firstNodeSequence collect: [:n| n model]) includesAll: #(A B C)).
	self assert: ((cycle2 firstNodeSequence collect: [:n| n model]) includesAll: #(E B A)).
	self assert: ((cycle3 firstNodeSequence collect: [:n| n model]) includesAll: #(D C)).
]

{ #category : #'tests-cycletable' }
MOCycleTableTest >> testQueuePulling [
	| col org |
	col := OrderedCollection 
		with: cycle2
		with: cycle3
		with: cycle1.
	org := MOCycleTableOrganizer new.
	org initializePriorityQueuesWith: col. 
	org pullSimilarCyclesOf: cycle2.
	self assert: org popCycle = cycle1.
	self assert: org popCycle = cycle2.
	self assert: org popCycle = cycle3.

	col := OrderedCollection 
		with: cycle1
		with: cycle3
		with: cycle2.
	org := MOCycleTableOrganizer new.
	org initializePriorityQueuesWith: col. 
	org pullSimilarCyclesOf: cycle1.
	self assert: org popCycle = cycle2.
	self assert: org popCycle = cycle3.
	self assert: org popCycle = cycle1
]

{ #category : #'tests-cycletable' }
MOCycleTableTest >> testRowsAndColumns [

	| table nodes |
	table := MOCycleTable new.
	table cycles: (OrderedCollection with: cycle3 with: cycle2 with: cycle1).
	table initializeRowsAndColumns.
	
	nodes := table nodeRows collect: [:n| n model].
	self assert: nodes size = 5.
	self assert: nodes asArray = #(E A B C D).
	self assert: table cycleColumns size = 3.
	self assert: table cycleColumns asArray = {cycle2. cycle1. cycle3}.
]

{ #category : #'tests-mocycle' }
MOCycleTableTest >> testSimilarity [
	
	self assert: (cycle1 maxSimilarity) = 2.
	self assert: (cycle2 maxSimilarity) = 2.
	self assert: (cycle3 maxSimilarity) = 1.

	self assert: (cycle1 similarCycles includesAll: {cycle2. cycle3}).
	self assert: (cycle2 similarCycles includesAll: {cycle1}).
	self deny: (cycle2 similarCycles includesAll: {cycle3}).
	self assert: (cycle3 similarCycles includesAll: {cycle1}).
	self deny: (cycle3 similarCycles includesAll: {cycle2}).


]
