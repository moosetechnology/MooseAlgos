Class {
	#name : #MalHitsFixture,
	#superclass : #TestCase,
	#instVars : [
		'hits'
	],
	#category : #'Moose-Tests-Algos-Graph'
}

{ #category : #'as yet unclassified' }
MalHitsFixture >> initialize [

	self setUp
]

{ #category : #'as yet unclassified' }
MalHitsFixture >> setUp [

	hits := MalHits new.

]

{ #category : #'as yet unclassified' }
MalHitsFixture >> testComplexCycle [

	MalGraphFixture complexCycleGraph: hits.
	hits run.
]

{ #category : #'as yet unclassified' }
MalHitsFixture >> testComplexWCycle [

	MalGraphFixture complexWeightedGraph: hits.
	hits run.
]

{ #category : #'as yet unclassified' }
MalHitsFixture >> testCycle [

	MalGraphFixture cycleGraph: hits.
	hits run.
]

{ #category : #'as yet unclassified' }
MalHitsFixture >> testNestedCycle [

	MalGraphFixture nestedCycleGraph: hits.
	hits run.
]

{ #category : #'as yet unclassified' }
MalHitsFixture >> testSimple [

	(MalGraphFixture simpleGraph: hits) run.
]

{ #category : #'as yet unclassified' }
MalHitsFixture >> testSimpleW [

	(MalGraphFixture simpleWeightedGraph: hits) run.
]
