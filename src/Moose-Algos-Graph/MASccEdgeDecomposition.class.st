Class {
	#name : #MASccEdgeDecomposition,
	#superclass : #MASccExtractor,
	#traits : 'MATNormalize',
	#classTraits : 'MATNormalize classTrait',
	#instVars : [
		'bfsp'
	],
	#category : #'Moose-Algos-Graph'
}

{ #category : #running }
MASccEdgeDecomposition >> bfsPathFrom: startNode to: endNode [

	^ bfsp start: startNode; end: endNode; run
]

{ #category : #accessing }
MASccEdgeDecomposition >> edgeClass [

	^ MAGraphEdge 
]

{ #category : #accessing }
MASccEdgeDecomposition >> initialize [ 

	super initialize.
	bfsp := MABreadthFirstSearchPath new.

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
