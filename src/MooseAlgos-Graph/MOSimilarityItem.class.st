"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MOSimilarityItem,
	#superclass : #MOVectorItem,
	#category : #'MooseAlgos-Clustering'
}

{ #category : #'distance functions' }
MOSimilarityItem >> dist: anItem [
	
	^1 - (self vector cosine: anItem vector)
]

{ #category : #'distance functions' }
MOSimilarityItem >> similarity: anItem [
	
	^self vector cosine: anItem vector
]
