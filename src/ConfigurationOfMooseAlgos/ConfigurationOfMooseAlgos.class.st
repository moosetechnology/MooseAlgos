Class {
	#name : #ConfigurationOfMooseAlgos,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#category : #ConfigurationOfMooseAlgos
}

{ #category : #private }
ConfigurationOfMooseAlgos class >> bootstrapPackage: aString from: aPath [ 
	| repository version |
	repository := MCHttpRepository
				location: aPath
				user: ''
				password: ''.
	repository
		versionReaderForFileNamed: aString , '.mcz'
		do: [:reader | 
			version := reader version.
			version load.
			version workingCopy repositoryGroup addRepository: repository]
]

{ #category : #private }
ConfigurationOfMooseAlgos class >> ensureMetacello [
	"Minimum package versions from which to boot Metacello. Corresponds to version 1.0-beta.4"

	Smalltalk at: #MetacelloProject ifAbsent: [
		Smalltalk at: #Gofer ifAbsent: [
			"Minimum version of Gofer from which to bootstrap"
			self bootstrapPackage: 'Gofer-lr.67' from: 'http://source.lukas-renggli.ch/flair' ].
		Smalltalk at: #Gofer ifPresent: [:gofer |
			gofer new
				url: 'http://seaside.gemstone.com/ss/metacello';
				addVersion: 'Metacello-Core-dkh.273'; "Minimum version from which to bootstrap Metacello"
				addVersion: 'Metacello-MC-dkh.205'; "Minimum version from which to bootstrap Metacello"
				addPackage: 'Metacello-Configuration'; "Loads latest version of configuration package"
				load ].
		"load latest version of Metacello, load a specific version if desired"
		((Smalltalk at: #MetacelloConfiguration) project latestVersion) load: 'UI' ]
]

{ #category : #'metacello tool support' }
ConfigurationOfMooseAlgos class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #loading }
ConfigurationOfMooseAlgos class >> loadDefault [
	(self project version: 'default') load
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
ConfigurationOfMooseAlgos >> default: spec [ 
	<version: 'default'>
	
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
