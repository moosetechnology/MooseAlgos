"
Abstract test class providing only a small graph fixture
"
Class {
	#name : #MalTraverserTest,
	#superclass : #TestCase,
	#instVars : [
		'graph'
	],
	#category : #'Moose-Algos-ObjectTraverser'
}

{ #category : #private }
MalTraverserTest >> nextGraphElementsFrom: each [
	^ graph at: each ifAbsent: [ #() ]
]

{ #category : #running }
MalTraverserTest >> setUp [
	graph := Dictionary new.
	graph at: 0 put: {1}.
	graph at: 1 put: {2 . 3}.
	graph at: 2 put: {3}.
	graph at: 4 put: {3}.
	graph at: 10 put: { { 11 } }
]
