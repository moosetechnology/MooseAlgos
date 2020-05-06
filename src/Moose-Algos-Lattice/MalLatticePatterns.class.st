"
The class implements the identification of patterns in FCA lattices. We can detect like horizontal decomposition with the algos in the class.

| data fca context lattice |
	data := #(#(#Cat #(#fourlegs #hair)) #(#Dog #(#smart #fourlegs #hair)) #(#Dolphin #(#smart #marine)) #(#Gibbon #(#hair #smart #thumbed)) #(#Man #(#smart #thumbed)) #(#Whale #(#smart #marine))).
	fca := MalFormalContext new.
	context := fca with: data using: #first using: #last.
	(MalLatticePatterns on: (MalLattice on: context)) reportPatterns

For moose models
	
|fca model treillis context|
model := (MooseModel root allModels) second.
fca := MalFormalContext new.
context := fca with: (model allModelClasses) using: #yourself using: [:cl | cl methods collect: [:m | m name]].
treillis := (MalLattice on: context).
Transcript clear.
(MalLatticePatterns on: treillis) reportPatterns.
(MalLattice new viewLattice: treillis).


Smalltalk collection class hierarchy:

|fca model treillis context|
treillis := (MalLattice on: MalFormalContext classHierarchyCollection).
(MalLatticePatterns on: treillis) reportModules.
"
Class {
	#name : #MalLatticePatterns,
	#superclass : #Object,
	#instVars : [
		'lattice'
	],
	#category : #'Moose-Algos-Lattice'
}

