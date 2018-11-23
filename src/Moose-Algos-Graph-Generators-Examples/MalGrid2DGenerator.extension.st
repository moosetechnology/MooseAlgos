Extension { #name : #MalGrid2DGenerator }

{ #category : #'*Moose-Algos-Graph-Generators-Examples' }
MalGrid2DGenerator class >> example1 [
| v g nodes edges |
	v := RTView new.
	g := self new.
	g
		width: 10;
		height: 10;
		neighborhood:#moore.
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

{ #category : #'*Moose-Algos-Graph-Generators-Examples' }
MalGrid2DGenerator class >> example2 [
| v g nodes edges |
	v := RTView new.
	g := self new.
	g
		width: 10;
		height: 10;
		neighborhood:#vonNeumann.
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
