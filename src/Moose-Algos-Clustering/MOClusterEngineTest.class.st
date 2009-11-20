"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MOClusterEngineTest,
	#superclass : #TestCase,
	#category : #'Moose-Algos-Clustering'
}

{ #category : #testing }
MOClusterEngineTest >> testCentroid [
	
	| input clusty clusters |
	input := #(#(1 2 3 5) #(11 12 15) #(21 22 23 25) #(31 32 35) #(41 42 43 45 47)).
	clusty := MOClusterEngine with: input flatten shuffle.
	clusty hierarchicalClusteringUsing: #centroid.
	clusters := clusty dendrogram breakInto: 5.
	self assert: clusters size = 5.
	self assert: (clusters contains: [:each | each equalsTo: (input at: 1)]).
	self assert: (clusters contains: [:each | each equalsTo: (input at: 2)]).
	self assert: (clusters contains: [:each | each equalsTo: (input at: 3)]).
	self assert: (clusters contains: [:each | each equalsTo: (input at: 4)]).
	self assert: (clusters contains: [:each | each equalsTo: (input at: 5)]).
	^clusters
]

{ #category : #testing }
MOClusterEngineTest >> testClustering [
	
	| input clusty clusters |
	input := #(#(1 2 3 5) #(11 12 15) #(21 22 23 25) #(31 32 35) #(41 42 43 45 47)).
	clusty := MOClusterEngine with: input flatten shuffle.
	clusty hierarchicalClusteringUsing: #averageLinkage.
	clusters := clusty dendrogram breakInto: 5.
	self assert: clusters size = 5.
	self assert: (clusters contains: [:each | each equalsTo: (input at: 1)]).
	self assert: (clusters contains: [:each | each equalsTo: (input at: 2)]).
	self assert: (clusters contains: [:each | each equalsTo: (input at: 3)]).
	self assert: (clusters contains: [:each | each equalsTo: (input at: 4)]).
	self assert: (clusters contains: [:each | each equalsTo: (input at: 5)]).
	^clusters
]

{ #category : #testing }
MOClusterEngineTest >> testClustering2 [
	
	| input clusty clusters |
	input := #(#(1 2 3 5) #(11 12 15) #(21 22 23 25) #(31 32 35) #(41 42 43 45 47)).
	clusty := MOClusterEngine with: input flatten shuffle.
	clusty hierarchicalClusteringUsing: #centroid.
	clusters := clusty dendrogram breakInto: 5.
	self assert: clusters size = 5.
	self assert: (clusters contains: [:each | each equalsTo: (input at: 1)]).
	self assert: (clusters contains: [:each | each equalsTo: (input at: 2)]).
	self assert: (clusters contains: [:each | each equalsTo: (input at: 3)]).
	self assert: (clusters contains: [:each | each equalsTo: (input at: 4)]).
	self assert: (clusters contains: [:each | each equalsTo: (input at: 5)]).
	^clusters
]

{ #category : #testing }
MOClusterEngineTest >> testClustering300Elements [
	
	| input clusty clusters |
	input := MORandom new next: 300.
	clusty := MOClusterEngine with: input.
	1
		to: 1
		do: [:n | clusty averageLinkage].
	clusters := clusty dendrogram breakInto: 10.
	^clusters
]

{ #category : #testing }
MOClusterEngineTest >> testClusteringOptimization [
	
	| input clusty |
	input := MORandom new next: 200.
	clusty := MOClusteringData onDistanceSquare: (MODistanceSquare on: input).	"internally compares the optimzed and the unoptimized code."
	clusty testPerformClustering: #averageLinkage
]

{ #category : #testing }
MOClusterEngineTest >> testSeriationEngine [
	
	| input output |
	input := #(1 2 3 5 11 12 15 21 22 23 25 31 32 35 41 42 43 45 47).
	output := MOSeriationEngine applyOn: input asArray shuffle.
	self assert: output = input | (output reverse = input)
]

{ #category : #testing }
MOClusterEngineTest >> testWardsMethod [
	
	| input clusty clusters |
	input := #(#(1 2 3 5) #(11 12 15) #(21 22 23 25) #(31 32 35) #(41 42 43 45 47)).
	clusty := MOClusterEngine with: input flatten shuffle.
	clusty hierarchicalClusteringUsing: #wardsMethod.
	clusters := clusty dendrogram breakInto: 5.
	self assert: clusters size = 5.
	self assert: (clusters contains: [:each | each equalsTo: (input at: 1)]).
	self assert: (clusters contains: [:each | each equalsTo: (input at: 2)]).
	self assert: (clusters contains: [:each | each equalsTo: (input at: 3)]).
	self assert: (clusters contains: [:each | each equalsTo: (input at: 4)]).
	self assert: (clusters contains: [:each | each equalsTo: (input at: 5)]).
	^clusters
]
