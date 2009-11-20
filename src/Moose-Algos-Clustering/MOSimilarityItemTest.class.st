"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MOSimilarityItemTest,
	#superclass : #TestCase,
	#category : #'Moose-Algos-Clustering'
}

{ #category : #'As yet unclassified' }
MOSimilarityItemTest >> testDistance [
	
	| a b c elements engine clusters |
	a := MOVectorItem with: #a and: #(1 0).
	b := MOVectorItem with: #b and: #(0 1).
	c := MOVectorItem with: #c and: #(0 7).
	elements := Array with: a with: b with: c.
	engine := MOClusterEngine with: elements.
	engine hierarchicalClusteringUsing: #averageLinkage.
	clusters := engine dendrogram breakInto: 2.
	self assert: clusters size = 2.
	self assert: (clusters select: [:each | each size = 1]) size = 1.
	self assert: (clusters select: [:each | each size = 2]) size = 1.
	self
		assert: ((clusters select: [:each | each size = 1]) first includes: c).
	self
		assert: ((clusters select: [:each | each size = 2]) first includes: a).
	self
		assert: ((clusters select: [:each | each size = 2]) first includes: b)
]

{ #category : #'As yet unclassified' }
MOSimilarityItemTest >> testSimilarity [
	
	| a b c elements engine clusters |
	a := MOSimilarityItem with: #a and: #(1 0).
	b := MOSimilarityItem with: #b and: #(0 1).
	c := MOSimilarityItem with: #c and: #(0 7).
	elements := Array with: a with: b with: c.
	engine := MOClusterEngine with: elements.
	engine hierarchicalClusteringUsing: #averageLinkage.
	clusters := engine dendrogram breakInto: 2.
	self assert: clusters size = 2.
	self assert: (clusters select: [:each | each size = 1]) size = 1.
	self assert: (clusters select: [:each | each size = 2]) size = 1.
	self
		assert: ((clusters select: [:each | each size = 1]) first includes: a).
	self
		assert: ((clusters select: [:each | each size = 2]) first includes: b).
	self
		assert: ((clusters select: [:each | each size = 2]) first includes: c)
]
