Extension { #name : #MalTriangularLatticeGenerator }

{ #category : #'*Moose-Algos-Graph-Generators-Examples' }
MalTriangularLatticeGenerator class >> example1 [

	| g nbNodes |
	nbNodes := 10.
	g := self new
		     n: 10;
		     m: 10.
	g run.

	MalGraphGeneratorExampleHelper new
		nodes: g activeNodes edges: g edges;
		gridLayout: nbNodes;
		run
]

{ #category : #'*Moose-Algos-Graph-Generators-Examples' }
MalTriangularLatticeGenerator class >> example2 [

	| g |
	g := self new
		     n: 20;
		     m: 20.
	g run.
	
	MalGraphGeneratorExampleHelper new
		nodes: g activeNodes edges: g edges;
		animatedLayout;
		run
]
