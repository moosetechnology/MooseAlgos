Extension { #name : #MalGrid2DGenerator }

{ #category : #'*Moose-Algos-Graph-Generators-Examples' }
MalGrid2DGenerator class >> example1 [

	| g |
	g := self new
		     width: 10;
		     height: 10;
		     neighborhood: #moore.
	g run.
	
	MalGraphGeneratorExampleHelper new
		nodes: g nodes edges: g edges;
		animatedLayout;
		run
]

{ #category : #'*Moose-Algos-Graph-Generators-Examples' }
MalGrid2DGenerator class >> example2 [

	| g |
	g := self new
		     width: 10;
		     height: 10;
		     neighborhood: #vonNeumann.
	g run.

	MalGraphGeneratorExampleHelper new
		nodes: g nodes edges: g edges;
		animatedLayout;
		run
]
