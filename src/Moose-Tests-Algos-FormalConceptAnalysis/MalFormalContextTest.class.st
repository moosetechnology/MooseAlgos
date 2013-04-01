Class {
	#name : #MalFormalContextTest,
	#superclass : #TestCase,
	#category : #'Moose-Tests-Algos-FormalConceptAnalysis'
}

{ #category : #initialization }
MalFormalContextTest >> initializeContext [
	| data fca context |
	data := #(#(#Cat #(#fourlegs #hair)) #(#Dog #(#smart #fourlegs #hair)) #(#Dolphin #(#smart #marine)) #(#Gibbon #(#hair #smart #thumbed)) #(#Man #(#smart #thumbed #hair #marine)) #(#Whale #(#smart #marine))).
	fca := MalFormalContext new.
	context := fca with: data using: #first using: #last.
	^ (MalLattice new viewLattice: (MalLattice on: context))
]

{ #category : #tests }
MalFormalContextTest >> testClassHierarchy [
	| fca |
		fca := MalFormalContext classHierarchy: Integer withAllSubclasses..
	self assert: fca concepts size = 5.
	self assert: (fca concepts select: [:each | each attributes isEmpty]) size = 0.
	self assert: (fca concepts select: [:each | each objects isEmpty]) size = 1.
]

{ #category : #tests }
MalFormalContextTest >> testMammals [
	| data fca |
	data := #((Cat (fourlegs hair))
	(Dog (fourlegs hair))
	(Dolphin (smart marine))
	(Gibbon (hair smart thumbed))
	(Man (smart thumbed))
	(Whale (smart marine))).
	fca := MalFormalContext new.
	fca with: data using: #first using: #last.
	self assert: fca concepts size = 8.
	self assert: (fca concepts select: [:each | each attributes isEmpty]) size = 1.
	self assert: (fca concepts select: [:each | each objects isEmpty]) size = 1.
]

{ #category : #initialization }
MalFormalContextTest >> testViewLattice [

	self shouldnt: [self initializeContext delete] raise: Error.
]
