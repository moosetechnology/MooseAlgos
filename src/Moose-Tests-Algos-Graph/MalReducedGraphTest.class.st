Class {
	#name : #MalReducedGraphTest,
	#superclass : #TestCase,
	#instVars : [
		'graphReducer'
	],
	#category : #'Moose-Tests-Algos-Graph'
}

{ #category : #'private - utility' }
MalReducedGraphTest >> assertNodes: aNodeList doesNotInclude: anotherNodeList [
	aNodeList 
		collect: #model
		thenDo: 
			[ :model | 
			self 
				deny: ((anotherNodeList collect: #model) includes: model)
				description: model asString , ' should not be referenced!' ] 
]

{ #category : #'private - utility' }
MalReducedGraphTest >> mergedNodesIn: aNodeList [
	^ (aNodeList select: [ :node | node mergedNodes notNil ])
		flatCollect: #mergedNodes
]

{ #category : #running }
MalReducedGraphTest >> setUp [
	graphReducer := MalGraphReducer new.
]

{ #category : #tests }
MalReducedGraphTest >> testComplexCycle2 [
	MalGraphFixture complexCycleGraph2: graphReducer.
	graphReducer run.
	self
		assert: graphReducer nodes size
		equals: 6.
	self
		assert: (graphReducer nodes at: 6) mergedNodes size
		equals: 4
]

{ #category : #tests }
MalReducedGraphTest >> testGraphReducingWhenNoCycle [
	| initialGraph |
	MalGraphFixture simpleGraph: graphReducer.
	initialGraph := graphReducer graph copy.
	graphReducer run.
	self assert: initialGraph equals: graphReducer graph
]

{ #category : #tests }
MalReducedGraphTest >> testMergedNodesNotReferencedInNextNodes [
	MalGraphFixture complexCycleGraph2: graphReducer.
	graphReducer run.

	self 
		assertNodes: (graphReducer nodes flatCollect: #nextNodes) 
		doesNotInclude: (self mergedNodesIn: graphReducer nodes)
]

{ #category : #tests }
MalReducedGraphTest >> testMergedNodesNotReferencedInPreviousNodes [
	MalGraphFixture complexCycleGraph2: graphReducer.
	graphReducer run.

	self 
		assertNodes: (graphReducer nodes flatCollect: #previousNodes) 
		doesNotInclude: (self mergedNodesIn: graphReducer nodes)

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
	MalGraphFixture complexCycleGraph2: graphReducer.
	graphReducer run.
	graphReducer nodes do:
		[ :node | 
		self 
			deny: ((node nextNodes includes: node) or: [ node previousNodes includes: node ])
			description: node asString, ' node is in cycle!' ]
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
