"
MalLattice new displayLattice: MalFormalContext mammals2.
MalLattice on: MalFormalContext mammals2.

MalLattice new displayLattice: (MalLattice onFormalContext: MalFormalContext mammals2)

"
Class {
	#name : #MalLattice,
	#superclass : #MONode,
	#instVars : [
		'layers'
	],
	#category : #'Moose-Algos-FormalConceptAnalysis'
}

{ #category : #'instance creation' }
MalLattice class >> onFormalContext: formalContext [
	| lattice |
	lattice := MalLattice on: 'me'.
	^lattice onConstruct: formalContext
]

{ #category : #accessing }
MalLattice >> bottom [
	"Any node without ancestors and which is not a top is a bottom"
	self nodes do: [:node | (node descendants isEmpty and: [node ~= self top]) ifTrue: [^node]].
]

{ #category : #displaying }
MalLattice >> displayLattice: aLattice [
	| view |
	view := MOViewRenderer new.
	view shape:
			(MORectangleShape new size: 5).
	view nodes: aLattice nodes.
	view shape: MOStraightLineShape new.
	view edgesToAll:  #descendants.
	view narrowTreeLayout.
	
	^ view open
]

{ #category : #accessing }
MalLattice >> ensureSingleBottom [
	|bottom childLess|
	bottom := self orphans select: [:node | (node ~= self top)].
	self nodes do: [:node | (node descendants isEmpty and: [node ~= bottom]) ifTrue: [node addDescendant: (bottom asArray first)]].
	childLess := self nodes select: [:node | node descendants isEmpty.].
]

{ #category : #displaying }
MalLattice >> ensureTop [
	
	
	self nodes do: [:node | (node ~= self bottom and: [node ~= self top]) and: [node descendants isEmpty ifTrue: [node addDescendant: self top ]  ]].
]

{ #category : #displaying }
MalLattice >> ensureTopBottom [ 
	"This method treats top and bottom separate from other nodes. There was a bug in the port as all nodes were connected
	to top and bottom and therefore this part has been reworked in Moose to create lattices"
	"All those that do not have ancestors should connect to bottom"
	"All those that figure in other nodes's ancestors should connect to top"
	self nodes do: [:node | (node ~= self bottom and: [node ~= self top]) and: [node descendants isEmpty ifTrue: [node addDescendant: self top ]  ]].
	
	self orphans do: [:node | (node ~= self top and: [node ~= self bottom]) ifTrue: [self bottom addDescendant: node ]  ]. 
]

{ #category : #'as yet unclassified' }
MalLattice >> filterDescendants [
	"if I have a descendant that also appears as a descendant in my descendants, remove it from the set of my descendants"
	|dict myDesc mygrandDesc|
	
	self nodes do: [:node | node descendants do:[:desc | (desc descendants intersection: (node descendants)) ifNotEmptyDo: [:intersect | node removeDescendant: (intersect asArray)]]] 
]

{ #category : #displaying }
MalLattice >> onConstruct: formalContext [
	
	formalContext concepts
		collect: [:each | self addNode: (MalLatticeNode withNew: each)].
		layers := ((self nodes asArray groupedBy: #layer) associations sort: [ :a :b | a key < b key]) collect: #value.
		layers size - 1 to: 1 by: -1 do: [ :n |
		n + 1 to: layers size -1 do: [ :m |
			(layers at: n) do: [ :each |
				(layers at: m) do: [ :child |
					each maybeAppendChild: child ]]]].
	self filterDescendants.
	self ensureSingleBottom.
	
]

{ #category : #accessing }
MalLattice >> orphans [
	|allNodes diff nonEmptyDescendants nonOrphans|
	nonOrphans := OrderedCollection new.
	allNodes := (self nodes) asSet.
	nonEmptyDescendants := self nodes select: [:node | (node descendants isEmpty not)].
	nonOrphans := (nonEmptyDescendants flatCollect: [: each | each descendants]) asSet.
	diff := allNodes difference:  nonOrphans.
	^diff.
]

{ #category : #accessing }
MalLattice >> top [
	self nodes do: [: node | node concept intent = 0 ifTrue: [^node]]
]
