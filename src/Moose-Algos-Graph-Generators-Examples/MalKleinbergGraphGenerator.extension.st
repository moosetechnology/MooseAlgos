Extension { #name : #MalKleinbergGraphGenerator }

{ #category : #'*Moose-Algos-Graph-Generators-Examples' }
MalKleinbergGraphGenerator class >> example1 [

	| g nbNodes |
	nbNodes := 10.
	g := self new
		     nodes: (1 to: nbNodes * nbNodes);
		     n: nbNodes;
		     p: 1;
		     q: 1;
		     r: 3.0.
	g run.

	MalGraphGeneratorExampleHelper new
		nodes: g nodes edges: g edges;
		gridLayout: nbNodes;
		run
]

{ #category : #'*Moose-Algos-Graph-Generators-Examples' }
MalKleinbergGraphGenerator class >> example2 [

	| g |
	g := self new
		     nodes: (1 to: 9);
		     n: 3;
		     p: 1;
		     q: 2;
		     r: 2.0.
	g run.

	MalGraphGeneratorExampleHelper new
		nodes: g nodes edges: g edges;
		gridLayout: 3;
		run
]

{ #category : #'*Moose-Algos-Graph-Generators-Examples' }
MalKleinbergGraphGenerator class >> example3 [

	| g nbNodes |
	nbNodes := 10.
	g := self new
		     nodes: (1 to: nbNodes * nbNodes);
		     n: nbNodes;
		     p: 1;
		     q: 4;
		     r: 3.0.
	g run.

	MalGraphGeneratorExampleHelper new
		nodes: g nodes edges: g edges;
		gridLayout: nbNodes;
		run
]
