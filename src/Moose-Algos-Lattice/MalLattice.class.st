"
MalLattice new displayLattice: MalFormalContext mammals2.
MalLattice on: MalFormalContext mammals2.

MalLattice new viewLattice: (MalLattice on: MalFormalContext mammals2)

"
Class {
	#name : #MalLattice,
	#superclass : #MalGraphAlgorithm,
	#instVars : [
		'layers'
	],
	#category : #'Moose-Algos-Lattice'
}

{ #category : #'instance creation' }
MalLattice class >> on: formalContext [
	| lattice |
	lattice := MalLattice new.
	^lattice onConstruct: formalContext
]

{ #category : #accessing }
MalLattice >> addNode: aNode [
	self findNode: aNode ifAbsent: (self nodes add: aNode)
]

{ #category : #enumerating }
MalLattice >> bottom [
	"Any node without descendants, and which is not a top is a bottom"
	self nodes do: [:node | (node descendants isEmpty and: [node ~= self top]) ifTrue: [^node]].
]

{ #category : #construction }
MalLattice >> connectBottom [
	|bottom childLess|
	bottom := self orphans select: [:node | (node ~= self top)].
	self nodes do: [:node | (node descendants isEmpty and: [node ~= bottom]) ifTrue: [node addDescendant: (bottom asArray first)]].
	childLess := self nodes select: [:node | node descendants isEmpty.].
]

{ #category : #accessing }
MalLattice >> filterDescendants [
	"if I have a descendant that also appears as a descendant in my descendants, remove it from the set of my descendants"
	|dict myDesc mygrandDesc|
	
	self nodes do: [:node | node descendants do:[:desc | (desc descendants intersection: (node descendants)) ifNotEmptyDo: [:intersect | node removeDescendant: (intersect asArray)]]] 
]

{ #category : #construction }
MalLattice >> onConstruct: formalContext [
	formalContext concepts
		do: [:each | self addNode: (MalLatticeNode withNew: each)].
		layers := ((self nodes asArray groupedBy: #layer) associations sort: [ :a :b | a key < b key]) collect: #value.
		layers size - 1 to: 1 by: -1 do: [ :n |
		n + 1 to: layers size -1 do: [ :m |
			(layers at: n) do: [ :each |
				(layers at: m) do: [ :child |
					each maybeAppendChild: child ]]]].
	self filterDescendants.
	self connectBottom.
	
]

{ #category : #enumerating }
MalLattice >> orphans [
	|allNodes diff nonEmptyDescendants nonOrphans|
	nonOrphans := OrderedCollection new.
	allNodes := (self nodes) asSet.
	nonEmptyDescendants := self nodes select: [:node | (node descendants isEmpty not)].
	nonOrphans := (nonEmptyDescendants flatCollect: [: each | each descendants]) asSet.
	diff := allNodes difference:  nonOrphans.
	^diff.
]

{ #category : #enumerating }
MalLattice >> top [
	self nodes do: [: node | node concept intent = 0 ifTrue: [^node]]
]
