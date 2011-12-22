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

{ #category : #'as yet unclassified' }
MalLatticePatterns class >> on: aLattice [
	| patterns |
	patterns := MalLatticePatterns new.
	patterns lattice: aLattice.
	^patterns

]

{ #category : #complex }
MalLatticePatterns >> IsHorizontalDecomposition [
	
	| dict nodes |
	nodes := self lattice top descendants.
	1 to: (nodes size -1 ) 
		do: [:n | 	(n+1 to: (nodes size))
			do:[:m | ((nodes at:n) hasDescendant: (nodes at: m))
			ifFalse: 	[(((nodes at: n) allDescendants: self lattice bottom) anySatisfy: [:each | (((nodes at:m) allDescendants: self lattice bottom) includes: each)]) ifFalse: [^true]]]].
	^false.

]

{ #category : #complex }
MalLatticePatterns >> IsSubConceptSpecialization: aNode [
	(self lattice bottom = aNode) ifTrue: [(self isFull: aNode) ifTrue: [^true]].  
	((self isGrey: aNode) or: [self isFull: aNode]) ifTrue: [^true].
	
	^ false
]

{ #category : #complex }
MalLatticePatterns >> IsSuperConceptSpecialization: aNode [
	(self lattice top = aNode) ifTrue: [(self isFull: aNode) ifTrue: [^true] ifFalse: [^false]].  
	((self isBlack: aNode) or: [self isFull: aNode]) ifTrue: [^true] ifFalse: [^false] 
]

{ #category : #nodes }
MalLatticePatterns >> black [
	^lattice nodes select:[:aNode | aNode labels first size = 0 and: [ aNode labels last size ~= 0]]
]

{ #category : #nodes }
MalLatticePatterns >> empty [
	^lattice nodes select:[:aNode | aNode labels first size = 0 and: [ aNode labels second size = 0]]
]

{ #category : #nodes }
MalLatticePatterns >> full [
	^lattice nodes select:[:aNode | aNode labels first size ~= 0 and: [ aNode labels second size ~= 0]]
]

{ #category : #nodes }
MalLatticePatterns >> grey [
	^lattice nodes select:[:aNode | aNode labels first size ~= 0 and: [ aNode labels second size = 0]]
]

{ #category : #complex }
MalLatticePatterns >> hDNodeSize [
	
	| allDescendants nodes sum hdNodes totalNodes|
	totalNodes := 0.
	hdNodes := OrderedCollection new.
	nodes := self lattice top descendants.
	1 to: (nodes size) 
		do: [:n | 
			|currentNode nodeTemp |
			
			currentNode := nodes at: n.
			
			nodeTemp := nodes flatCollect: [:aNode | (aNode ~=currentNode) ifTrue: [aNode allDescendants: self lattice bottom ] ifFalse: [#()]].
			(nodeTemp anySatisfy: [ :each | 
				(currentNode allDescendants: self lattice bottom) includes: each])
				ifFalse: [(hdNodes includes: currentNode) ifFalse: [hdNodes add: currentNode. totalNodes := totalNodes + (currentNode allDescendants: self lattice bottom) size]]].
	^totalNodes.

]

{ #category : #complex }
MalLatticePatterns >> horizontalDecomposition [
	"computes the horizontal decompositon of a lattice by looking at the descendants of the top node. From those descendants (first level nodes in the lattice), it sees that two nodes do not have overlapping descendants)"
	
	| allDescendants nodes sum hdNodes totalNodes|
	sum := 0.
	totalNodes := 0.
	hdNodes := OrderedCollection new.
	nodes := self lattice top descendants.
	1 to: (nodes size) 
		do: [:n | 
			|currentNode nodeTemp |
			
			currentNode := nodes at: n.
			
			nodeTemp := nodes flatCollect: [:aNode | (aNode ~=currentNode) ifTrue: [aNode allDescendants: self lattice bottom ] ifFalse: [#()]].
			(nodeTemp anySatisfy: [ :each | 
				(currentNode allDescendants: self lattice bottom) includes: each])
				ifFalse: [(hdNodes includes: currentNode) ifFalse: [sum:= sum + 1. hdNodes add: currentNode.]]].
	^sum.

]

{ #category : #complex }
MalLatticePatterns >> irreducibleSpecialization [
	
	| dict |
	dict := Dictionary new.
	self lattice nodes do: [:aNode | (self IsSuperConceptSpecialization: aNode) ifTrue: [aNode descendants do:[:aDes | (self IsSubConceptSpecialization: aDes) ifTrue: [dict at: aNode put: aDes] ] ]].
	^dict 
		
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
	
	| modules |
	modules := ModuleIdentification on: self lattice.
	(modules isNil not )
		ifTrue:  [ 
			Transcript show: 'Number of modules ', modules size printString; cr.
			Transcript show: 'Number of Nodes in modules ', (modules inject: 0 into: [:sum :each | sum + each size ]) printString; cr. 
		]
	ifFalse: [
			Transcript show: 'Number of modules 0'; cr.
			Transcript show: 'Number of Nodes in modules 0'; cr. 
		]
]

{ #category : #report }
MalLatticePatterns >> reportPatterns [
	Transcript show: '# of nodes: ', self lattice nodes size printString; cr.
	Transcript show: 'Connections ' , self totalConnections printString; cr.
	Transcript show: 'Top ', self isTopPattern printString; cr.
	Transcript show: 'Bottom ', self isBottomPattern printString; cr.
	Transcript show: 'Specialization ', (self irreducibleSpecialization keys size) printString; cr.
	Transcript show: 'Specialization ', (self irreducibleSpecialization values size) printString; cr.
	Transcript show: 'Horizontal Decomposition ' , self horizontalDecomposition printString; cr.
	Transcript show: 'Horizontal Decomposition Size ' , self hDNodeSize printString; cr.
	self printModulesReport.
]

{ #category : #complex }
MalLatticePatterns >> totalConnections [
	^(self lattice nodes flatCollect: [:aNode | aNode descendants]) size
]
