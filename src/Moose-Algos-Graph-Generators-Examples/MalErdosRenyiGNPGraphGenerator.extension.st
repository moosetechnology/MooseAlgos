Extension { #name : #MalErdosRenyiGNPGraphGenerator }

{ #category : #'*Moose-Algos-Graph-Generators-Examples' }
MalErdosRenyiGNPGraphGenerator class >> example1 [

	| g |
	g := self new
		     nodes: (1 to: 30);
		     probability: 0.1.
	g run.
	
	MalGraphGeneratorExampleHelper new
		nodes: g nodes edges: g edges;
		animatedLayout;
		run
]
