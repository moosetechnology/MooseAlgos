"
A MalCustomGraphTraverserTest is a test class for testing the behavior of MalCustomGraphTraverser
"
Class {
	#name : #MalCustomTraverserTest,
	#superclass : #MalTraverserTest,
	#instVars : [
		'traverser'
	],
	#category : #'Moose-Algos-ObjectTraverser'
}

{ #category : #running }
MalCustomTraverserTest >> setUp [
	super setUp.
	traverser := self traverser
]

{ #category : #tests }
MalCustomTraverserTest >> testCollectionsAreExpanded [
	traverser traverse: 10.
	self assert: traverser traversedObjects asSet = {10 . 11} asSet.
]

{ #category : #tests }
MalCustomTraverserTest >> testCycles [
	traverser traverse: 1.
	
	self assert: traverser traversedObjects asSet = { 1 . 2 . 3} asSet
]

{ #category : #tests }
MalCustomTraverserTest >> testNoCycle [
	traverser traverse: 4.
	
	self assert: traverser traversedObjects asSet = {4 . 3} asSet
]

{ #category : #tests }
MalCustomTraverserTest >> testOriginIsPresentInResult [
	traverser traverse: 0.
	self assert: traverser traversedObjects asSet = {0 . 1 . 2 . 3} asSet.
]

{ #category : #running }
MalCustomTraverserTest >> traverser [
	^ MalTraverser 
		withCustomTraversal: [ :each | 
			graph at: each ifAbsent: [{ }] ]
]
