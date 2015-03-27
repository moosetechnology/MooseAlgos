Class {
	#name : #MalReducedGraphTest,
	#superclass : #TestCase,
	#instVars : [
		'graphReducer'
	],
	#category : #'Moose-Tests-Algos-Graph'
}

{ #category : #running }
MalReducedGraphTest >> setUp [
	graphReducer := MalGraphReducer new.
]

{ #category : #tests }
MalReducedGraphTest >> testComplexCycle2 [
	| initialNodes |
	MalGraphFixture complexCycleGraph2: graphReducer.
	initialNodes := graphReducer nodes copy.
	graphReducer run.
	self
		assert: graphReducer nodes size
		equals: 6.
	self
		assert: (graphReducer nodes at: 6) mergedNodes size
		equals: 4
]

{ #category : #tests }
MalReducedGraphTest >> testNextNodesFor [
	| nodes |
	MalGraphFixture complexCycleGraph2: graphReducer.
	nodes := { (graphReducer findNode: $f) . (graphReducer findNode: $g) }.
	self 
		assert: ((graphReducer nextNodesFor: nodes) 
						collect: #model as: SortedCollection) asArray
		equals: #($a $b $d $e $i)
]

{ #category : #tests }
MalReducedGraphTest >> testNoCycle [
	| initialGraph |
	MalGraphFixture simpleGraph: graphReducer.
	initialGraph := graphReducer graph copy.
	graphReducer run.
	self assert: initialGraph equals: graphReducer graph
]

{ #category : #tests }
MalReducedGraphTest >> testPreviousNodesFor [
	| nodes |
	MalGraphFixture complexCycleGraph2: graphReducer.
	nodes := { (graphReducer findNode: $f) . (graphReducer findNode: $g) }.
	self 
		assert: ((graphReducer previousNodesFor: nodes) 
						collect: #model as: SortedCollection) asArray
		equals: #($a $b $c)
]
