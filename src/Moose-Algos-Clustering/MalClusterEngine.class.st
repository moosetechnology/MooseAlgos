"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MalClusterEngine,
	#superclass : #Object,
	#instVars : [
		'distanceMatrix',
		'dendrogram'
	],
	#category : #'Moose-Algos-Clustering'
}

{ #category : #examples }
MalClusterEngine class >> numbers: aCollection [
	"ClusterEngine numbers: #(1 2 9 0 7 2 4 3)"
	
	^(MalClusterEngine
		with: aCollection
		using: [:a :b | (a - b) * (a - b)]) averageLinkage elements
]

{ #category : #'instance creation' }
MalClusterEngine class >> with: aCollection [
	
	^self withDistanceMatrix: (MalDistanceSquare on: aCollection)
]

{ #category : #'instance creation' }
MalClusterEngine class >> with: aCollection using: aDistanceBlock [
	
	^self
		withDistanceMatrix:
			(MalDistanceSquare on: aCollection using: aDistanceBlock)
]

{ #category : #'instance creation' }
MalClusterEngine class >> withDistanceMatrix: distanceMatrix [
	
	^(self new)
		instVarNamed: 'distanceMatrix' put: distanceMatrix;
		yourself
]

{ #category : #clustering }
MalClusterEngine >> averageLinkage [
	
	^self performClustering: #averageLinkage
]

{ #category : #clustering }
MalClusterEngine >> completeLinkage [
	
	^self performClustering: #completeLinkage
]

{ #category : #accessing }
MalClusterEngine >> dendrogram [
	
	^dendrogram ifNil: [dendrogram := self averageLinkage]
]

{ #category : #'private - deprecated' }
MalClusterEngine >> hierarchicalClusteringShowProgressUsing: selector [
	
	^self performClusteringShowProgress: selector
]

{ #category : #'private - deprecated' }
MalClusterEngine >> hierarchicalClusteringUsing: selector [
	
	^self performClustering: selector
]

{ #category : #accessing }
MalClusterEngine >> items [
	
	^distanceMatrix items
]

{ #category : #clustering }
MalClusterEngine >> performClustering: linkageSelector [
	
	| data |
	data := MalClusteringData onDistanceSquare: distanceMatrix.
	data performClustering: linkageSelector.
	^dendrogram := data dendrogram
]

{ #category : #clustering }
MalClusterEngine >> performClusteringShowProgress: linkageSelector [
	
	MooseCustomTask
		runWithProgress:[self performClustering: linkageSelector]
		description:('Clustering <1p> items, please wait.'
				expandMacrosWith: distanceMatrix columnSize)
		length: ( distanceMatrix columnSize * (distanceMatrix columnSize - 1) / 2)
]

{ #category : #clustering }
MalClusterEngine >> singleLinkage [
	
	^self performClustering: #singleLinkage
]