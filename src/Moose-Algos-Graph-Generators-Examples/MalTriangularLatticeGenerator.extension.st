Extension { #name : #MalTriangularLatticeGenerator }

{ #category : #'*Moose-Algos-Graph-Generators-Examples' }
MalTriangularLatticeGenerator class >> example1 [
	| v g nodes edges nbNodes |
	v := RTView new.
	nbNodes := 10.
	g := self new.
	g
		n: 10;
		m: 10.
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
	v open
]

{ #category : #'*Moose-Algos-Graph-Generators-Examples' }
MalTriangularLatticeGenerator class >> example2 [
	| v g nodes edges |
	v := RTView new.
	g := self new.
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
	v addAnimation: (RTSpringLayoutStepping new view: v).
	v @ RTDraggableView.
	v open
]
