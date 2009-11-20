"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MODendrogramTest,
	#superclass : #TestCase,
	#instVars : [
		'dendrogram'
	],
	#category : #'Moose-Algos-Clustering'
}

{ #category : #fixture }
MODendrogramTest >> setUp [
	
	| ab cd ef abcd efg |
	ab := (MODendrogram with: #a)
		merge: (MODendrogram with: #b)
		at: 1.
	cd := (MODendrogram with: #c)
		merge: (MODendrogram with: #d)
		at: 2.
	ef := (MODendrogram with: #e)
		merge: (MODendrogram with: #f)
		at: 3.
	abcd := ab merge: cd at: 4.
	efg := ef
		merge: (MODendrogram with: #g)
		at: 5.
	dendrogram := abcd merge: efg at: 7	"#(((a 1 b) 4 (c 2 d)) 7 ((e 3 f) 5 g))"
]

{ #category : #test }
MODendrogramTest >> testAllLeaves [
	
	self assert: dendrogram elements size = 7.
	self assert: (dendrogram elements equalsTo: #(#a #b #c #d #e #f #g))
]

{ #category : #test }
MODendrogramTest >> testIndex [
	
	self assert: dendrogram index = 1.
	self assert: dendrogram left index = 1.
	self assert: dendrogram right index = 5.
	self assert: dendrogram left left index = 1.
	self assert: dendrogram left right index = 3.
	self assert: dendrogram right left index = 5.
	self assert: dendrogram right right index = 7
]

{ #category : #test }
MODendrogramTest >> testSize [
	
	self assert: dendrogram size = 7.
	self assert: dendrogram left size = 4.
	self assert: dendrogram right size = 3.
	self assert: dendrogram left left size = 2.
	self assert: dendrogram left right size = 2.
	self assert: dendrogram right left size = 2.
	self assert: dendrogram right right size = 1
]
