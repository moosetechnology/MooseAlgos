Class {
	#name : #LatticeTests,
	#superclass : #TestCase,
	#category : #'Moose-Tests-Algos-Lattice'
}

{ #category : #tests }
LatticeTests >> initializeData [
	| data fca lattice |
	data := #(#(#Cat #(#fourlegs #hair)) #(#Dog #(#fourlegs #hair)) #(#Dolphin #(#smart #marine)) #(#Gibbon #(#hair #smart #thumbed)) #(#Man #(#smart #thumbed)) #(#Whale #(#smart #marine))).
	fca := MalFormalContext new.
	^fca with: data using: #first using: #last.
]

{ #category : #tests }
LatticeTests >> testComplexPatterns [
	| lattice patterns |
	lattice := MalLattice on: self initializeData.
	patterns := MalLatticePatterns on: lattice.
	self assert: (patterns IsSuperConceptSpecialization: lattice top) not.
	self assert: (patterns IsSuperConceptSpecialization: (patterns lattice nodes at:2))
]

{ #category : #tests }
LatticeTests >> testLatticeMammals [
	
	| lattice |
	lattice := MalLattice on: self initializeData.
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
	lattice := MalLattice on: self initializeData.
	patterns := MalLatticePatterns on: lattice.
	self assert: patterns full size = 6.
	self assert: patterns black size = 1.
	self assert: patterns grey size = 1.
	self assert: patterns empty size = 0.
	self assert: patterns istopBlack = true.
	self assert: patterns lattice top = patterns topBlack.
	self assert: patterns topGrey = nil.
	self assert: patterns topFull = nil.
]

{ #category : #tests }
LatticeTests >> testNodePatterns [
	| lattice patterns |
	lattice := MalLattice on: self initializeData.
	patterns := MalLatticePatterns on: lattice.
	self assert: patterns full size = 6.
	self assert: patterns black size = 1.
	self assert: patterns grey size = 1.
	self assert: patterns empty size = 0.
	self assert: patterns istopBlack = true.
	self assert: patterns lattice top = patterns topBlack.
	self assert: patterns topGrey = nil.
	self assert: patterns topFull = nil.
]
