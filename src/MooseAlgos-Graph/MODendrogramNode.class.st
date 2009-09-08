"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MODendrogramNode,
	#superclass : #MODendrogram,
	#instVars : [
		'left',
		'right',
		'threshold'
	],
	#category : #'MooseAlgos-Clustering'
}

{ #category : #'instance creation' }
MODendrogramNode class >> with: left with: right at: threshold [
	
	| new |
	new := (self new)
		instVarNamed: 'left' put: left;
		instVarNamed: 'right' put: right;
		instVarNamed: 'threshold' put: threshold;
		yourself.
	left instVarNamed: 'parent' put: new.
	right instVarNamed: 'parent' put: new.
	^new
]

{ #category : #enumerating }
MODendrogramNode >> elementsDo: aBlock [
	
	left elementsDo: aBlock.
	right elementsDo: aBlock
]

{ #category : #enumerating }
MODendrogramNode >> leavesDo: aBlock [
	
	left leavesDo: aBlock.
	right leavesDo: aBlock
]

{ #category : #accessing }
MODendrogramNode >> left [
	
	^left
]

{ #category : #enumerating }
MODendrogramNode >> nodesDo: aBlock [
	
	aBlock value: self.
	left nodesDo: aBlock.
	right nodesDo: aBlock
]

{ #category : #seriation }
MODendrogramNode >> orderLeafs [
	
	| a b c d array |
	a := self left left.
	b := self left right.
	c := self right left.
	d := self right right.
	array := Array
		with: (a dist: c) -> [self left swap]
		with:
			(a dist: d)
				->
					[self left swap.
					self right swap]
		with: (b dist: c) -> []
		with: (b dist: d) -> [self right swap].
	(array sorted: #key asSortBlock) first value value.
	self left orderLeafs.
	self right orderLeafs
]

{ #category : #accessing }
MODendrogramNode >> right [
	
	^right
]

{ #category : #accessing }
MODendrogramNode >> size [
	
	^left size + right size
]

{ #category : #seriation }
MODendrogramNode >> swap [
	
	| swap |
	swap := left.
	left := right.
	right := swap
]

{ #category : #accessing }
MODendrogramNode >> threshold [
	
	^threshold
]
