"
Baseline for the MooseAlgo project
"
Class {
	#name : #BaselineOfMooseAlgos,
	#superclass : #BaselineOf,
	#category : #BaselineOfMooseAlgos
}

{ #category : #baselines }
BaselineOfMooseAlgos >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ "Packages"
			spec
				package: 'CollectionExtensions';
				package: 'Moose-Algos-Clustering' with: [ spec requires: #('Moose-Algos-LinearAlgebra') ];
				package: 'Moose-Algos-FormalConceptAnalysis';
				package: 'Moose-Algos-Graph';
				package: 'Moose-Algos-HierarchicalGraph' with: [ spec requires: #('Moose-Algos-Graph') ];
				package: 'Moose-Algos-InformationRetrieval';
				package: 'Moose-Algos-Kontractor';
				package: 'Moose-Algos-Lattice' with: [ spec requires: #('Moose-Algos-Graph') ];
				package: 'Moose-Algos-LinearAlgebra';
				package: 'Moose-Tests-Algos-Clustering' with: [ spec requires: #('Moose-Algos-Clustering') ];
				package: 'Moose-Tests-Algos-FormalConceptAnalysis' with: [ spec requires: #('Moose-Algos-FormalConceptAnalysis' 'Moose-Algos-Lattice') ];
				package: 'Moose-Tests-Algos-Graph' with: [ spec requires: #('Moose-Algos-Graph') ];
				package: 'Moose-Tests-Algos-HierarchicalGraph' with: [ spec requires: #('Moose-Algos-HierarchicalGraph') ];
				package: 'Moose-Tests-Algos-InformationRetrieval' with: [ spec requires: #('Moose-Algos-InformationRetrieval') ];
				package: 'Moose-Tests-Algos-Kontractor' with: [ spec requires: #('Moose-Algos-Kontractor') ];
				package: 'Moose-Tests-Algos-Lattice' with: [ spec requires: #('Moose-Algos-FormalConceptAnalysis' 'Moose-Algos-Lattice') ];
				package: 'Moose-Tests-Algos-LinearAlgebra' with: [ spec requires: #('Moose-Algos-LinearAlgebra') ].

			"Groups"
			spec
				group: 'Core' with: #('CollectionExtensions' 'Moose-Algos-Clustering' 'Moose-Algos-FormalConceptAnalysis' 'Moose-Algos-Graph' 'Moose-Algos-HierarchicalGraph' 'Moose-Algos-InformationRetrieval' 'Moose-Algos-Kontractor' 'Moose-Algos-Lattice' 'Moose-Algos-LinearAlgebra');
				group: 'Tests' with: #('Moose-Tests-Algos-Graph' 'Moose-Tests-Algos-LinearAlgebra' 'Moose-Tests-Algos-Clustering' 'Moose-Tests-Algos-InformationRetrieval' 'Moose-Tests-Algos-FormalConceptAnalysis' 'Moose-Tests-Algos-Kontractor' 'Moose-Tests-Algos-Lattice' 'Moose-Tests-Algos-HierarchicalGraph') ]
]
