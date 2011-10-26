Class {
	#name : #LatticeTests,
	#superclass : #TestCase,
	#category : #'Moose-Tests-Algos-Lattice'
}

{ #category : #initialize }
LatticeTests >> initializeDataMammals [
	| data fca lattice |
	data := #(#(#Cat #(#fourlegs #hair)) #(#Dog #(#fourlegs #hair)) #(#Dolphin #(#smart #marine)) #(#Gibbon #(#hair #smart #thumbed)) #(#Man #(#smart #thumbed)) #(#Whale #(#smart #marine))).
	fca := MalFormalContext new.
	^fca with: data using: #first using: #last.
]

{ #category : #initialize }
LatticeTests >> initializeDataMammals2 [
	| data fca lattice |
	data := #(#(#Cat #(#fourlegs #hair)) #(#Dog #(#smart #fourlegs #hair)) #(#Dolphin #(#smart #marine)) #(#Gibbon #(#hair #smart #thumbed)) #(#Man #(#smart #thumbed)) #(#Whale #(#smart #marine))).
	fca := MalFormalContext new.
	^fca with: data using: #first using: #last.
]

{ #category : #initialize }
LatticeTests >> initializeHD [
	"lattice with horizontal decomposition"
	| data fca lattice |
	data := #(#(#Cat #(#fourlegs #hair)) #(#Dog #(#fourlegs #hair)) #(#Dolphin #(#smart #marine)) #(#Gibbon #(#hair #thumbed)) #(#Man #(#hair #thumbed)) #(#Whale #(#smart #marine))).
	fca := MalFormalContext new.
	^fca with: data using: #first using: #last.
]

{ #category : #tests }
LatticeTests >> testComplexMammals2 [
	| lattice patterns |
	lattice := MalLattice on: self initializeDataMammals2.
	patterns := MalLatticePatterns on: lattice.
	self assert: (patterns IsSuperConceptSpecialization: lattice top) not.
	self assert: (patterns black size =2).
	self assert: (patterns grey size =2).
	self assert: (patterns full size =3).
	self assert: (patterns empty size =3).
]

{ #category : #tests }
LatticeTests >> testComplexPatterns [
	| lattice patterns |
	lattice := MalLattice on: self initializeDataMammals.
	patterns := MalLatticePatterns on: lattice.
	self assert: (patterns IsSuperConceptSpecialization: lattice top) not.
	self assert: (patterns IsSuperConceptSpecialization: (patterns lattice nodes at:2)).
	self assert: (patterns IsSubConceptSpecialization: lattice bottom) not.
	self assert: (patterns IsSubConceptSpecialization: (patterns lattice nodes at:3)).
	self assert: patterns irreducibleSpecialization values size = 0.
]

{ #category : #tests }
LatticeTests >> testLatticeMammals [
	
	| lattice |
	lattice := MalLattice on: self initializeDataMammals.
	self assert: lattice nodes size = 8.
	self assert: lattice bottom concept numAttributes = 5.
	self assert: lattice top concept numObjects = 6.
	self assert: lattice nodes size = 8.
	self assert: (lattice top hasDescendant: lattice bottom).
	self assert: lattice bottom descendants isEmpty
]

{ #category : #tests }
LatticeTests >> testLatticePatterns [
	| lattice patterns |
	lattice := MalLattice on: self initializeDataMammals.
	patterns := MalLatticePatterns on: lattice.
	self assert: patterns full size = 3.
	self assert: patterns black size = 1.
	self assert: patterns grey size = 2.
	self assert: patterns empty size = 2.
	self assert: patterns isTopBlack = false.
	self assert: (patterns isEmpty: patterns lattice top).
	self assert: patterns isTopGrey = false.
	self assert: patterns isTopFull = false.
]

{ #category : #tests }
LatticeTests >> testPatternsHD [
	"Horizontal Decomposition lattice"
	| lattice patterns |
	lattice := MalLattice on: self initializeHD.
	patterns := MalLatticePatterns on: lattice.
	self assert: patterns horizontalDecomposition = 2.
	self assert: (patterns IsHorizontalDecomposition).
	
	
]

{ #category : #tests }
LatticeTests >> testPatternsHD2 [
	"A lattice without Horizontal Decomposition"
	| lattice patterns |
	lattice := MalLattice on: self initializeDataMammals.
	patterns := MalLatticePatterns on: lattice.
	self assert: (patterns IsHorizontalDecomposition) not.
	self assert: patterns horizontalDecomposition = 0.
	
]

{ #category : #tests }
LatticeTests >> testPatternsSpecialization [
	| lattice patterns |
	lattice := MalLattice on: self initializeDataMammals.
	patterns := MalLatticePatterns on: lattice.
	self assert: (patterns IsSuperConceptSpecialization: lattice top) not.
	self assert: (patterns IsSuperConceptSpecialization: (patterns lattice nodes at: 2)).
	self assert: (patterns IsSubConceptSpecialization: lattice bottom) not.
	self assert: (patterns IsSubConceptSpecialization: (patterns lattice nodes at: 3)).
	self assert: patterns irreducibleSpecialization values size = 0
]
