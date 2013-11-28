"
A MalCustomGraphTraverserTest is a test class for testing the behavior of MalCustomGraphTraverser
"
Class {
	#name : #MalCustomObjectTraverserTest,
	#superclass : #MalObjectTraverserTest,
	#instVars : [
		'traverser'
	],
	#category : #'Moose-Algos-ObjectTraverser'
}

{ #category : #running }
MalCustomObjectTraverserTest >> setUp [
	super setUp.
	traverser := self traverser
]

{ #category : #tests }
MalCustomObjectTraverserTest >> testCollectionsAreExpanded [
	traverser traverse: 10.
	self assert: traverser traversedObjects asSet = {10 . 11} asSet.
]

{ #category : #tests }
MalCustomObjectTraverserTest >> testCycles [
	traverser traverse: 1.
	
	self assert: traverser traversedObjects asSet = { 1 . 2 . 3} asSet
]

{ #category : #tests }
MalCustomObjectTraverserTest >> testNoCycle [
	traverser traverse: 4.
	
	self assert: traverser traversedObjects asSet = {4 . 3} asSet
]

{ #category : #tests }
MalCustomObjectTraverserTest >> testOriginIsPresentInResult [
	traverser traverse: 0.
	self assert: traverser traversedObjects asSet = {0 . 1 . 2 . 3} asSet.
]

{ #category : #running }
MalCustomObjectTraverserTest >> traverser [
	^ MalObjectTraverser 
		withCustomTraversal: [ :each | 
			graph at: each ifAbsent: [{ }] ]
]
