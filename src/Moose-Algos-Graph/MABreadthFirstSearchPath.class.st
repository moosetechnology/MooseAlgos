Class {
	#name : #MABreadthFirstSearchPath,
	#superclass : #MAGraphAlgorithm,
	#instVars : [
		'start',
		'end',
		'fifo'
	],
	#category : #'Moose-Algos-Graph'
}

{ #category : #accessing }
MABreadthFirstSearchPath >> edgeClass [

	^ MAGraphEdge 
]

{ #category : #private }
MABreadthFirstSearchPath >> end [
	^ end
]

{ #category : #private }
MABreadthFirstSearchPath >> end: aDijsktraNode [
	end := aDijsktraNode
]

{ #category : #accessing }
MABreadthFirstSearchPath >> nodeClass [

	^ MABfsNode 
]

{ #category : #running }
MABreadthFirstSearchPath >> run [
	
	| path |
	fifo := OrderedCollection withAll: start nextEdges.
	start firstDepth: 0.
	path := self run: 1.
	start notVisited .
	^ path
]

{ #category : #running }
MABreadthFirstSearchPath >> run: depth [
	| edge path next |
	edge := fifo removeFirst.
	next := edge to.
	^ next = end
		ifTrue: [ OrderedCollection with: edge from model with: end model ]
		ifFalse:
			[ next visited
				ifFalse:
					[ fifo addAll: next nextEdges.
					next firstDepth: depth ].	"only add edges if node not already visited (avoid cycles on the path)"
			path := self run: depth + 1.	"continue recursion"
			(depth = next firstDepth) "out of stack"
				ifTrue: [
					(path first = next model) "backtrack along the path"
						ifTrue: [ path addFirst: edge from model ].	
					"reset visited for next run"
					next notVisited ].
			path ]	"stop recursion, start backtrack"
]

{ #category : #running }
MABreadthFirstSearchPath >> runFrom: start to: end [

	self start: (self findNode: start); end: (self findNode: end).
	^ self run
]

{ #category : #private }
MABreadthFirstSearchPath >> start [
	^ start
]

{ #category : #private }
MABreadthFirstSearchPath >> start: aDijsktraNode [
	start := aDijsktraNode.

]
