Class {
	#name : #MAHitsFixture,
	#superclass : #Object,
	#instVars : [
		'hits'
	],
	#category : #'Moose-Tests-Algos-Graph'
}

{ #category : #'as yet unclassified' }
MAHitsFixture >> initialize [

	self setUp
]

{ #category : #'as yet unclassified' }
MAHitsFixture >> setUp [

	hits := MAHits new.

]

{ #category : #'as yet unclassified' }
MAHitsFixture >> testComplexCycle [

	MAGraphFixture complexCycleGraph: hits.
	hits run.
]

{ #category : #'as yet unclassified' }
MAHitsFixture >> testComplexWCycle [

	MAGraphFixture complexWeightedGraph: hits.
	hits run.
]

{ #category : #'as yet unclassified' }
MAHitsFixture >> testCycle [

	MAGraphFixture cycleGraph: hits.
	hits run.
]

{ #category : #'as yet unclassified' }
MAHitsFixture >> testNestedCycle [

	MAGraphFixture nestedCycleGraph: hits.
	hits run.
]

{ #category : #'as yet unclassified' }
MAHitsFixture >> testSimple [

	(MAGraphFixture simpleGraph: hits) run.
]

{ #category : #'as yet unclassified' }
MAHitsFixture >> testSimpleW [

	(MAGraphFixture simpleWeightedGraph: hits) run.
]
