"
A MalCustomGraphTraverserTest is a test class for testing the behavior of MalCustomGraphTraverser
"
Class {
	#name : #MalCustomObjectTraverserTest,
	#superclass : #TestCase,
	#instVars : [
		'traverser'
	],
	#category : #'Moose-Algos-ObjectTraverser'
}

{ #category : #running }
MalCustomObjectTraverserTest >> setUp [
	| graph |
	graph := Dictionary new.
	graph at: 0 put: {1}.
	graph at: 1 put: {2 . 3}.
	graph at: 2 put: {3}.
	graph at: 4 put: {3}.
	graph at: 10 put: { { 11 } }.
	traverser := MalCustomObjectTraverser with: [ :each | graph at: each ifAbsent: [{ }]  ]
]

{ #category : #tests }
MalCustomObjectTraverserTest >> testCollectionsAreExpanded [
	traverser traverse: 10.
	self assert: traverser traversed asSet = {10 . 11} asSet.
]

{ #category : #tests }
MalCustomObjectTraverserTest >> testCycles [
	traverser traverse: 1.
	
	self assert: traverser traversed asSet = { 1 . 2 . 3} asSet
]

{ #category : #tests }
MalCustomObjectTraverserTest >> testGraph [
	traverser traverse: 0.
	self assert: traverser graph nodeModels equals: { 0 . 1 . 2 . 3 } asOrderedCollection.
	self assert: traverser graph nodes first model equals: 0.
	self assert: traverser graph nodes first nextNodes size equals: 1.
	self assert: traverser graph nodes first nextNodes first model equals: 1.
	self assert: traverser graph edges isEmpty
]

{ #category : #tests }
MalCustomObjectTraverserTest >> testGraphNode [
	traverser traverse: 0.
	self assert: (traverser graph nodes first isKindOf: MalTraverserGraphNode)
]

{ #category : #tests }
MalCustomObjectTraverserTest >> testNoCycle [
	traverser traverse: 4.
	
	self assert: traverser traversed asSet = {4 . 3} asSet
]

{ #category : #tests }
MalCustomObjectTraverserTest >> testOriginIsPresentInResult [
	traverser traverse: 0.
	self assert: traverser traversed asSet = {0 . 1 . 2 . 3} asSet.
]
