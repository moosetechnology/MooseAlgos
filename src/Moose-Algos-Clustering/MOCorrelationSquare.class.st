"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MOCorrelationSquare,
	#superclass : #MODistanceSquare,
	#category : #'Moose-Algos-Clustering'
}

{ #category : #constants }
MOCorrelationSquare class >> defaultDistanceBlock [
	
	^[:a :b | a similarity: b]
]

{ #category : #private }
MOCorrelationSquare class >> vectorSpecies [
	
	^MOCorrelationVector
]

{ #category : #private }
MOCorrelationSquare >> copyClusteringData [
	
	^partialColumns collect: [:each | each negated]
]
