Class {
	#name : #MADijkstra,
	#superclass : #MAGraphAlgorithm,
	#instVars : [
		'start',
		'end'
	],
	#category : #'Moose-Algos-Graph'
}

{ #category : #backtracking }
MADijkstra >> backtrack [ 

	^ self backtrack: self end
]

{ #category : #backtracking }
MADijkstra >> backtrack: b [

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
MADijkstra >> backtrack: b edgeDo: aBlock [
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
MADijkstra >> edgeClass [

	^ MADijkstraEdge
]

{ #category : #private }
MADijkstra >> end [
	^ end
]

{ #category : #private }
MADijkstra >> end: aDijsktraNode [
	end := aDijsktraNode
]

{ #category : #accessing }
MADijkstra >> nodeClass [

	^ MADijkstraNode 
]

{ #category : #running }
MADijkstra >> pathWeight [
	^ self end pathWeight
]

{ #category : #running }
MADijkstra >> reset [

	self nodes do: [:n|
		n pathWeight: Float infinity ].
	self edges do: [:e |
		e visited: false ]
]

{ #category : #running }
MADijkstra >> run [
	
	self traverse: self start
]

{ #category : #running }
MADijkstra >> runFrom: start to: end [

	self start: (self findNode: start); end: (self findNode: end).
	self run.
	^ self pathWeight
]

{ #category : #private }
MADijkstra >> start [
	^ start
]

{ #category : #private }
MADijkstra >> start: aDijsktraNode [
	start := aDijsktraNode.
	aDijsktraNode pathWeight: 0
]

{ #category : #running }
MADijkstra >> traverse: node [

	self flag: #todo. "optimize traversal of nodes"
	node nextEdges do: [:edge |
		edge isVisited ifFalse: [
			edge to pathWeight: (edge to pathWeight min: (node pathWeight + edge weight)).
			edge visited: true.
			self traverse: edge to ]]

]
