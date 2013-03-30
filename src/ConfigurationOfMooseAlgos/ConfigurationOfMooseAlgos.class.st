Class {
	#name : #ConfigurationOfMooseAlgos,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#category : #ConfigurationOfMooseAlgos
}

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

{ #category : #'symbolic versions' }
ConfigurationOfMooseAlgos >> development: spec [ 
	<symbolicVersion: 'development'>
	
	spec for: #common version: '2.4-baseline'
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

{ #category : #'symbolic versions' }
ConfigurationOfMooseAlgos >> stable: spec [
	<symbolicVersion: #'stable'>

	spec for: #'pharo1.4.x' version: '2.3'.
	spec for: #'pharo2.x' version: '2.3'.

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
