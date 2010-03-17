Class {
	#name : #MASccEdgeDecomposition,
	#superclass : #MOGraphAlgorithm,
	#traits : 'MATNormalize',
	#classTraits : 'MATNormalize classTrait',
	#instVars : [
		'circuits',
		'dijkstra',
		'bfsp'
	],
	#category : #'Moose-Algos-Graph'
}

{ #category : #accessing }
MASccEdgeDecomposition >> addCircuit: aCollectionOfNodes [
	
	circuits add: aCollectionOfNodes
]

{ #category : #running }
MASccEdgeDecomposition >> bfsPathFrom: startNode to: endNode [

	^ bfsp start: startNode; end: endNode; run
]

{ #category : #accessing }
MASccEdgeDecomposition >> circuits [
	^ circuits
]

{ #category : #accessing }
MASccEdgeDecomposition >> circuits: anObject [
	circuits := anObject
]

{ #category : #accessing }
MASccEdgeDecomposition >> edgeClass [

	^ MOGraphEdge 
]

{ #category : #accessing }
MASccEdgeDecomposition >> initialize [ 

	super initialize.
	bfsp := MABreadthFirstSearchPath new.
	circuits := Set new.

]

{ #category : #accessing }
MASccEdgeDecomposition >> nodeClass [

	^ MABfsNode 
]

{ #category : #running }
MASccEdgeDecomposition >> run [

	bfsp privateNodes: self nodes; privateEdges: self edges.
	self edges do: [:e||c|
		c := self bfsPathFrom: e to to: e from.
		self addCircuit: (self normalize: c) ]
]
