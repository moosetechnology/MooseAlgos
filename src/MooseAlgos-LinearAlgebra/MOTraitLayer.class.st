Class {
	#name : #MOTraitLayer,
	#superclass : #Object,
	#instVars : [
		'nodes',
		'edges',
		'layers'
	],
	#category : #'MooseAlgos-DependencyTable'
}

{ #category : #'as yet unclassified' }
MOTraitLayer >> addDependencies: aBehavior [

	nodes addAll: aBehavior traitComposition allTraits.
	aBehavior traitComposition allTraits do: [:t|
		edges add: {aBehavior. t} ]
]

{ #category : #'as yet unclassified' }
MOTraitLayer >> runOn: aClass [
	"take traitComposition from the class and add dependencies, recursively.
	 also perform on inheritance. Then run Hal to compute some layers. and finally render a layer table."
	
	nodes add: aClass.
	self addDependencies: aClass
]
