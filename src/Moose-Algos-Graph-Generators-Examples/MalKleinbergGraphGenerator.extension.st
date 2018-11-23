Extension { #name : #MalKleinbergGraphGenerator }

{ #category : #'*Moose-Algos-Graph-Generators-Examples' }
MalKleinbergGraphGenerator class >> example1 [

	| v g nodes edges  nbNodes |
	v := RTView new.
	g := self  new.
	nbNodes:= 10.
	g
	nodes: (1 to: nbNodes*nbNodes);
		n: nbNodes;
		p: 1;
		q: 1;
		r: 3.0.
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
MalKleinbergGraphGenerator class >> example2 [

	| v g nodes edges |
	v := RTView new.
	g := self  new.
	g
	nodes: (1 to: 9);
		n: 3;
		p: 1;
		q: 2;
		r: 2.0.
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
	RTGridLayout new
		lineItemsCount: 3;
		on: v elements.
	v canvas addMenu: '+' callback: [ RTZoomInMove on: v ].
	v canvas addMenu: '-' callback: [ RTZoomOutMove on: v ].
	v canvas camera scale: 2.
	v @ RTDraggableView @ RTZoomableView.
	v open
]

{ #category : #'*Moose-Algos-Graph-Generators-Examples' }
MalKleinbergGraphGenerator class >> example3 [

	| v g nodes edges  nbNodes |
	v := RTView new.
	g := self  new.
	nbNodes:= 10.
	g
	nodes: (1 to: nbNodes*nbNodes);
		n: nbNodes;
		p: 1;
		q: 4;
		r: 3.0.
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
	RTGridLayout new
		lineItemsCount: nbNodes;
		on: v elements.
	v canvas addMenu: '+' callback: [ RTZoomInMove on: v ].
	v canvas addMenu: '-' callback: [ RTZoomOutMove on: v ].
	v canvas camera scale: 2.
	v @ RTDraggableView @ RTZoomableView.
	v open
]
