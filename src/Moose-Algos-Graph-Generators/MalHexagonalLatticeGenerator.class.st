Class {
	#name : #MalHexagonalLatticeGenerator,
	#superclass : #MalGraphAlgorithm,
	#instVars : [
		'n',
		'm',
		'activeNodes'
	],
	#category : #'Moose-Algos-Graph-Generators'
}

{ #category : #examples }
MalHexagonalLatticeGenerator class >> example1 [
	| v g nodes edges nbNodes |
	v := RTView new.
	nbNodes := 20.
	g := MalHexagonalLatticeGenerator new.
	g
		n: 20;
		m: 20.
	g run.
	nodes := (RTEllipse new
		color: (Color purple alpha: 0.3);
		size: 10) elementsOn: g activeNodes.
	nodes @ RTDraggable.
	v addAll: nodes.
	edges := RTEdgeBuilder new
		view: v;
		shape: (RTLine new color: (Color red alpha: 0.5));
		source: g edges connectFrom: #from to: #to.
	edges do: [ :e | e trachelShape pushBack ].
	RTGridLayout new
		lineItemsCount: nbNodes;
		on: v elements.
	v canvas addMenu: '+' callback: [ RTZoomInMove on: v ].
	v canvas addMenu: '-' callback: [ RTZoomOutMove on: v ].
	v canvas camera scale: 2.
	v @ RTDraggableView @ RTZoomableView.
	v inspect
]

{ #category : #examples }
MalHexagonalLatticeGenerator class >> example2 [
	| v g nodes edges |
	v := RTView new.
	g := MalHexagonalLatticeGenerator new.
	g
		n: 6;
		m: 6.
	g run.
	nodes := (RTEllipse new
		color: (Color purple alpha: 0.3);
		size: 10) elementsOn: g activeNodes.
	nodes @ RTDraggable.
	v addAll: nodes.
	edges := RTEdgeBuilder new
		view: v;
		shape: (RTLine new color: (Color red alpha: 0.5));
		source: g edges connectFrom: #from to: #to.
	edges do: [ :e | e trachelShape pushBack ].
	v addAnimation: (RTSpringLayoutStepping new view: v).
	v @ RTDraggableView.
	v inspect
]

{ #category : #accessing }
MalHexagonalLatticeGenerator >> activeNodes [
	^ activeNodes
]

{ #category : #accessing }
MalHexagonalLatticeGenerator >> activeNodes: anObject [
	activeNodes := anObject
]

{ #category : #'as yet unclassified' }
MalHexagonalLatticeGenerator >> buildLinks [
	"Connect each nodes to nodes that are in 2 steps "

	nodes
		do: [ :each | 
			| links |
			"Build the top of hexagon"
			(each y \\ 4 = 1 and: [ each x \\ 2 = 1 ])
				ifTrue: [ "and: [ each x \\ 2 = 1 ]"
					links := self nodesAtDistance: 2 toNode: each.
					links
						do: [ :node | 
							node y > each y
								ifTrue: [ self
										addEdge:
											{each model.
											node model}
										from: #first
										to: #second ] ] ].
			"Build the bottom of the hexagon"
			(each y \\ 4 = 3 and: [ each x \\ 2 = 0 ])
				ifTrue: [ "and: [ each x \\ 2 = 1 ]"
					links := self nodesAtDistance: 2 toNode: each.
					links
						do: [ :node | 
							node y > each y
								ifTrue: [ self
										addEdge:
											{each model.
											node model}
										from: #first
										to: #second ] ] ].
			"Build the fisrt sides of the hexagon"
			(each y \\ 4 = 2 and: [ each x \\ 2 = 0 ])
				ifTrue: [ "and: [ each x \\ 2 = 1 ]"
					links := self nodesOnColumnAtDistance: 1 toNode: each.
					links
						do: [ :node | 
							self
								addEdge:
									{each model.
									node model}
								from: #first
								to: #second ] ].
			"Build the other sides of the hexagon"
			(each y \\ 4 = 0 and: [ each x \\ 2 = 1 ])
				ifTrue: [ "and: [ each x \\ 2 = 1 ]"
					links := self nodesOnColumnAtDistance: 1 toNode: each.
					links
						do: [ :node | 
							self
								addEdge:
									{each model.
									node model}
								from: #first
								to: #second ] ] ]
]

{ #category : #configuration }
MalHexagonalLatticeGenerator >> edgeClass [
	^ MalGraphEdge
]

{ #category : #initialization }
MalHexagonalLatticeGenerator >> initializeNodesOnGrid [
	| nbNodes |
	nbNodes := 1.
	nodes
		do: [ :each | 
			each x: (nbNodes - 1) \\ n + 1.
			each y: (nbNodes - 1 quo: n) + 1.
			nbNodes := nbNodes + 1 ]
]

{ #category : #accessing }
MalHexagonalLatticeGenerator >> m [
^m
]

{ #category : #accessing }
MalHexagonalLatticeGenerator >> m: anInteger [
	m := anInteger
]

{ #category : #accessing }
MalHexagonalLatticeGenerator >> n [
	^n
]

{ #category : #accessing }
MalHexagonalLatticeGenerator >> n: anInteger [
	n := anInteger
]

{ #category : #configuration }
MalHexagonalLatticeGenerator >> nodeClass [
	^ Mal2DGridNode
]

{ #category : #'as yet unclassified' }
MalHexagonalLatticeGenerator >> nodesAtDistance: aDistance toNode: aNode [
	"Return nodes that are at the distance p to a node"

	| i j k l |
	i := aNode x.
	j := aNode y.
	^ nodes
		select: [ :each | 
			k := each x.
			l := each y.
			((k - i) raisedTo:2) + ((l - j) raisedTo:2) = aDistance ]
]

{ #category : #'as yet unclassified' }
MalHexagonalLatticeGenerator >> nodesOnColumnAtDistance: aDistance toNode: aNode [
	"Return nodes that are at the distance p to a node"

	| i j k l |
	i := aNode x.
	j := aNode y.
	^ nodes
		select: [ :each | 
			k := each x.
			l := each y.
			i = k and: [ l - j = aDistance ] ]
]

{ #category : #removing }
MalHexagonalLatticeGenerator >> removeUnnecessaryNodes [
	| listeActiveNodes |
	listeActiveNodes := OrderedCollection new.
	nodes
		do: [ :each | 
			(each y \\ 4 = 0 and: [ each x \\ 2 = 1 ])
			ifTrue: [ listeActiveNodes add: each ].
			(each y \\ 4 = 1 and: [ each x \\ 2 = 1 ])
				ifTrue: [ listeActiveNodes add: each ].
			(each y \\ 4 = 2 and: [ each x \\ 2 = 0 ])
				ifTrue: [ listeActiveNodes add: each ].
			(each y \\ 4 = 3 and: [ each x \\ 2 = 0 ])
				ifTrue: [ listeActiveNodes add: each ] ].
	self activeNodes: listeActiveNodes
]

{ #category : #running }
MalHexagonalLatticeGenerator >> run [
	self nodes: (1 to: n * m).
	self initializeNodesOnGrid.
	self buildLinks.
	 self removeUnnecessaryNodes
]
