"
MalLattice new displayLattice: MalFormalContext mammals2.
MalLattice on: MalFormalContext mammals2.

MalLattice new displayLattice: (MalLattice onFormalContext: MalFormalContext mammals2)

"
Class {
	#name : #MalLattice,
	#superclass : #Object,
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
	self nodes do: [: node | node concept extent = 0 ifTrue: [^node]]
]

{ #category : #displaying }
MalLattice >> displayLattice: aLattice [
	| view |
	view := MOViewRenderer new.
	view shape:
			(MORectangleShape new size: 40).
	view nodes: aLattice nodes.
	view shape: MOArrowedLineShape new.
	view edgesToAll:  #descendants.
	view narrowTreeLayout.
	
	^ view open
]

{ #category : #displaying }
MalLattice >> ensureTopBottom [ 
	"This method treats top and bottom separate from other nodes. There was a bug in the port as all nodes were connected
	to top and bottom and therefore this part has been reworked in Moose to create lattices"
	"All those that do not have ancestors should connect to bottom"
	"All those that figure in other nodes's ancestors should connect to top"
	self nodes do: [:node | (node ~= self top and: [node ~= self bottom]) and: [node descendants isNil ifTrue: [node addDescendant: self bottom ]  ]].
	
	self nodesWithoutDescendants do: [:node | (node ~= self top and: [node ~= self bottom]) ifTrue: [self top addDescendant: node ]  ].
	
]

{ #category : #accessing }
MalLattice >> nodesWithoutDescendants [
	|firstLevelNodes allNodes diff inAncestors withAncestors|
	withAncestors := OrderedCollection new.
	allNodes := (self nodes) asSet.
	inAncestors := self nodes select: [:node | (node descendants isNil not)].
	withAncestors := (inAncestors flatCollect: [: each | each descendants]) asSet.
	diff := allNodes difference:  withAncestors.
	^diff. 
]

{ #category : #displaying }
MalLattice >> onConstruct: formalContext [
	
	formalContext concepts
		collect: [:each | self addNode: (MalLatticeNode withNew: each)].
		layers := ((self nodes asArray groupedBy: #layer) associations sort: [ :a :b | a key < b key]) collect: #value.
		layers size - 2 to: 2 by: -1 do: [ :n |
		n + 1 to: layers size -1 do: [ :m |
			(layers at: n) do: [ :each |
				(layers at: m) do: [ :child |
					each maybeAppendChild: child ]]]].
	self ensureTopBottom
]

{ #category : #accessing }
MalLattice >> top [
	self nodes do: [: node | node concept intent = 0 ifTrue: [^node]]
]
