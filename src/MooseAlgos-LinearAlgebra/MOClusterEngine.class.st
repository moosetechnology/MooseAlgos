"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MOClusterEngine,
	#superclass : #Object,
	#instVars : [
		'distanceMatrix',
		'dendrogram'
	],
	#category : #'MooseAlgos-Clustering'
}

{ #category : #examples }
MOClusterEngine class >> numbers: aCollection [
	"ClusterEngine numbers: #(1 2 9 0 7 2 4 3)"
	
	^(MOClusterEngine
		with: aCollection
		using: [:a :b | (a - b) * (a - b)]) averageLinkage elements
]

{ #category : #'instance creation' }
MOClusterEngine class >> with: aCollection [
	
	^self withDistanceMatrix: (MODistanceSquare on: aCollection)
]

{ #category : #'instance creation' }
MOClusterEngine class >> with: aCollection using: aDistanceBlock [
	
	^self
		withDistanceMatrix:
			(MODistanceSquare on: aCollection using: aDistanceBlock)
]

{ #category : #'instance creation' }
MOClusterEngine class >> withDistanceMatrix: distanceMatrix [
	
	^(self new)
		instVarNamed: 'distanceMatrix' put: distanceMatrix;
		yourself
]

{ #category : #clustering }
MOClusterEngine >> averageLinkage [
	
	^self performClustering: #averageLinkage
]

{ #category : #clustering }
MOClusterEngine >> completeLinkage [
	
	^self performClustering: #completeLinkage
]

{ #category : #accessing }
MOClusterEngine >> dendrogram [
	
	^dendrogram ifNil: [dendrogram := self averageLinkage]
]

{ #category : #'private - deprecated' }
MOClusterEngine >> hierarchicalClusteringShowProgressUsing: selector [
	
	^self performClusteringShowProgress: selector
]

{ #category : #'private - deprecated' }
MOClusterEngine >> hierarchicalClusteringUsing: selector [
	
	^self performClustering: selector
]

{ #category : #accessing }
MOClusterEngine >> items [
	
	^distanceMatrix items
]

{ #category : #clustering }
MOClusterEngine >> performClustering: linkageSelector [
	
	| data |
	data := MOClusteringData onDistanceSquare: distanceMatrix.
	data performClustering: linkageSelector.
	^dendrogram := data dendrogram
]

{ #category : #clustering }
MOClusterEngine >> performClusteringShowProgress: linkageSelector [
	
	Notice
		showProgress:
			('Clustering <1p> items, please wait.'
				expandMacrosWith: distanceMatrix columnSize)
		complete: distanceMatrix columnSize * (distanceMatrix columnSize - 1) / 2
		while: [self performClustering: linkageSelector]
		title: 'Clustering'	"IncrementNotification signalWith: numberOfTicks"
]

{ #category : #clustering }
MOClusterEngine >> singleLinkage [
	
	^self performClustering: #singleLinkage
]
