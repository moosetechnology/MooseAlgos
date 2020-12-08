Extension { #name : #MalErdosRenyiGNMGraphGenerator }

{ #category : #'*Moose-Algos-Graph-Generators-Examples' }
MalErdosRenyiGNMGraphGenerator class >> example1 [

	| g |
	g := self new
		     nodes: (1 to: 1000);
		     edgesNumber: 700.
	g run.
	
	MalGraphGeneratorExampleHelper new
		nodes: g nodes edges: g edges;
		animatedLayout;
		run
]
