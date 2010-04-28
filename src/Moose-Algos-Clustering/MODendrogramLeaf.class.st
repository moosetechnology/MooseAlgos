"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MODendrogramLeaf,
	#superclass : #MODendrogram,
	#instVars : [
		'element'
	],
	#category : #'Moose-Algos-Clustering'
}

{ #category : #'instance creation' }
MODendrogramLeaf class >> with: anElement [
	
	^(self new)
		instVarNamed: 'element' put: anElement;
		yourself
]

{ #category : #accessing }
MODendrogramLeaf >> element [
	
	^element
]

{ #category : #enumerating }
MODendrogramLeaf >> elementsDo: aBlock [
	
	aBlock value: element
]

{ #category : #enumerating }
MODendrogramLeaf >> leavesDo: aBlock [
	
	aBlock value: self
]

{ #category : #accessing }
MODendrogramLeaf >> left [
	
	^self
]

{ #category : #enumerating }
MODendrogramLeaf >> nodesDo: aBlock [
	"does nothing"
	
	
]

{ #category : #seriation }
MODendrogramLeaf >> orderLeafs [
	"do nothing"
	
	
]

{ #category : #accessing }
MODendrogramLeaf >> right [
	
	^self
]

{ #category : #accessing }
MODendrogramLeaf >> size [
	
	^1
]

{ #category : #seriation }
MODendrogramLeaf >> swap [
	"does nothing"
	
	
]

{ #category : #accessing }
MODendrogramLeaf >> threshold [
	
	^ Number zero
]
