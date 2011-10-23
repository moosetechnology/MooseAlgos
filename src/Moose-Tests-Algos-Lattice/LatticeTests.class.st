Class {
	#name : #LatticeTests,
	#superclass : #TestCase,
	#category : #'Moose-Tests-Algos-Lattice'
}

{ #category : #'as yet unclassified' }
LatticeTests >> testLatticeMammals [
	| data fca lattice |
	data := #(#(#Cat #(#fourlegs #hair)) #(#Dog #(#fourlegs #hair)) #(#Dolphin #(#smart #marine)) #(#Gibbon #(#hair #smart #thumbed)) #(#Man #(#smart #thumbed)) #(#Whale #(#smart #marine))).
	fca := MalFormalContext new.
	fca with: data using: #first using: #last.
	lattice := MalLattice on: fca.
	self assert: lattice nodes size = 8.
	self assert: lattice bottom concept numAttributes = 5.
	self assert: lattice top concept numObjects = 6.
	self assert: lattice nodes size = 8.
	self assert: (lattice top hasDescendant: lattice bottom).
	self assert: lattice bottom descendants isEmpty
]
