Extension { #name : #MalHexagonalLatticeGenerator }

{ #category : #'*Moose-Algos-Graph-Generators-Examples' }
MalHexagonalLatticeGenerator class >> example1 [

	| g nbNodes |
	nbNodes := 20.
	g := self new
		     n: 20;
		     m: 20.
	g run.

	MalGraphGeneratorExampleHelper new
		nodes: g activeNodes edges: g edges;
		gridLayout: nbNodes;
		run
]

{ #category : #'*Moose-Algos-Graph-Generators-Examples' }
MalHexagonalLatticeGenerator class >> example2 [

	| g |
	g := self new
		     n: 6;
		     m: 6.
	g run.
	
	MalGraphGeneratorExampleHelper new
		nodes: g activeNodes edges: g edges;
		animatedLayout;
		run
]
