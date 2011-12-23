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

{ #category : #initialize }
LatticeTests >> initializeHD2 [
	"lattice with horizontal decomposition"
	| data fca lattice |
	data := #(#(#Cat #(#fourlegs #hair)) #(#Dog #(#fourlegs #hair)) #(#Dolphin #(#smart #marine)) #(#Gibbon #(#hair #thumbed)) #(#Man #(#hair #thumbed)) #(#Whale #(#smart #marine)) #(#a #(#b #c))).
	fca := MalFormalContext new.
	^fca with: data using: #first using: #last.
]

{ #category : #tests }
LatticeTests >> testAllAncestors [
	"ancestors of a node"
	
	| lattice node patterns |
	lattice := MalLattice on: self initializeDataMammals2.
	patterns := ModuleIdentification new lattice: lattice.
	self assert: (patterns allAncestors: (lattice nodes at: 2)) size = 2.
	self assert: (patterns allAncestors: (lattice nodes at: 3)) size = 1.
	self assert: (((patterns allAncestors: (lattice nodes at: 3)) at: 1) concept attributes at:1) value = #smart .	
	
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
	self assert: patterns totalConnections = 10.
]

{ #category : #tests }
LatticeTests >> testModule [
	
	| data fca context lattice modules |
	data := #(#(#a #()) #(#b #(#1)) #(#c #(#1 #2)) #(#(#d) #(#1 #3)) #(#x #(#1 #5))  #(#(#e) #(#1 #2 #3 #5)) #(#(#f) #(#1 #2 #3 #4 #5))).
	fca := MalFormalContext new.
	context := fca with: data using: #first using: #last.
	lattice := (MalLattice on: context).
	modules := (ModuleIdentification on: lattice).
	self assert:  modules size = 1.
	self assert:  modules first size = 5.


]

{ #category : #tests }
LatticeTests >> testModule2 [
	
| data fca context lattice modules |
	data := #(#(#a #()) #(#b #(#1)) #(#c #(#1 #2)) #(#(#d) #(#1 #3)) #(#(#e) #(#1 #2 #3)) #(#(#f) #(#1 #2 #3 #4))).
	fca := MalFormalContext new.
	context := fca with: data using: #first using: #last.
	lattice := (MalLattice on: context).
	"(MalLattice new viewLattice: lattice)."
	modules := (ModuleIdentification on: lattice).
	self assert:  modules size = 1.
	self assert:  modules first size = 4.
]

{ #category : #tests }
LatticeTests >> testPatternsHD [
	"Horizontal Decomposition lattice"
	| lattice patterns |
	lattice := MalLattice on: self initializeHD.
	patterns := MalLatticePatterns on: lattice.
	self assert: patterns horizontalDecomposition = 2.
	self assert: (patterns IsHorizontalDecomposition).
	self assert: patterns totalConnections = 7.
	
	
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
LatticeTests >> testPatternsHD3 [
	"Horizontal Decomposition lattice"
	| lattice patterns |
	lattice := MalLattice on: self initializeHD2.
	patterns := MalLatticePatterns on: lattice.
	self assert: patterns horizontalDecomposition = 3.
	self assert: (patterns IsHorizontalDecomposition).
	self assert: patterns totalConnections = 9.
	
	
]

{ #category : #tests }
LatticeTests >> testPatternsSpecialization [
	"Irreducible specialization"
	| lattice patterns |
	lattice := MalLattice on: self initializeDataMammals.
	patterns := MalLatticePatterns on: lattice.
	self assert: (patterns IsSuperConceptSpecialization: lattice top) not.
	self assert: (patterns IsSuperConceptSpecialization: (patterns lattice nodes at: 2)).
	self assert: (patterns IsSubConceptSpecialization: lattice bottom) not.
	self assert: (patterns IsSubConceptSpecialization: (patterns lattice nodes at: 3)).
	self assert: patterns irreducibleSpecialization values size = 0
]
