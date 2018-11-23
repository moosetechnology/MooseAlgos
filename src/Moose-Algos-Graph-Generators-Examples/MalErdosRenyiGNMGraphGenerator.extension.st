Extension { #name : #MalErdosRenyiGNMGraphGenerator }

{ #category : #'*Moose-Algos-Graph-Generators-Examples' }
MalErdosRenyiGNMGraphGenerator class >> example1 [
	| v g nodes edges |
	v := RTView new.
	g := self new.
	g
		nodes: (1 to: 1000);
		edgesNumber: 700.
	g run.
	nodes := (RTEllipse new
		color: (Color purple alpha: 0.3);
		size: 10) elementsOn: g nodes.
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
