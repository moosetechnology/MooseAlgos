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
MalLatticePatterns >> IsSubConceptSpecialization: aNode [
	(self lattice bottom = aNode) ifTrue: [(self isFull: aNode) ifTrue: [^true] ifFalse: [^false]].  
	((self isGrey: aNode) or: [self isFull: aNode]) ifTrue: [^true] ifFalse: [^false] 
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
MalLatticePatterns >> horizontalDecomposition [
	
	| dict nodes |
	nodes := self lattice top descendants.
	1 to: (nodes size -1 ) 
		do: [:n | 	(n+1 to: (nodes size))
			do:[:m | ((nodes at:n) hasDescendant: (nodes at: m))
			ifFalse: 	[(((nodes at: n) allDescendants: self lattice bottom) anySatisfy: [:each | (((nodes at:m) allDescendants: self lattice bottom) includes: each)]) ifFalse: [^true]]]].
	^false.

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
	^ (self isBottomBlack or:[self isBottomFull]) or: [self isBottomGrey]
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
	^ (self isTopBlack or:[self isTopFull]) or: [self isTopGrey]
]

{ #category : #accessors }
MalLatticePatterns >> lattice [
	^lattice
]

{ #category : #accessors }
MalLatticePatterns >> lattice: aLattice [
	lattice := aLattice.
]

{ #category : #'as yet unclassified' }
MalLatticePatterns >> reportPatterns [
	Transcript show: '# of nodes: ', self lattice nodes size printString; cr.
	Transcript show: 'Top ', self isTopPattern printString; cr.
	Transcript show: 'Bottom ', self isBottomPattern printString; cr.
	Transcript show: 'Specialization ', self irreducibleSpecialization values printString; cr.
	Transcript show: 'Horizontal Decomposition ' , self horizontalDecomposition printString; cr.
	
]
