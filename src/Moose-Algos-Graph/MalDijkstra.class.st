Class {
	#name : #MalDijkstra,
	#superclass : #MalGraphAlgorithm,
	#instVars : [
		'start',
		'end'
	],
	#category : #'Moose-Algos-Graph'
}

{ #category : #backtracking }
MalDijkstra >> backtrack [ 

	^ self backtrack: self end
]

{ #category : #backtracking }
MalDijkstra >> backtrack: b [

	| p |
	b pathWeight = Float infinity
		ifTrue: [ ^ #() ]. "no solution"
	^ b = self start
		ifTrue: [ OrderedCollection with: b model ]
		ifFalse: [
			p := b previousNodes detectMin: [:n | n pathWeight].
			(self backtrack: p) add: b model; yourself ].
]

{ #category : #backtracking }
MalDijkstra >> backtrack: b edgeDo: aBlock [
	"special purpose backtracking for CSE: backtrack through edge and do something on each edge 
	while traversing.
	 do not check if there is a solution (pathWeight ~= Float infinity)"

	| pe p |
	^ b = self start
		ifTrue: [ OrderedCollection with: b model ]
		ifFalse: [
			pe := b previousEdges detectMin: [:e | e from pathWeight].
			p := pe from.
			aBlock value: pe.
			(self backtrack: p edgeDo: aBlock) add: b model; yourself ].
]

{ #category : #accessing }
MalDijkstra >> edgeClass [

	^ MalDijkstraEdge
]

{ #category : #private }
MalDijkstra >> end [
	^ end
]

{ #category : #private }
MalDijkstra >> end: aDijsktraNode [
	end := aDijsktraNode
]

{ #category : #accessing }
MalDijkstra >> nodeClass [

	^ MalDijkstraNode 
]

{ #category : #running }
MalDijkstra >> pathWeight [
	^ self end pathWeight
]

{ #category : #running }
MalDijkstra >> reset [

	self nodes do: [:n|
		n pathWeight: Float infinity ].
	self edges do: [:e |
		e visited: false ]
]

{ #category : #running }
MalDijkstra >> run [
	
	self traverse: self start
]

{ #category : #running }
MalDijkstra >> runFrom: start to: end [

	self start: (self findNode: start); end: (self findNode: end).
	self run.
	^ self pathWeight
]

{ #category : #private }
MalDijkstra >> start [
	^ start
]

{ #category : #private }
MalDijkstra >> start: aDijsktraNode [
	start := aDijsktraNode.
	aDijsktraNode pathWeight: 0
]

{ #category : #running }
MalDijkstra >> traverse: node [

	self flag: #todo. "optimize traversal of nodes"
	node nextEdges do: [:edge |
		edge isVisited ifFalse: [
			edge to pathWeight: (edge to pathWeight min: (node pathWeight + edge weight)).
			edge visited: true.
			self traverse: edge to ]]

]
