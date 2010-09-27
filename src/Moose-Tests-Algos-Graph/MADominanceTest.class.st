Class {
	#name : #MADominanceTest,
	#superclass : #TestCase,
	#instVars : [
		'nodes',
		'dom'
	],
	#category : #'Moose-Tests-Algos-Graph'
}

{ #category : #running }
MADominanceTest >> setUp [

	dom := MADominance new.
]

{ #category : #tests }
MADominanceTest >> testCycle [

	| a b c |
	MAGraphFixture cycleGraph: dom.
	dom run.
	dom nodes do: [:n|
		n model = $c
			ifTrue: [self assert: n isDominant. self deny: n isDominated]
			ifFalse: [ 
				self deny: n isDominant.
				n model = $d 
					ifTrue: [self deny: n isDominated]
					ifFalse: [self assert: n isDominated]
				]
	].
	a := dom findNode: $a.
	b := dom findNode: $b.
	c := dom findNode: $c.
	self assert: (a find = c).
	self assert: (b find = c).

]

{ #category : #tests }
MADominanceTest >> testSimple [

	| a b c d |
	MAGraphFixture simpleGraph: dom.
	dom run.
	dom nodes do: [:n|
		n model = $a
			ifTrue: [self assert: n isDominant. self deny: n isDominated]
			ifFalse: [self deny: n isDominant]
	].
	a := dom findNode: $a.
	b := dom findNode: $b.
	c := dom findNode: $c.
	d := dom findNode: $d.
	self assert: (b find = a).
	self deny: c isDominated.
	self deny: d isDominated
]
