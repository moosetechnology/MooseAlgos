Class {
	#name : #MOHitsFixture,
	#superclass : #Object,
	#instVars : [
		'hits'
	],
	#category : #'Moose-Tests-Algos-Graph'
}

{ #category : #'as yet unclassified' }
MOHitsFixture >> initialize [

	self setUp
]

{ #category : #'as yet unclassified' }
MOHitsFixture >> setUp [

	hits := MOHits new.

]

{ #category : #'as yet unclassified' }
MOHitsFixture >> testComplexCycle [

	MOGraphFixture complexCycleGraph: hits.
	hits run.
]

{ #category : #'as yet unclassified' }
MOHitsFixture >> testComplexWCycle [

	MOGraphFixture complexWeightedGraph: hits.
	hits run.
]

{ #category : #'as yet unclassified' }
MOHitsFixture >> testCycle [

	MOGraphFixture cycleGraph: hits.
	hits run.
]

{ #category : #'as yet unclassified' }
MOHitsFixture >> testNestedCycle [

	MOGraphFixture nestedCycleGraph: hits.
	hits run.
]

{ #category : #'as yet unclassified' }
MOHitsFixture >> testSimple [

	(MOGraphFixture simpleGraph: hits) run.
]

{ #category : #'as yet unclassified' }
MOHitsFixture >> testSimpleW [

	(MOGraphFixture simpleWeightedGraph: hits) run.
]
