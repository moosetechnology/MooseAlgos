"
self loadDevelopment
"
Class {
	#name : #ConfigurationOfMooseAlgos,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#category : #ConfigurationOfMooseAlgos
}

{ #category : #catalog }
ConfigurationOfMooseAlgos class >> catalogContactInfo [
	^ 'info@moosetechnology.org'
]

{ #category : #catalog }
ConfigurationOfMooseAlgos class >> catalogDescription [
	^ 'MooseAlgos is a collection of algorithms for graph and data mining. The library was developed as part of the Moose project, but it can be used as standalone.'
]

{ #category : #catalog }
ConfigurationOfMooseAlgos class >> catalogKeywords [
	^ #(analysis graph lattice clustering formal-concept-analysis linear-algebra)
	
]

{ #category : #private }
ConfigurationOfMooseAlgos class >> ensureMetacello [
	Smalltalk at: #MetacelloProject ifAbsent: [
		Gofer new
				url: 'http://seaside.gemstone.com/ss/metacello';
				addPackage: 'ConfigurationOfMetacello';
				load.
		(Smalltalk at: #ConfigurationOfMetacello) loadLatestVersion ]
]

{ #category : #'metacello tool support' }
ConfigurationOfMooseAlgos class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #loading }
ConfigurationOfMooseAlgos class >> load [
	self loadBleedingEdge
]

{ #category : #loading }
ConfigurationOfMooseAlgos class >> loadBleedingEdge [
	(self project version: #'bleedingEdge') load
]

{ #category : #loading }
ConfigurationOfMooseAlgos class >> loadDevelopment [
	"Load the #development version defined for this platform. The #development version will change over time and is not expected to be stable."

	"self loadDevelopment"

	<apiDocumentation>
	^(self project version: #development) load
]

{ #category : #loading }
ConfigurationOfMooseAlgos class >> loadStable [
	(self project version: #'stable') load
]

{ #category : #accessing }
ConfigurationOfMooseAlgos class >> project [

	^self new project
]

{ #category : #baselines }
ConfigurationOfMooseAlgos >> baseline20beta1: spec [ 
	<version: '2.0-beta.1-baseline'>
	
	spec for: #common do: [
		spec blessing: #baseline.
		spec repository: 'http://www.squeaksource.com/MooseAlgos'.
		spec 
			package: 'Moose-Algos-Graph' ;
			package: 'Moose-Tests-Algos-Graph' ;
			package: 'Moose-Algos-Clustering' ;
			package: 'Moose-Algos-LinearAlgebra'.
		spec group: 'Tests' with: #(
						'Moose-Tests-Algos-Graph'
						"Dangerous now: Clustering and LinearAlgebra tests chrash the VM"). 
		spec
			project: 'Mondrian for MooseAlgos' with: [
				spec
					className: 'ConfigurationOfMondrian';
					file: 'ConfigurationOfMondrian';
					version: 'default';
					repository: 'http://www.squeaksource.com/Mondrian' ].
	]
]

{ #category : #baselines }
ConfigurationOfMooseAlgos >> baseline20beta2: spec [ 
	<version: '2.0-beta.2-baseline'>
	
	spec for: #common do: [
		spec blessing: #baseline.
		spec repository: 'http://www.squeaksource.com/MooseAlgos'.
		spec 
			package: 'Moose-Algos-Graph' ;
			package: 'Moose-Tests-Algos-Graph' ;
			package: 'Moose-Algos-Clustering' ;
			package: 'Moose-Algos-LinearAlgebra'.
		spec group: 'Tests' with: #(
						'Moose-Tests-Algos-Graph'
						"Dangerous now: Clustering and LinearAlgebra tests chrash the VM"). 
	]
]

{ #category : #baselines }
ConfigurationOfMooseAlgos >> baseline20beta3: spec [ 
	<version: '2.0-beta.3-baseline'>
	
	spec for: #common do: [
		spec blessing: #baseline.
		spec repository: 'http://www.squeaksource.com/MooseAlgos'.
		spec 
			package: 'Moose-Algos-Graph' ;
			package: 'Moose-Algos-LinearAlgebra';
			package: 'Moose-Algos-Clustering' ;
			package: 'Moose-Algos-FormalConceptAnalysis';
			package: 'Moose-Algos-InformationRetrieval';
			package: 'Moose-Tests-Algos-Graph' ;
			package: 'Moose-Tests-Algos-LinearAlgebra' ;
			package: 'Moose-Tests-Algos-Clustering' ;
			package: 'Moose-Tests-Algos-InformationRetrieval'.
			spec group: 'Tests' with: #(
						'Moose-Tests-Algos-Graph' 'Moose-Tests-Algos-LinearAlgebra' 'Moose-Tests-Algos-Clustering' 'Moose-Tests-Algos-InformationRetrieval' ). 
	]
]

{ #category : #baselines }
ConfigurationOfMooseAlgos >> baseline20beta4: spec [ 
	<version: '2.0-beta.4-baseline'>
	
	spec for: #common do: [
		spec blessing: #baseline.
		spec repository: 'http://www.squeaksource.com/MooseAlgos'.
		spec 
			package: 'Moose-Algos-Graph' ;
			package: 'Moose-Tests-Algos-Graph' ;
			package: 'Moose-Tests-Algos-LinearAlgebra' ;
			package: 'Moose-Tests-Algos-Clustering' ;
			package: 'Moose-Tests-Algos-InformationRetrieval' ;
			package: 'Moose-Algos-Clustering' ;
			package: 'Moose-Algos-LinearAlgebra';
			package: 'Moose-Algos-FormalConceptAnalysis';
			package: 'Moose-Algos-InformationRetrieval'.
			"Dangerous now: Clustering and LinearAlgebra tests chrash the VM"
			spec group: 'Tests' with: #(
						'Moose-Tests-Algos-Graph' 'Moose-Tests-Algos-LinearAlgebra' 'Moose-Tests-Algos-Clustering' 'Moose-Tests-Algos-InformationRetrieval' ). 
	]
]

{ #category : #baselines }
ConfigurationOfMooseAlgos >> baseline23: spec [ 
	<version: '2.3-baseline'>
	
	spec for: #common do: [
		spec blessing: #baseline.
		spec description: 'First baseline on SmalltalkHub'.
		spec repository: 'http://www.smalltalkhub.com/mc/Moose/MooseAlgos/main'.
		spec 
			package: 'Moose-Algos-Graph' ;
			package: 'Moose-Tests-Algos-Graph' ;
			package: 'Moose-Tests-Algos-LinearAlgebra' ;
			package: 'Moose-Tests-Algos-Clustering' ;
			package: 'Moose-Tests-Algos-InformationRetrieval' ;
			package: 'Moose-Tests-Algos-FormalConceptAnalysis';
			package: 'Moose-Algos-Clustering' ;
			package: 'Moose-Algos-LinearAlgebra';
			package: 'Moose-Algos-FormalConceptAnalysis';
			package: 'Moose-Algos-Lattice';
			package: 'Moose-Algos-InformationRetrieval';
			package: 'Moose-Algos-Kontractor';
			package: 'Moose-Tests-Algos-Kontractor' ;
			package: 'CollectionExtensions' with: [spec repository: 'http://www.smalltalkhub.com/mc/Moose/CollectionExtensions/main'].
	
			spec group: 'Tests' with: #(
						'Moose-Tests-Algos-Graph'
						'Moose-Tests-Algos-LinearAlgebra'
						'Moose-Tests-Algos-Clustering'
						'Moose-Tests-Algos-InformationRetrieval'
						'Moose-Tests-Algos-FormalConceptAnalysis'
						'Moose-Tests-Algos-Kontractor'). 
	]
]

{ #category : #baselines }
ConfigurationOfMooseAlgos >> baseline24: spec [ 
	<version: '2.4-baseline'>
	
	spec for: #common do: [
		spec blessing: #baseline.
		spec description: 'Added HieararchicalGraph and tests for lattice'.
		spec repository: 'http://www.smalltalkhub.com/mc/Moose/MooseAlgos/main'.
		spec 
			package: 'Moose-Algos-Graph' ;
			package: 'Moose-Tests-Algos-Graph' ;
			
			package: 'Moose-Algos-HierarchicalGraph' with: [spec requires: 'Moose-Algos-Graph'];
			package: 'Moose-Tests-Algos-HierarchicalGraph' ;
			
			package: 'Moose-Tests-Algos-InformationRetrieval' ;
			
			package: 'Moose-Algos-FormalConceptAnalysis';
			package: 'Moose-Tests-Algos-FormalConceptAnalysis';
			
			package: 'Moose-Algos-Lattice';
			package: 'Moose-Tests-Algos-Lattice';
			
			package: 'Moose-Algos-LinearAlgebra';
			package: 'Moose-Tests-Algos-LinearAlgebra' ;
			
			package: 'Moose-Algos-Clustering' with: [spec requires: 'Moose-Algos-LinearAlgebra'] ;
			package: 'Moose-Algos-InformationRetrieval';
			
			package: 'Moose-Tests-Algos-Clustering' with: [spec requires: 'Moose-Algos-LinearAlgebra'] ;
			
			package: 'Moose-Algos-Kontractor';
			package: 'Moose-Tests-Algos-Kontractor' ;
			package: 'CollectionExtensions' with: [spec repository: 'http://www.smalltalkhub.com/mc/Moose/CollectionExtensions/main'].
	
			spec group: 'Tests' with: #(
						'Moose-Tests-Algos-Graph'
						'Moose-Tests-Algos-LinearAlgebra'
						'Moose-Tests-Algos-Clustering'
						'Moose-Tests-Algos-InformationRetrieval'
						'Moose-Tests-Algos-FormalConceptAnalysis'
						'Moose-Tests-Algos-Kontractor'
						'Moose-Tests-Algos-Lattice'
						'Moose-Tests-Algos-HierarchicalGraph'). 
	]
]

{ #category : #baselines }
ConfigurationOfMooseAlgos >> baseline25: spec [ 
	<version: '2.5-baseline'>
	
	spec for: #common do: [
		spec blessing: #baseline.
		spec description: 'Added traverser'.
		spec repository: 'http://www.smalltalkhub.com/mc/Moose/MooseAlgos/main'.
		spec 
			package: 'Moose-Algos-Graph' ;
			package: 'Moose-Tests-Algos-Graph' ;
			
			package: 'Moose-Algos-HierarchicalGraph' with: [spec requires: 'Moose-Algos-Graph'];
			package: 'Moose-Tests-Algos-HierarchicalGraph' ;
			
			package: 'Moose-Tests-Algos-InformationRetrieval' ;
			
			package: 'Moose-Algos-FormalConceptAnalysis';
			package: 'Moose-Tests-Algos-FormalConceptAnalysis';
			
			package: 'Moose-Algos-Lattice';
			package: 'Moose-Tests-Algos-Lattice';
			
			package: 'Moose-Algos-LinearAlgebra';
			package: 'Moose-Tests-Algos-LinearAlgebra' ;
			
			package: 'Moose-Algos-Clustering' with: [spec requires: 'Moose-Algos-LinearAlgebra'] ;
			package: 'Moose-Algos-InformationRetrieval';
			
			package: 'Moose-Tests-Algos-Clustering' with: [spec requires: 'Moose-Algos-LinearAlgebra'] ;
			
			package: 'Moose-Algos-Kontractor';
			package: 'Moose-Tests-Algos-Kontractor' ;
			
			package: 'Moose-Algos-GraphObjectTraverser' with: [spec requires: 'DeepTraverser'];

			project: 'DeepTraverser' with: [
				spec
					className: 'ConfigurationOfDeepTraverser';
					version: #development;
					file:  'ConfigurationOfDeepTraverser';
					repository: 'http://www.smalltalkhub.com/mc/Moose/DeepTraverser/main' ];
			
			package: 'CollectionExtensions' with: [spec repository: 'http://www.smalltalkhub.com/mc/Moose/CollectionExtensions/main'].
	
			spec group: 'Tests' with: #(
						'Moose-Tests-Algos-Graph'
						'Moose-Tests-Algos-LinearAlgebra'
						'Moose-Tests-Algos-Clustering'
						'Moose-Tests-Algos-InformationRetrieval'
						'Moose-Tests-Algos-FormalConceptAnalysis'
						'Moose-Tests-Algos-Kontractor'
						'Moose-Tests-Algos-Lattice'
						'Moose-Tests-Algos-HierarchicalGraph'). 
	]
]

{ #category : #baselines }
ConfigurationOfMooseAlgos >> baseline26: spec [ 
	<version: '2.6-baseline'>
	
	spec for: #common do: [
		spec blessing: #baseline.
		spec description: 'Remove broken Moose-Algos-GraphObjectTraverser'.
		spec repository: 'http://www.smalltalkhub.com/mc/Moose/MooseAlgos/main'.
		spec 
			package: 'Moose-Algos-Graph' ;
			package: 'Moose-Tests-Algos-Graph' ;
			
			package: 'Moose-Algos-HierarchicalGraph' with: [spec requires: 'Moose-Algos-Graph'];
			package: 'Moose-Tests-Algos-HierarchicalGraph' ;
			
			package: 'Moose-Tests-Algos-InformationRetrieval' ;
			
			package: 'Moose-Algos-FormalConceptAnalysis';
			package: 'Moose-Tests-Algos-FormalConceptAnalysis';
			
			package: 'Moose-Algos-Lattice';
			package: 'Moose-Tests-Algos-Lattice';
			
			package: 'Moose-Algos-LinearAlgebra';
			package: 'Moose-Tests-Algos-LinearAlgebra' ;
			
			package: 'Moose-Algos-Clustering' with: [spec requires: 'Moose-Algos-LinearAlgebra'] ;
			package: 'Moose-Algos-InformationRetrieval';
			
			package: 'Moose-Tests-Algos-Clustering' with: [spec requires: 'Moose-Algos-LinearAlgebra'] ;
			
			package: 'Moose-Algos-Kontractor';
			package: 'Moose-Tests-Algos-Kontractor' ;

			project: 'DeepTraverser' with: [
				spec
					className: 'ConfigurationOfDeepTraverser';
					version: #development;
					file:  'ConfigurationOfDeepTraverser';
					repository: 'http://www.smalltalkhub.com/mc/Moose/DeepTraverser/main' ];
			
			package: 'CollectionExtensions' with: [spec repository: 'http://www.smalltalkhub.com/mc/Moose/CollectionExtensions/main'].
	
			spec group: 'Tests' with: #(
						'Moose-Tests-Algos-Graph'
						'Moose-Tests-Algos-LinearAlgebra'
						'Moose-Tests-Algos-Clustering'
						'Moose-Tests-Algos-InformationRetrieval'
						'Moose-Tests-Algos-FormalConceptAnalysis'
						'Moose-Tests-Algos-Kontractor'
						'Moose-Tests-Algos-Lattice'
						'Moose-Tests-Algos-HierarchicalGraph'). 
	]
]

{ #category : #'symbolic versions' }
ConfigurationOfMooseAlgos >> development: spec [
	<symbolicVersion: #'development'>

	spec for: #'common' version: #'stable'.

	spec for: #'pharo5.x' version: #'stable'.

	spec for: #'pharo6.x' version: '2.6-baseline'.

]

{ #category : #baselines }
ConfigurationOfMooseAlgos >> legacyDefault: spec [ 
	<version: 'legacyDefault'>
	
	spec for: #common do: [
		spec blessing: #baseline.
		spec repository: 'http://www.squeaksource.com/MooseAlgos'.
		spec 
			package: 'Moose-Algos-Graph' ;
			package: 'Moose-Tests-Algos-Graph' ;
			package: 'Moose-Tests-Algos-LinearAlgebra' ;
			package: 'Moose-Tests-Algos-Clustering' ;
			package: 'Moose-Tests-Algos-InformationRetrieval' ;
			package: 'Moose-Tests-Algos-FormalConceptAnalysis';
			package: 'Moose-Algos-Clustering' ;
			package: 'Moose-Algos-LinearAlgebra';
			package: 'Moose-Algos-FormalConceptAnalysis';
			package: 'Moose-Algos-Lattice';
			package: 'Moose-Algos-InformationRetrieval';
			package: 'Moose-Algos-Kontractor';
			package: 'Moose-Tests-Algos-Kontractor'.
			spec group: 'Tests' with: #(
						'Moose-Tests-Algos-Graph'
						'Moose-Tests-Algos-LinearAlgebra'
						'Moose-Tests-Algos-Clustering'
						'Moose-Tests-Algos-InformationRetrieval'
						'Moose-Tests-Algos-FormalConceptAnalysis'
						'Moose-Tests-Algos-Kontractor'). 
	]
]

{ #category : #snapshots }
ConfigurationOfMooseAlgos >> populateSpec: aSpec with: list [
	"generated by Snapshotcello
	
	creates a spec object for the package and the version stored in the list"
	
	list do: [:each |
		aSpec package: each third with: [
			aSpec file: (each first  copyUpToLast: $. ).
			aSpec repository: each second ] ]
]

{ #category : #accessing }
ConfigurationOfMooseAlgos >> project [

	^ project ifNil: [ | constructor |
		"Bootstrap Metacello if it is not already loaded"
		self class ensureMetacello.
		"Construct Metacello project"
		constructor := (Smalltalk at: #MetacelloVersionConstructor) on: self.
		project := constructor project.
		project]
]

{ #category : #snapshots }
ConfigurationOfMooseAlgos >> snapshot1 [
	"generated by Snapshotcello"

	^ #( 
		#('Moose-Algos-Graph-TudorGirba.18.mcz'  'http://www.smalltalkhub.com/mc/Moose/MooseAlgos/main/'  'Moose-Algos-Graph' ) 
		#('Moose-Tests-Algos-Graph-AndreHora.20.mcz'  'http://www.smalltalkhub.com/mc/Moose/MooseAlgos/main/'  'Moose-Tests-Algos-Graph' ) 
		#('Moose-Algos-HierarchicalGraph-DennisSchenk.11.mcz'  'http://www.smalltalkhub.com/mc/Moose/MooseAlgos/main/'  'Moose-Algos-HierarchicalGraph' ) 
		#('Moose-Tests-Algos-HierarchicalGraph-DennisSchenk.10.mcz'  'http://www.smalltalkhub.com/mc/Moose/MooseAlgos/main/'  'Moose-Tests-Algos-HierarchicalGraph' ) 
		#('Moose-Tests-Algos-InformationRetrieval-AndreHora.5.mcz'  'http://www.smalltalkhub.com/mc/Moose/MooseAlgos/main/'  'Moose-Tests-Algos-InformationRetrieval' ) 
		#('Moose-Algos-FormalConceptAnalysis-usmanbhatti.11.mcz'  'http://www.smalltalkhub.com/mc/Moose/MooseAlgos/main/'  'Moose-Algos-FormalConceptAnalysis' ) 
		#('Moose-Tests-Algos-FormalConceptAnalysis-AndreHora.5.mcz'  'http://www.smalltalkhub.com/mc/Moose/MooseAlgos/main/'  'Moose-Tests-Algos-FormalConceptAnalysis' ) 
		#('Moose-Algos-Lattice-usmanbhatti.10.mcz'  'http://www.smalltalkhub.com/mc/Moose/MooseAlgos/main/'  'Moose-Algos-Lattice' ) 
		#('Moose-Tests-Algos-Lattice-AndreHora.9.mcz'  'http://www.smalltalkhub.com/mc/Moose/MooseAlgos/main/'  'Moose-Tests-Algos-Lattice' ) 
		#('Moose-Algos-LinearAlgebra-TudorGirba.19.mcz'  'http://www.smalltalkhub.com/mc/Moose/MooseAlgos/main/'  'Moose-Algos-LinearAlgebra' ) 
		#('Moose-Tests-Algos-LinearAlgebra-AndreHora.4.mcz'  'http://www.smalltalkhub.com/mc/Moose/MooseAlgos/main/'  'Moose-Tests-Algos-LinearAlgebra' ) 
		#('Moose-Algos-Clustering-simon_denier.9.mcz'  'http://www.smalltalkhub.com/mc/Moose/MooseAlgos/main/'  'Moose-Algos-Clustering' ) 
		#('Moose-Algos-InformationRetrieval-simondenier.12.mcz'  'http://www.smalltalkhub.com/mc/Moose/MooseAlgos/main/'  'Moose-Algos-InformationRetrieval' ) 
		#('Moose-Tests-Algos-Clustering-AndreHora.4.mcz'  'http://www.smalltalkhub.com/mc/Moose/MooseAlgos/main/'  'Moose-Tests-Algos-Clustering' ) 
		#('Moose-Algos-Kontractor-TudorGirba.2.mcz'  'http://www.smalltalkhub.com/mc/Moose/MooseAlgos/main/'  'Moose-Algos-Kontractor' ) 
		#('Moose-Tests-Algos-Kontractor-AndreHora.3.mcz'  'http://www.smalltalkhub.com/mc/Moose/MooseAlgos/main/'  'Moose-Tests-Algos-Kontractor' ) 
		#('CollectionExtensions-TudorGirba.34.mcz'  'http://www.smalltalkhub.com/mc/Moose/CollectionExtensions/main/'  'CollectionExtensions' ) 
	)
]

{ #category : #snapshots }
ConfigurationOfMooseAlgos >> snapshot2 [
	"generated by Snapshotcello"

	^ #( 
		#('Moose-Algos-Graph-AlexandreBergel.19.mcz'  'http://www.smalltalkhub.com/mc/Moose/MooseAlgos/main/'  'Moose-Algos-Graph' ) 
		#('Moose-Tests-Algos-Graph-AlexandreBergel.22.mcz'  'http://www.smalltalkhub.com/mc/Moose/MooseAlgos/main/'  'Moose-Tests-Algos-Graph' ) 
		#('Moose-Algos-HierarchicalGraph-DennisSchenk.11.mcz'  'http://www.smalltalkhub.com/mc/Moose/MooseAlgos/main/'  'Moose-Algos-HierarchicalGraph' ) 
		#('Moose-Tests-Algos-HierarchicalGraph-DennisSchenk.10.mcz'  'http://www.smalltalkhub.com/mc/Moose/MooseAlgos/main/'  'Moose-Tests-Algos-HierarchicalGraph' ) 
		#('Moose-Tests-Algos-InformationRetrieval-AndreHora.5.mcz'  'http://www.smalltalkhub.com/mc/Moose/MooseAlgos/main/'  'Moose-Tests-Algos-InformationRetrieval' ) 
		#('Moose-Algos-FormalConceptAnalysis-usmanbhatti.11.mcz'  'http://www.smalltalkhub.com/mc/Moose/MooseAlgos/main/'  'Moose-Algos-FormalConceptAnalysis' ) 
		#('Moose-Tests-Algos-FormalConceptAnalysis-AlexandreBergel.6.mcz'  'http://www.smalltalkhub.com/mc/Moose/MooseAlgos/main/'  'Moose-Tests-Algos-FormalConceptAnalysis' ) 
		#('Moose-Algos-Lattice-usmanbhatti.10.mcz'  'http://www.smalltalkhub.com/mc/Moose/MooseAlgos/main/'  'Moose-Algos-Lattice' ) 
		#('Moose-Tests-Algos-Lattice-AndreHora.9.mcz'  'http://www.smalltalkhub.com/mc/Moose/MooseAlgos/main/'  'Moose-Tests-Algos-Lattice' ) 
		#('Moose-Algos-LinearAlgebra-TudorGirba.19.mcz'  'http://www.smalltalkhub.com/mc/Moose/MooseAlgos/main/'  'Moose-Algos-LinearAlgebra' ) 
		#('Moose-Tests-Algos-LinearAlgebra-AndreHora.4.mcz'  'http://www.smalltalkhub.com/mc/Moose/MooseAlgos/main/'  'Moose-Tests-Algos-LinearAlgebra' ) 
		#('Moose-Algos-Clustering-simon_denier.9.mcz'  'http://www.smalltalkhub.com/mc/Moose/MooseAlgos/main/'  'Moose-Algos-Clustering' ) 
		#('Moose-Algos-InformationRetrieval-simondenier.12.mcz'  'http://www.smalltalkhub.com/mc/Moose/MooseAlgos/main/'  'Moose-Algos-InformationRetrieval' ) 
		#('Moose-Tests-Algos-Clustering-AndreHora.4.mcz'  'http://www.smalltalkhub.com/mc/Moose/MooseAlgos/main/'  'Moose-Tests-Algos-Clustering' ) 
		#('Moose-Algos-Kontractor-TudorGirba.2.mcz'  'http://www.smalltalkhub.com/mc/Moose/MooseAlgos/main/'  'Moose-Algos-Kontractor' ) 
		#('Moose-Tests-Algos-Kontractor-AndreHora.3.mcz'  'http://www.smalltalkhub.com/mc/Moose/MooseAlgos/main/'  'Moose-Tests-Algos-Kontractor' ) 
		#('CollectionExtensions-TudorGirba.34.mcz'  'http://www.smalltalkhub.com/mc/Moose/CollectionExtensions/main/'  'CollectionExtensions' ) 
	)
]

{ #category : #'symbolic versions' }
ConfigurationOfMooseAlgos >> stable: spec [
	<symbolicVersion: #'stable'>
	
	spec for: #'common' version: '3.0'.

	spec for: #'pharo1.4.x' version: '2.3'.

	spec for: #'pharo2.x' version: '2.5-snapshot'.

	spec for: #'pharo3.x' version: '2.5'.

	spec for: #'pharo4.x' version: '2.6'.

	spec for: #'pharo5.x' version: '3.0'.

]

{ #category : #versions }
ConfigurationOfMooseAlgos >> version206: spec [
	<version: '2.0.6' imports: #('2.0-beta.3-baseline')>

	spec for: #common do: [
		spec author: 'simondenier'.
		spec timestamp: '4/6/2010 19:41'.
		spec blessing: #development.
		spec 
			package: 'Moose-Algos-Graph' with: 'Moose-Algos-Graph-jl.7';
			package: 'Moose-Algos-LinearAlgebra' with: 'Moose-Algos-LinearAlgebra-cyrille_delaunay.10';
			package: 'Moose-Algos-Clustering' with: 'Moose-Algos-Clustering-cyrille_delaunay.4';
			package: 'Moose-Algos-FormalConceptAnalysis' with: 'Moose-Algos-FormalConceptAnalysis-cyrille_delaunay.2';
			package: 'Moose-Algos-InformationRetrieval' with: 'Moose-Algos-InformationRetrieval-cyrille_delaunay.8';
			package: 'Moose-Tests-Algos-Graph' with: 'Moose-Tests-Algos-Graph-simon_denier.6';
			package: 'Moose-Tests-Algos-LinearAlgebra' with: 'Moose-Tests-Algos-LinearAlgebra-cyrille_delaunay.1';
			package: 'Moose-Tests-Algos-Clustering' with: 'Moose-Tests-Algos-Clustering-cyrille_delaunay.1';
			package: 'Moose-Tests-Algos-InformationRetrieval' with: 'Moose-Tests-Algos-InformationRetrieval-cyrille_delaunay.1'.].
]

{ #category : #versions }
ConfigurationOfMooseAlgos >> version20beta1: spec [
	<version: '2.0-beta.1' imports: #('2.0-beta.1-baseline')>

	spec for: #common do: [
		spec author: 'tg'.
		spec timestamp: '11/22/2009 11:21'.
		spec project: 'Mondrian for MooseAlgos' with: '2.0-beta.1'.
		spec 
			package: 'Moose-Algos-Graph' with: 'Moose-Algos-Graph-simon_denier.1';
			package: 'Moose-Tests-Algos-Graph' with: 'Moose-Tests-Algos-Graph-simon_denier.1';
			package: 'Moose-Algos-Clustering' with: 'Moose-Algos-Clustering-simon_denier.1';
			package: 'Moose-Algos-LinearAlgebra' with: 'Moose-Algos-LinearAlgebra-simon_denier.1'.].
]

{ #category : #versions }
ConfigurationOfMooseAlgos >> version20beta2: spec [
	<version: '2.0-beta.2' imports: #('2.0-beta.2-baseline')>

	spec for: #common do: [
		spec blessing: #beta.
		spec author: 'tg'.
		spec timestamp: '12/28/2009 21:12'.
		spec 
			package: 'Moose-Algos-Graph' with: 'Moose-Algos-Graph-simon_denier.1';
			package: 'Moose-Tests-Algos-Graph' with: 'Moose-Tests-Algos-Graph-simon_denier.1';
			package: 'Moose-Algos-Clustering' with: 'Moose-Algos-Clustering-simon_denier.1';
			package: 'Moose-Algos-LinearAlgebra' with: 'Moose-Algos-LinearAlgebra-simon_denier.1'.].
]

{ #category : #versions }
ConfigurationOfMooseAlgos >> version20beta3: spec [
	<version: '2.0-beta.3' imports: #('2.0-beta.2-baseline')>

	spec for: #common do: [
		spec author: 'simondenier'.
		spec timestamp: '1/18/2010 14:28'.
		spec blessing: #beta.
		spec 
			package: 'Moose-Algos-Graph' with: 'Moose-Algos-Graph-simondenier.2';
			package: 'Moose-Tests-Algos-Graph' with: 'Moose-Tests-Algos-Graph-simondenier.2';
			package: 'Moose-Algos-Clustering' with: 'Moose-Algos-Clustering-simon_denier.1';
			package: 'Moose-Algos-LinearAlgebra' with: 'Moose-Algos-LinearAlgebra-simon_denier.1'.].
]

{ #category : #versions }
ConfigurationOfMooseAlgos >> version20beta5: spec [
	<version: '2.0-beta.5' imports: #('2.0-beta.3-baseline')>

	spec for: #common do: [
		spec blessing: #beta.
		spec author: 'simondenier'.
		spec timestamp: '3/17/2010 22:55'.
		spec 
			package: 'Moose-Algos-Graph' with: 'Moose-Algos-Graph-simondenier.4';
			package: 'Moose-Algos-LinearAlgebra' with: 'Moose-Algos-LinearAlgebra-cyrille_delaunay.10';
			package: 'Moose-Algos-Clustering' with: 'Moose-Algos-Clustering-cyrille_delaunay.4';
			package: 'Moose-Algos-FormalConceptAnalysis' with: 'Moose-Algos-FormalConceptAnalysis-cyrille_delaunay.2';
			package: 'Moose-Algos-InformationRetrieval' with: 'Moose-Algos-InformationRetrieval-cyrille_delaunay.5';
			package: 'Moose-Tests-Algos-Graph' with: 'Moose-Tests-Algos-Graph-simondenier.4';
			package: 'Moose-Tests-Algos-LinearAlgebra' with: 'Moose-Tests-Algos-LinearAlgebra-cyrille_delaunay.1';
			package: 'Moose-Tests-Algos-Clustering' with: 'Moose-Tests-Algos-Clustering-cyrille_delaunay.1';
			package: 'Moose-Tests-Algos-InformationRetrieval' with: 'Moose-Tests-Algos-InformationRetrieval-cyrille_delaunay.1'.].
]

{ #category : #versions }
ConfigurationOfMooseAlgos >> version20beta7: spec [
	<version: '2.0-beta.7' imports: #('2.0-beta.3-baseline')>

	spec for: #common do: [
		spec author: 'simondenier'.
		spec timestamp: '4/8/2010 11:11'.
		spec blessing: #beta.
		spec 
			package: 'Moose-Algos-Graph' with: 'Moose-Algos-Graph-jl.7';
			package: 'Moose-Algos-LinearAlgebra' with: 'Moose-Algos-LinearAlgebra-cyrille_delaunay.13';
			package: 'Moose-Algos-Clustering' with: 'Moose-Algos-Clustering-cyrille_delaunay.4';
			package: 'Moose-Algos-FormalConceptAnalysis' with: 'Moose-Algos-FormalConceptAnalysis-cyrille_delaunay.2';
			package: 'Moose-Algos-InformationRetrieval' with: 'Moose-Algos-InformationRetrieval-cyrille_delaunay.8';
			package: 'Moose-Tests-Algos-Graph' with: 'Moose-Tests-Algos-Graph-simon_denier.6';
			package: 'Moose-Tests-Algos-LinearAlgebra' with: 'Moose-Tests-Algos-LinearAlgebra-cyrille_delaunay.2';
			package: 'Moose-Tests-Algos-Clustering' with: 'Moose-Tests-Algos-Clustering-cyrille_delaunay.1';
			package: 'Moose-Tests-Algos-InformationRetrieval' with: 'Moose-Tests-Algos-InformationRetrieval-cyrille_delaunay.1'.].
]

{ #category : #versions }
ConfigurationOfMooseAlgos >> version20beta8: spec [
	<version: '2.0-beta.8' imports: #('2.0-beta.3-baseline')>

	spec for: #common do: [
		spec author: 'jannik.laval'.
		spec timestamp: '6/1/2010 22:45'.
		spec blessing: #beta.
		spec 
			package: 'Moose-Algos-Graph' with: 'Moose-Algos-Graph-tg.8';
			package: 'Moose-Algos-LinearAlgebra' with: 'Moose-Algos-LinearAlgebra-jannik_laval.15';
			package: 'Moose-Algos-Clustering' with: 'Moose-Algos-Clustering-jannik_laval.6';
			package: 'Moose-Algos-FormalConceptAnalysis' with: 'Moose-Algos-FormalConceptAnalysis-jannik_laval.4';
			package: 'Moose-Algos-InformationRetrieval' with: 'Moose-Algos-InformationRetrieval-cyrille_delaunay.8';
			package: 'Moose-Tests-Algos-Graph' with: 'Moose-Tests-Algos-Graph-simon_denier.6';
			package: 'Moose-Tests-Algos-LinearAlgebra' with: 'Moose-Tests-Algos-LinearAlgebra-cyrille_delaunay.2';
			package: 'Moose-Tests-Algos-Clustering' with: 'Moose-Tests-Algos-Clustering-cyrille_delaunay.1';
			package: 'Moose-Tests-Algos-InformationRetrieval' with: 'Moose-Tests-Algos-InformationRetrieval-cyrille_delaunay.1'.].
]

{ #category : #versions }
ConfigurationOfMooseAlgos >> version20beta9: spec [
	<version: '2.0-beta.9' imports: #('2.0-beta.4-baseline')>

	spec for: #common do: [
		spec author: 'jl'.
		spec timestamp: '09/13/2010 22:00'.
		spec blessing: #beta.
		spec 
			package: 'Moose-Algos-Graph' with: 'Moose-Algos-Graph-simon_denier.9';
			package: 'Moose-Algos-LinearAlgebra' with: 'Moose-Algos-LinearAlgebra-jannik_laval.15';
			package: 'Moose-Algos-Clustering' with: 'Moose-Algos-Clustering-jannik_laval.6';
			package: 'Moose-Algos-FormalConceptAnalysis' with: 'Moose-Algos-FormalConceptAnalysis-jl.5';
			package: 'Moose-Algos-InformationRetrieval' with: 'Moose-Algos-InformationRetrieval-jl.10';
			package: 'Moose-Tests-Algos-Graph' with: 'Moose-Tests-Algos-Graph-Alexandre_Bergel.8';
			package: 'Moose-Tests-Algos-LinearAlgebra' with: 'Moose-Tests-Algos-LinearAlgebra-cyrille_delaunay.2';
			package: 'Moose-Tests-Algos-Clustering' with: 'Moose-Tests-Algos-Clustering-cyrille_delaunay.1';
			package: 'Moose-Tests-Algos-InformationRetrieval' with: 'Moose-Tests-Algos-InformationRetrieval-simon_denier.2'.].
]

{ #category : #versions }
ConfigurationOfMooseAlgos >> version21: spec [ 
        <version: '2.1' imports: #('2.0-beta.4-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'Moose-Algos-Graph' with: 'Moose-Algos-Graph-simon_denier.14'.
			spec package: 'Moose-Algos-LinearAlgebra' with: 'Moose-Algos-LinearAlgebra-simon_denier.17'.
			spec package: 'Moose-Algos-Clustering' with: 'Moose-Algos-Clustering-simon_denier.9'.
			spec package: 'Moose-Algos-FormalConceptAnalysis' with: 'Moose-Algos-FormalConceptAnalysis-simon_denier.6'.
			spec package: 'Moose-Algos-InformationRetrieval' with: 'Moose-Algos-InformationRetrieval-simon_denier.11'.
			spec package: 'Moose-Tests-Algos-Graph' with: 'Moose-Tests-Algos-Graph-AlexandreBergel.13'.
			spec package: 'Moose-Tests-Algos-LinearAlgebra' with: 'Moose-Tests-Algos-LinearAlgebra-simon_denier.3'.
			spec package: 'Moose-Tests-Algos-Clustering' with: 'Moose-Tests-Algos-Clustering-simon_denier.2'.
			spec package: 'Moose-Tests-Algos-InformationRetrieval' with: 'Moose-Tests-Algos-InformationRetrieval-simon_denier.3'.
                ].
]

{ #category : #versions }
ConfigurationOfMooseAlgos >> version22: spec [ 
        <version: '2.2' imports: #('2.0-beta.4-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'Moose-Algos-Graph' with: 'Moose-Algos-Graph-simon_denier.14'.
			spec package: 'Moose-Tests-Algos-Graph' with: 'Moose-Tests-Algos-Graph-AlexandreBergel.14'.
			spec package: 'Moose-Tests-Algos-LinearAlgebra' with: 'Moose-Tests-Algos-LinearAlgebra-simon_denier.3'.
			spec package: 'Moose-Tests-Algos-Clustering' with: 'Moose-Tests-Algos-Clustering-simon_denier.2'.
			spec package: 'Moose-Tests-Algos-InformationRetrieval' with: 'Moose-Tests-Algos-InformationRetrieval-simon_denier.3'.
			spec package: 'Moose-Algos-Clustering' with: 'Moose-Algos-Clustering-simon_denier.9'.
			spec package: 'Moose-Algos-LinearAlgebra' with: 'Moose-Algos-LinearAlgebra-simon_denier.17'.
			spec package: 'Moose-Algos-FormalConceptAnalysis' with: 'Moose-Algos-FormalConceptAnalysis-simon_denier.6'.
			spec package: 'Moose-Algos-InformationRetrieval' with: 'Moose-Algos-InformationRetrieval-simon_denier.11'.
                ].
]

{ #category : #versions }
ConfigurationOfMooseAlgos >> version23: spec [
	<version: '2.3' imports: #('2.3-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'development'.
		spec description: 'First version on SmalltalkHub. Same as 2.2 on SqueakSource'.
		spec author: 'NicolasAnquetil'.
		spec timestamp: '2/15/2013 13:48'.
		spec 
			package: 'Moose-Algos-Graph' with: 'Moose-Algos-Graph-janniklaval.16';
			package: 'Moose-Tests-Algos-Graph' with: 'Moose-Tests-Algos-Graph-AlexandreBergel.18';
			package: 'Moose-Tests-Algos-LinearAlgebra' with: 'Moose-Tests-Algos-LinearAlgebra-simon_denier.3';
			package: 'Moose-Tests-Algos-Clustering' with: 'Moose-Tests-Algos-Clustering-simon_denier.2';
			package: 'Moose-Tests-Algos-InformationRetrieval' with: 'Moose-Tests-Algos-InformationRetrieval-simondenier.4';
			package: 'Moose-Tests-Algos-FormalConceptAnalysis' with: 'Moose-Tests-Algos-FormalConceptAnalysis-usmanbhatti.3';
			package: 'Moose-Algos-Clustering' with: 'Moose-Algos-Clustering-simon_denier.9';
			package: 'Moose-Algos-LinearAlgebra' with: 'Moose-Algos-LinearAlgebra-simon_denier.17';
			package: 'Moose-Algos-FormalConceptAnalysis' with: 'Moose-Algos-FormalConceptAnalysis-usmanbhatti.11';
			package: 'Moose-Algos-Lattice' with: 'Moose-Algos-Lattice-usmanbhatti.10';
			package: 'Moose-Algos-InformationRetrieval' with: 'Moose-Algos-InformationRetrieval-simondenier.12';
			package: 'Moose-Algos-Kontractor' with: 'Moose-Algos-Kontractor-TudorGirba.2';
			package: 'Moose-Tests-Algos-Kontractor' with: 'Moose-Tests-Algos-Kontractor-TudorGirba.2';
			package: 'CollectionExtensions' with: 'CollectionExtensions-TudorGirba.32'. ].

]

{ #category : #'snapshot versions' }
ConfigurationOfMooseAlgos >> version24snapshot: spec [
	"generated by Snapshotcello"
	<version: '2.4-snapshot'>

	spec for: #common do: [
		self populateSpec: spec with: self snapshot1 ]
]

{ #category : #versions }
ConfigurationOfMooseAlgos >> version25: spec [
	<version: '2.5' imports: #('2.5-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'For Moose 5.0'.
		spec author: 'StephanEggermont'.
		spec timestamp: '12/10/2014 15:04'.
		spec 
			project: 'DeepTraverser' with: #stable.
		spec 
			package: 'Moose-Algos-Clustering' with: 'Moose-Algos-Clustering-AndreHora.10';
			package: 'Moose-Algos-FormalConceptAnalysis' with: 'Moose-Algos-FormalConceptAnalysis-usmanbhatti.11';
			package: 'Moose-Algos-Graph' with: 'Moose-Algos-Graph-VincentBlondeau.21';
			package: 'Moose-Algos-GraphObjectTraverser' with: 'Moose-Algos-GraphObjectTraverser-TudorGirba.4';
			package: 'Moose-Algos-HierarchicalGraph' with: 'Moose-Algos-HierarchicalGraph-DennisSchenk.22';
			package: 'Moose-Algos-InformationRetrieval' with: 'Moose-Algos-InformationRetrieval-VincentBlondeau.13';
			package: 'Moose-Algos-Kontractor' with: 'Moose-Algos-Kontractor-LeoPerard.4';
			package: 'Moose-Algos-Lattice' with: 'Moose-Algos-Lattice-VincentBlondeau.11';
			package: 'Moose-Algos-LinearAlgebra' with: 'Moose-Algos-LinearAlgebra-TudorGirba.21';
			package: 'Moose-Tests-Algos-Clustering' with: 'Moose-Tests-Algos-Clustering-AndreHora.4';
			package: 'Moose-Tests-Algos-FormalConceptAnalysis' with: 'Moose-Tests-Algos-FormalConceptAnalysis-AlexandreBergel.6';
			package: 'Moose-Tests-Algos-Graph' with: 'Moose-Tests-Algos-Graph-TudorGirba.27';
			package: 'Moose-Tests-Algos-HierarchicalGraph' with: 'Moose-Tests-Algos-HierarchicalGraph-DennisSchenk.14';
			package: 'Moose-Tests-Algos-InformationRetrieval' with: 'Moose-Tests-Algos-InformationRetrieval-AndreHora.5';
			package: 'Moose-Tests-Algos-Kontractor' with: 'Moose-Tests-Algos-Kontractor-TudorGirba.5';
			package: 'Moose-Tests-Algos-Lattice' with: 'Moose-Tests-Algos-Lattice-AndreHora.9';
			package: 'Moose-Tests-Algos-LinearAlgebra' with: 'Moose-Tests-Algos-LinearAlgebra-AndreHora.4';
			package: 'CollectionExtensions' with: 'CollectionExtensions-TudorGirba.40'. ].

]

{ #category : #'snapshot versions' }
ConfigurationOfMooseAlgos >> version25snapshot: spec [
	"generated by Snapshotcello"
	<version: '2.5-snapshot'>

	spec for: #common do: [
		self populateSpec: spec with: self snapshot2 ]
]

{ #category : #versions }
ConfigurationOfMooseAlgos >> version26: spec [
	<version: '2.6' imports: #('2.5-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'For Moose 5.1'.
		spec author: 'AndreiChis'.
		spec timestamp: '5/18/2015 00:41'.
		spec 
			project: 'DeepTraverser' with: #stable.
		spec 
			package: 'Moose-Algos-Clustering' with: 'Moose-Algos-Clustering-AndreHora.10';
			package: 'Moose-Algos-FormalConceptAnalysis' with: 'Moose-Algos-FormalConceptAnalysis-usmanbhatti.11';
			package: 'Moose-Algos-Graph' with: 'Moose-Algos-Graph-ChristopheDemarey.30';
			package: 'Moose-Algos-GraphObjectTraverser' with: 'Moose-Algos-GraphObjectTraverser-ChristopheDemarey.5';
			package: 'Moose-Algos-HierarchicalGraph' with: 'Moose-Algos-HierarchicalGraph-DennisSchenk.22';
			package: 'Moose-Algos-InformationRetrieval' with: 'Moose-Algos-InformationRetrieval-VincentBlondeau.13';
			package: 'Moose-Algos-Kontractor' with: 'Moose-Algos-Kontractor-LeoPerard.4';
			package: 'Moose-Algos-Lattice' with: 'Moose-Algos-Lattice-VincentBlondeau.11';
			package: 'Moose-Algos-LinearAlgebra' with: 'Moose-Algos-LinearAlgebra-TudorGirba.21';
			package: 'Moose-Tests-Algos-Clustering' with: 'Moose-Tests-Algos-Clustering-AndreHora.4';
			package: 'Moose-Tests-Algos-FormalConceptAnalysis' with: 'Moose-Tests-Algos-FormalConceptAnalysis-AlexandreBergel.6';
			package: 'Moose-Tests-Algos-Graph' with: 'Moose-Tests-Algos-Graph-ChristopheDemarey.33';
			package: 'Moose-Tests-Algos-HierarchicalGraph' with: 'Moose-Tests-Algos-HierarchicalGraph-DennisSchenk.14';
			package: 'Moose-Tests-Algos-InformationRetrieval' with: 'Moose-Tests-Algos-InformationRetrieval-AndreHora.5';
			package: 'Moose-Tests-Algos-Kontractor' with: 'Moose-Tests-Algos-Kontractor-TudorGirba.5';
			package: 'Moose-Tests-Algos-Lattice' with: 'Moose-Tests-Algos-Lattice-AndreHora.9';
			package: 'Moose-Tests-Algos-LinearAlgebra' with: 'Moose-Tests-Algos-LinearAlgebra-AndreHora.4';
			package: 'CollectionExtensions' with: 'CollectionExtensions-TudorGirba.41'. ].

]

{ #category : #versions }
ConfigurationOfMooseAlgos >> version30: spec [
	<version: '3.0' imports: #('2.5-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'Moose 6.0 release'.
		spec author: 'TudorGirba'.
		spec timestamp: '8/14/2016 20:44'.
		spec project: 'DeepTraverser' with: #'stable'.
		spec 
			package: 'Moose-Algos-Graph' with: 'Moose-Algos-Graph-vincentBlondeau.31';
			package: 'Moose-Tests-Algos-Graph' with: 'Moose-Tests-Algos-Graph-ChristopheDemarey.33';
			package: 'Moose-Algos-HierarchicalGraph' with: 'Moose-Algos-HierarchicalGraph-DennisSchenk.22';
			package: 'Moose-Tests-Algos-HierarchicalGraph' with: 'Moose-Tests-Algos-HierarchicalGraph-DennisSchenk.14';
			package: 'Moose-Tests-Algos-InformationRetrieval' with: 'Moose-Tests-Algos-InformationRetrieval-VB.6';
			package: 'Moose-Algos-FormalConceptAnalysis' with: 'Moose-Algos-FormalConceptAnalysis-usmanbhatti.11';
			package: 'Moose-Tests-Algos-FormalConceptAnalysis' with: 'Moose-Tests-Algos-FormalConceptAnalysis-AlexandreBergel.6';
			package: 'Moose-Algos-Lattice' with: 'Moose-Algos-Lattice-VincentBlondeau.11';
			package: 'Moose-Tests-Algos-Lattice' with: 'Moose-Tests-Algos-Lattice-AndreHora.9';
			package: 'Moose-Algos-LinearAlgebra' with: 'Moose-Algos-LinearAlgebra-TudorGirba.22';
			package: 'Moose-Tests-Algos-LinearAlgebra' with: 'Moose-Tests-Algos-LinearAlgebra-AndreHora.4';
			package: 'Moose-Algos-Clustering' with: 'Moose-Algos-Clustering-AndreHora.10';
			package: 'Moose-Algos-InformationRetrieval' with: 'Moose-Algos-InformationRetrieval-TudorGirba.14';
			package: 'Moose-Tests-Algos-Clustering' with: 'Moose-Tests-Algos-Clustering-AndreHora.4';
			package: 'Moose-Algos-Kontractor' with: 'Moose-Algos-Kontractor-LeoPerard.4';
			package: 'Moose-Tests-Algos-Kontractor' with: 'Moose-Tests-Algos-Kontractor-TudorGirba.5';
			package: 'Moose-Algos-GraphObjectTraverser' with: 'Moose-Algos-GraphObjectTraverser-TudorGirba.6';
			package: 'CollectionExtensions' with: 'CollectionExtensions-TudorGirba.42'. ].

]
