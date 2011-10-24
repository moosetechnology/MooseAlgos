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
	^lattice nodes select:[:aNode | aNode concept intent = 0 and: [ aNode concept extent ~= 0]]
]

{ #category : #bottom }
MalLatticePatterns >> bottomBlack [
	self isBottomBlack ifTrue: [^self lattice bottom] ifFalse: [^nil]
]

{ #category : #bottom }
MalLatticePatterns >> bottomFull [
	self isBottomFull ifTrue: [^self lattice bottom] ifFalse: [^nil]
]

{ #category : #bottom }
MalLatticePatterns >> bottomGrey [
	self isBottomGrey ifTrue: [^self lattice bottom] ifFalse: [^nil]
]

{ #category : #nodes }
MalLatticePatterns >> empty [
	^lattice nodes select:[:aNode | aNode concept intent = 0 and: [ aNode concept extent = 0]]
]

{ #category : #nodes }
MalLatticePatterns >> full [
	^lattice nodes select:[:aNode | aNode concept intent ~= 0 and: [ aNode concept extent ~= 0]]
]

{ #category : #nodes }
MalLatticePatterns >> grey [
	^lattice nodes select:[:aNode | aNode concept intent ~= 0 and: [ aNode concept extent = 0]]
]

{ #category : #complex }
MalLatticePatterns >> irreducibleSpecialization [
	|dict|
	dict := Dictionary new.
	self lattice nodes do: [:aNode | (self IsSuperConceptSpecialization: aNode) ifTrue: [aNode descendants do:[:aDes | ((self isGrey: aDes) or: [self isFull: aNode]) ifTrue: [dict at:aNode put: aDes] ] ]].
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

{ #category : #nodes }
MalLatticePatterns >> isEmpty: aNode [
	self empty includes: aNode
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
MalLatticePatterns >> istopBlack [
	^self black includes: self lattice top
]

{ #category : #top }
MalLatticePatterns >> istopFull [
	^self full includes: self lattice top
]

{ #category : #top }
MalLatticePatterns >> istopGrey [
	^self grey includes: self lattice top
]

{ #category : #accessors }
MalLatticePatterns >> lattice [
	^lattice
]

{ #category : #accessors }
MalLatticePatterns >> lattice: aLattice [
	lattice := aLattice.
]

{ #category : #top }
MalLatticePatterns >> topBlack [
	self istopBlack ifTrue: [^self lattice top] ifFalse: [^nil]
]

{ #category : #top }
MalLatticePatterns >> topFull [
	self istopFull ifTrue: [^self lattice top] ifFalse: [^nil]
]

{ #category : #top }
MalLatticePatterns >> topGrey [
	self istopGrey ifTrue: [^self lattice top] ifFalse: [^nil]
]
