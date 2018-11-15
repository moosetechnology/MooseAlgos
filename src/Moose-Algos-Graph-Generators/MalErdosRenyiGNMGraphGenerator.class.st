Class {
	#name : #MalErdosRenyiGNMGraphGenerator,
	#superclass : #MalGraphAlgorithm,
	#instVars : [
		'edgesNumber'
	],
	#category : #'Moose-Algos-Graph-Generators'
}

{ #category : #examples }
MalErdosRenyiGNMGraphGenerator class >> example1 [
	| v g nodes edges |
	v := RTView new.
	g := MalErdosRenyiGNMGraphGenerator new.
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

{ #category : #configuration }
MalErdosRenyiGNMGraphGenerator >> edgeClass [
	^ MalGraphEdge
]

{ #category : #accessing }
MalErdosRenyiGNMGraphGenerator >> edgesNumber: m [
	edgesNumber := m
]

{ #category : #running }
MalErdosRenyiGNMGraphGenerator >> run [
	"G(n,m) Erdos-Renyi random graph generator"
	"n: number of nodes >0"
	"m: number of edges >=0"
	"m <= n*(n-1/2"
	"https://en.wikipedia.org/wiki/Erd%C5%91s%E2%80%93R%C3%A9nyi_model"

	edgesNumber
		timesRepeat: [ 
			| source target |
			source := self nodes atRandom.
			target := ((self nodes copy)
				remove: source;
				yourself) atRandom.
			self
				addEdge:
					{source model.
					target model}
				from: #first
				to: #second]
]
