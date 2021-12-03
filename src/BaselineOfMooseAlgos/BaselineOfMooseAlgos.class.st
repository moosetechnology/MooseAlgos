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
	spec for: #common do: [ "Dependencies"
		self collectionExtensions: spec.

		self packages: spec.

		"Groups"
		spec
			group: 'default' with: #( 'Core' 'Tests' );
			group: 'Core'
			with: #( 'CollectionExtensions' 'Moose-Algos-Clustering'
				   'Moose-Algos-Clustering-Deprecated'
				   'Moose-Algos-FormalConceptAnalysis'
		         'Moose-Algos-InformationRetrieval'
				   'Moose-Algos-Kontractor'
				   'Moose-Algos-LinearAlgebra' );
			group: 'Tests'
			with:
				#( 'Moose-Algos-LinearAlgebra-Tests'
				   'Moose-Algos-Clustering-Tests' 'Moose-Algos-InformationRetrieval-Tests'
				   'Moose-Algos-FormalConceptAnalysis-Tests'
				   'Moose-Algos-Kontractor-Tests' ) ].

	spec
		for: #( #'pharo4.x' #'pharo5.x' #'pharo6.x' #'pharo7.x' )
		do: [ 
			spec
				package: 'Moose-Algos-Pharo8Compatibility';
				group: 'Core' with: #( 'Moose-Algos-Pharo8Compatibility' ) ]
]

{ #category : #dependencies }
BaselineOfMooseAlgos >> collectionExtensions: spec [
	spec baseline: 'CollectionExtensions' with: [ spec repository: 'github://pharo-contributions/CollectionExtensions:v1.x.x/src' ]
]

{ #category : #baselines }
BaselineOfMooseAlgos >> packages: spec [

	spec
		package: 'Moose-Algos-Clustering'
		with: [ spec requires: #( 'Moose-Algos-LinearAlgebra' ) ];
		package: 'Moose-Algos-Clustering-Deprecated'
		with: [ spec requires: #( 'Moose-Algos-Clustering' ) ];
		package: 'Moose-Algos-FormalConceptAnalysis';
		package: 'Moose-Algos-InformationRetrieval';
		package: 'Moose-Algos-Kontractor';
		package: 'Moose-Algos-LinearAlgebra';
		package: 'Moose-Algos-Clustering-Tests'
		with: [ spec requires: #( 'Moose-Algos-Clustering' ) ];
		
		package: 'Moose-Algos-FormalConceptAnalysis-Tests' with: [ 
			spec requires: #( 'Moose-Algos-FormalConceptAnalysis' ) ];
				
		package: 'Moose-Algos-InformationRetrieval-Tests'
		with: [ spec requires: #( 'Moose-Algos-InformationRetrieval' ) ];
		package: 'Moose-Algos-Kontractor-Tests'
		with: [ spec requires: #( 'Moose-Algos-Kontractor' ) ];
		package: 'Moose-Algos-LinearAlgebra-Tests'
		with: [ spec requires: #( 'Moose-Algos-LinearAlgebra' ) ].

	spec for: #( #'pharo8.x' ) do: [ 
		self roassal3: spec.
		spec package: 'Moose-Algos-Graph-Generators-Examples' with: [ 
			spec requires: #( 'Moose-Algos-Graph-Generators'
			   'Roassal3' ) ] ].
	spec for: #( #'pharo9.x' ) do: [ "Roassal3 is integrated in P9" ]
]

{ #category : #accessing }
BaselineOfMooseAlgos >> projectClass [
	^ MetacelloCypressBaselineProject
]

{ #category : #dependencies }
BaselineOfMooseAlgos >> roassal3: spec [

	spec
		baseline: 'Roassal3'
		with: [ spec repository: 'github://ObjectProfile/Roassal3:v0.9.5' ]
]
