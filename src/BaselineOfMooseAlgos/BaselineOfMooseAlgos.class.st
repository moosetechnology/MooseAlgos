"
Baseline for the MooseAlgo project
"
Class {
	#name : #BaselineOfMooseAlgos,
	#superclass : #BaselineOf,
	#instVars : [
		'repository'
	],
	#category : #BaselineOfMooseAlgos
}

{ #category : #baselines }
BaselineOfMooseAlgos >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ 
			"Dependencies"
			self
				collectionExtensions: spec;
				roassal2: spec.

			"Packages"
			spec
				package: 'Moose-Algos-Clustering' with: [ spec requires: #('Moose-Algos-LinearAlgebra') ];
				package: 'Moose-Algos-Clustering-Deprecated' with: [ spec requires: #('Moose-Algos-Clustering') ];
				package: 'Moose-Algos-FormalConceptAnalysis';
				package: 'Moose-Algos-Graph';
				package: 'Moose-Algos-Graph-Generators';
				package: 'Moose-Algos-Graph-Generators-Examples' with: [ spec requires: #('Moose-Algos-Graph-Generators' 'Roassal2') ];
				package: 'Moose-Algos-HierarchicalGraph' with: [ spec requires: #('Moose-Algos-Graph') ];
				package: 'Moose-Algos-InformationRetrieval';
				package: 'Moose-Algos-Kontractor';
				package: 'Moose-Algos-Lattice' with: [ spec requires: #('Moose-Algos-Graph') ];
				package: 'Moose-Algos-LinearAlgebra';
				package: 'Moose-Algos-Clustering-Tests' with: [ spec requires: #('Moose-Algos-Clustering') ];
				package: 'Moose-Algos-FormalConceptAnalysis-Tests' with: [ spec requires: #('Moose-Algos-FormalConceptAnalysis' 'Moose-Algos-Lattice') ];
				package: 'Moose-Algos-Graph-Tests' with: [ spec requires: #('Moose-Algos-Graph') ];
				package: 'Moose-Algos-Graph-Generators-Tests' with: [ spec requires: #('Moose-Algos-Graph-Generators') ];
				package: 'Moose-Algos-HierarchicalGraph-Tests' with: [ spec requires: #('Moose-Algos-HierarchicalGraph') ];
				package: 'Moose-Algos-InformationRetrieval-Tests' with: [ spec requires: #('Moose-Algos-InformationRetrieval') ];
				package: 'Moose-Algos-Kontractor-Tests' with: [ spec requires: #('Moose-Algos-Kontractor') ];
				package: 'Moose-Algos-Lattice-Tests' with: [ spec requires: #('Moose-Algos-FormalConceptAnalysis' 'Moose-Algos-Lattice') ];
				package: 'Moose-Algos-LinearAlgebra-Tests' with: [ spec requires: #('Moose-Algos-LinearAlgebra') ].

			"Groups"
			spec
				group: 'default' with: #('Core' 'Tests');
				group: 'Core' with: #('CollectionExtensions' 'Moose-Algos-Clustering' 'Moose-Algos-Clustering-Deprecated' 'Moose-Algos-FormalConceptAnalysis' 'Moose-Algos-Graph' 'Moose-Algos-Graph-Generators' 'Moose-Algos-HierarchicalGraph' 'Moose-Algos-InformationRetrieval' 'Moose-Algos-Kontractor' 'Moose-Algos-Lattice' 'Moose-Algos-LinearAlgebra');
				group: 'Examples' with: #('Moose-Algos-Graph-Generators-Examples');
				group: 'Tests' with: #('Moose-Algos-Graph-Tests' 'Moose-Algos-Graph-Generators-Tests' 'Moose-Algos-LinearAlgebra-Tests' 'Moose-Algos-Clustering-Tests' 'Moose-Algos-InformationRetrieval-Tests' 'Moose-Algos-FormalConceptAnalysis-Tests' 'Moose-Algos-Kontractor-Tests' 'Moose-Algos-Lattice-Tests' 'Moose-Algos-HierarchicalGraph') ].
			
	spec
		for: #(#'pharo4.x' #'pharo5.x' #'pharo6.x' #'pharo7.x')
		do: [
			spec
				package: 'Moose-Algos-Pharo8Compatibility';
				group: 'Core' with: #('Moose-Algos-Pharo8Compatibility') ]
]

{ #category : #dependencies }
BaselineOfMooseAlgos >> collectionExtensions: spec [
	spec baseline: 'CollectionExtensions' with: [ spec repository: 'github://pharo-contributions/CollectionExtensions:v1.x.x/src' ]
]

{ #category : #accessing }
BaselineOfMooseAlgos >> projectClass [
	^ MetacelloCypressBaselineProject
]

{ #category : #dependencies }
BaselineOfMooseAlgos >> roassal2: spec [
	spec baseline: 'Roassal2' with: [ spec repository: 'github://ObjectProfile/Roassal2/src' ]
]