{ #category : #'instance creation' }
MalLatticePatterns class >> on: aLattice [
	^ self new
		lattice: aLattice;
		yourself
]

{ #category : #complex }
MalLatticePatterns >> IsHorizontalDecomposition [
	self deprecated: 'Use #isHorizontalDecomposition instead' transformWith: '`@receiver IsHorizontalDecomposition' -> '`@receiver isHorizontalDecomposition'.
	self isHorizontalDecomposition
]

{ #category : #complex }
MalLatticePatterns >> IsSubConceptSpecialization: arg [
	self deprecated: 'Use #isSubConceptSpecialization: instead' transformWith: '`@receiver IsSubConceptSpecialization: `@statements' -> '`@receiver isSubConceptSpecialization: `@statements'.
	self isSubConceptSpecialization: arg
]

{ #category : #complex }
MalLatticePatterns >> IsSuperConceptSpecialization: arg [
	self deprecated: 'Use #isSuperConceptSpecialization: instead' transformWith: '`@receiver IsSuperConceptSpecialization: `@statements' -> '`@receiver isSuperConceptSpecialization: `@statements'.
	self isSuperConceptSpecialization: arg
]

{ #category : #nodes }
MalLatticePatterns >> black [
	^ lattice nodes select: [ :aNode | aNode labels first isEmpty and: [ aNode labels last isNotEmpty ] ]
]

{ #category : #nodes }
MalLatticePatterns >> empty [
	^ lattice nodes select: [ :aNode | aNode labels first isEmpty and: [ aNode labels second isEmpty ] ]
]

{ #category : #nodes }
MalLatticePatterns >> full [
	^lattice nodes select:[:aNode | aNode labels first size ~= 0 and: [ aNode labels second size ~= 0]]
]

{ #category : #nodes }
MalLatticePatterns >> grey [
	^ lattice nodes select: [ :aNode | aNode labels first isNotEmpty and: [ aNode labels second isEmpty ] ]
]

{ #category : #complex }
MalLatticePatterns >> hDNodeSize [
	"we still do not know how to compute the number of nodes in the horizontal decomposition. This method was a first effort but does not return the correct results."

	| nodes hdNodes totalNodes |
	totalNodes := 0.
	hdNodes := OrderedCollection new.
	nodes := self lattice top descendants.
	nodes
		do: [ :node | 
			| currentNode nodeTemp |
			currentNode := node.
			nodeTemp := nodes
				flatCollect: [ :aNode | 
					aNode ~= currentNode
						ifTrue: [ aNode allDescendants: self lattice bottom ]
						ifFalse: [ #() ] ].
			(nodeTemp anySatisfy: [ :each | (currentNode allDescendants: self lattice bottom) includes: each ])
				ifFalse: [ (hdNodes includes: currentNode)
						ifFalse: [ hdNodes add: currentNode.
							totalNodes := totalNodes + (currentNode allDescendants: self lattice bottom) size ] ] ].
	^ totalNodes
]

{ #category : #complex }
MalLatticePatterns >> horizontalDecomposition [
	"computes the horizontal decompositon of a lattice by looking at the descendants of the top node. From those descendants (first level nodes in the lattice), it sees that two nodes do not have overlapping descendants)"

	| nodes sum hdNodes |
	sum := 0.
	hdNodes := OrderedCollection new.
	nodes := self lattice top descendants.
	nodes
		do: [ :node | 
			| currentNode nodeTemp |
			currentNode := node.
			nodeTemp := nodes
				flatCollect: [ :aNode | 
					aNode ~= currentNode
						ifTrue: [ aNode allDescendants: self lattice bottom ]
						ifFalse: [ #() ] ].
			(nodeTemp anySatisfy: [ :each | (currentNode allDescendants: self lattice bottom) includes: each ])
				ifFalse: [ (hdNodes includes: currentNode)
						ifFalse: [ sum := sum + 1.
							hdNodes add: currentNode ] ] ].
	^ sum
]

{ #category : #complex }
MalLatticePatterns >> irreducibleSpecialization [
	| dict |
	dict := Dictionary new.
	self lattice nodes
		do: [ :aNode | 
			(self isSuperConceptSpecialization: aNode)
				ifTrue: [ aNode descendants
						do: [ :aDes | 
							(self isSubConceptSpecialization: aDes)
								ifTrue: [ dict at: aNode put: aDes ] ] ] ].
	^ dict
]

{ #category : #nodes }
MalLatticePatterns >> isBlack: aNode [
	^self black includes: aNode
]

{ #category : #bottom }
MalLatticePatterns >> isBottomBlack [
	^self black includes: self lattice bottom
]

{ #category : #bottom }
MalLatticePatterns >> isBottomFull [
	^self full includes: self lattice bottom
]

{ #category : #bottom }
MalLatticePatterns >> isBottomGrey [
	^self grey includes: self lattice top
]

{ #category : #bottom }
MalLatticePatterns >> isBottomPattern [
	 (self isBottomBlack) ifTrue: [^ 'Bottom Black']. 
	(self isBottomFull)  ifTrue: [^ 'Bottom Full'].
	self isBottomGrey  ifTrue: [^ 'Bottom Grey'].
	^'None'
]

{ #category : #nodes }
MalLatticePatterns >> isEmpty: aNode [
	^self empty includes: aNode
]

{ #category : #nodes }
MalLatticePatterns >> isFull: aNode [
	^self full includes: aNode
]

{ #category : #nodes }
MalLatticePatterns >> isGrey: aNode [
	^self grey includes: aNode
]

{ #category : #complex }
MalLatticePatterns >> isHorizontalDecomposition [
	| nodes |
	nodes := self lattice top descendants.
	1 to: nodes size - 1 do: [ :n | 
		n + 1 to: nodes size do: [ :m | 
			((nodes at: n) hasDescendant: (nodes at: m))
				ifFalse: [ (((nodes at: n) allDescendants: self lattice bottom) anySatisfy: [ :each | ((nodes at: m) allDescendants: self lattice bottom) includes: each ])
						ifFalse: [ ^ true ] ] ] ].
	^ false
]

{ #category : #complex }
MalLatticePatterns >> isSubConceptSpecialization: aNode [
	^ (self lattice bottom = aNode and: [ self isFull: aNode ]) or: [ (self isGrey: aNode) or: [ self isFull: aNode ] ]
]

{ #category : #complex }
MalLatticePatterns >> isSuperConceptSpecialization: aNode [
	^ (self lattice top = aNode and: [ self isFull: aNode ]) or: [ (self isBlack: aNode) or: [ self isFull: aNode ] ]
]

{ #category : #top }
MalLatticePatterns >> isTopBlack [
	^self black includes: self lattice top
]

{ #category : #top }
MalLatticePatterns >> isTopFull [
	^self full includes: self lattice top
]

{ #category : #top }
MalLatticePatterns >> isTopGrey [
	^self grey includes: self lattice top
]

{ #category : #top }
MalLatticePatterns >> isTopPattern [
	self isTopBlack ifTrue: [^ 'Top Black']. 
	(self isTopFull)  ifTrue: [^ 'Top Full'].
	self isTopGrey  ifTrue: [^ 'Top Grey'].
	^'None'
	
]

{ #category : #accessors }
MalLatticePatterns >> lattice [
	^lattice
]

{ #category : #accessors }
MalLatticePatterns >> lattice: aLattice [
	lattice := aLattice.
]

{ #category : #report }
MalLatticePatterns >> printModulesReport [
	| modules nodes |
	modules := ModuleIdentification on: self lattice.
	nodes := modules flatten asSet.
	self
		trace: 'Number of modules ';
		traceCr: modules size printString;
		trace: 'Number of Nodes in modules ';
		traceCr: nodes size printString
]

{ #category : #report }
MalLatticePatterns >> reportPatterns [
	self
		trace: '# of nodes: ';
		traceCr: self lattice nodes size printString;
		trace: 'Connections ';
		traceCr: self totalConnections printString;
		trace: 'Top ';
		traceCr: self isTopPattern printString;
		trace: 'Bottom ';
		traceCr: self isBottomPattern printString;
		trace: 'Specialization ';
		traceCr: self irreducibleSpecialization keys size printString;
		trace: 'Specialization ';
		traceCr: self irreducibleSpecialization values size printString;
		trace: 'Horizontal Decomposition ';
		traceCr: self horizontalDecomposition printString;
		trace: 'Horizontal Decomposition Size ';
		traceCr: self hDNodeSize printString;
		printModulesReport
]

{ #category : #complex }
MalLatticePatterns >> totalConnections [
	^(self lattice nodes flatCollect: [:aNode | aNode descendants]) size
]
