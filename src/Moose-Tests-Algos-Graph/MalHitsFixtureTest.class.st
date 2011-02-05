Class {
	#name : #MalHitsFixtureTest,
	#superclass : #TestCase,
	#instVars : [
		'hits'
	],
	#category : #'Moose-Tests-Algos-Graph'
}

{ #category : #'as yet unclassified' }
MalHitsFixtureTest >> initialize [

	self setUp
]

{ #category : #'as yet unclassified' }
MalHitsFixtureTest >> setUp [

	hits := MalHits new.

]

{ #category : #'as yet unclassified' }
MalHitsFixtureTest >> testComplexCycle [

	MalGraphFixture complexCycleGraph: hits.
	hits run.
]

{ #category : #'as yet unclassified' }
MalHitsFixtureTest >> testComplexWCycle [

	MalGraphFixture complexWeightedGraph: hits.
	hits run.
]

{ #category : #'as yet unclassified' }
MalHitsFixtureTest >> testCycle [

	MalGraphFixture cycleGraph: hits.
	hits run.
]

{ #category : #'as yet unclassified' }
MalHitsFixtureTest >> testNestedCycle [

	MalGraphFixture nestedCycleGraph: hits.
	hits run.
]

{ #category : #'as yet unclassified' }
MalHitsFixtureTest >> testSimple [

	(MalGraphFixture simpleGraph: hits) run.
]

{ #category : #'as yet unclassified' }
MalHitsFixtureTest >> testSimpleW [

	(MalGraphFixture simpleWeightedGraph: hits) run.
]
