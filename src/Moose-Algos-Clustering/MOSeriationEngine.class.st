"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MOSeriationEngine,
	#superclass : #Object,
	#instVars : [
		'elements'
	],
	#category : #'Moose-Algos-Clustering'
}

{ #category : #'instance creation' }
MOSeriationEngine class >> applyOn: elements [
	
	^(self with: elements) defaultAlgorithm
]

{ #category : #'instance creation' }
MOSeriationEngine class >> with: elements [
	
	^(self new)
		elements: elements;
		yourself
]

{ #category : #algorithm }
MOSeriationEngine >> defaultAlgorithm [
	
	^self orderDendrogramLeaves
]

{ #category : #accessing }
MOSeriationEngine >> elements [
	
	^elements
]

{ #category : #accessing }
MOSeriationEngine >> elements: anObject [
	
	elements := anObject
]

{ #category : #algorithm }
MOSeriationEngine >> orderDendrogramLeaves [
	
	| clusty |
	clusty := MOClusterEngine with: elements.
	clusty hierarchicalClusteringUsing: #averageLinkage.
	^clusty dendrogram orderLeafs asArray
]
