Class {
	#name : #MalFormalContextTest,
	#superclass : #TestCase,
	#category : #'Moose-Tests-Algos-FormalConceptAnalysis'
}

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
