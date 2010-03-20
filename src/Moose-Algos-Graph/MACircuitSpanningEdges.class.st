Class {
	#name : #MACircuitSpanningEdges,
	#superclass : #MASccExtractor,
	#instVars : [
		'dijkstra'
	],
	#category : #'Moose-Algos-Graph'
}

{ #category : #private }
MACircuitSpanningEdges >> doUnvisitedEdges: aBlock [

	self edges do: [:e|
		e cseVisited ifFalse: [
			aBlock value: e
		]
	]

]

{ #category : #accessing }
MACircuitSpanningEdges >> edgeClass [

	^ MACseEdge 
]

{ #category : #running }
MACircuitSpanningEdges >> findDirectCircuits [

	"detect direct circuits"
	| returnNode returnEdge |
	self doUnvisitedEdges: [:e|
		[returnNode := e to.
		 returnEdge := returnNode nextEdges
				detect: [:re| re to == e from].
		 "found a direct circuit"
		 e cseVisited: true.
		 returnEdge cseVisited: true.
		 self addCircuit: (OrderedCollection with: e from model with: e to model)
		] on: Error do: [ "did not find a return edge, so there is no direct circuit"]				
	]
]

{ #category : #running }
MACircuitSpanningEdges >> findIndirectCircuits [
	
	"for each unvisited edge, pop and detect circuit with Dijsktra, backtrack"
	dijkstra privateNodes: self nodes; privateEdges: self edges.
	self doUnvisitedEdges: [:e|
		dijkstra reset.
		dijkstra start: e to; end: e from; run. "find circuit leading back from e target to e source"
		(dijkstra pathWeight ~= Float infinity) ifTrue: [
			self addCircuit: (dijkstra backtrack: dijkstra end edgeDo: [:x| x cseVisited: true]).
			"we have the path from e target to e source, and all edges 
			 marked as visited between.
			 We have to mark the seeding edge"
			e cseVisited: true ]
		]
]

{ #category : #accessing }
MACircuitSpanningEdges >> initialize [ 

	super initialize.
	circuits := OrderedCollection new. "use that instead of Set"
	dijkstra := MADijkstra new.

]

{ #category : #accessing }
MACircuitSpanningEdges >> nodeClass [

	^ MADijkstraNode
]

{ #category : #running }
MACircuitSpanningEdges >> run [

	self flag: #todo.	"for stability, we should sort edges by their label"
	self findDirectCircuits.
	self findIndirectCircuits

]
