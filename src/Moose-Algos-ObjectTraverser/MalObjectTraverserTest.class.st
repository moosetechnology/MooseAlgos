Class {
	#name : #MalObjectTraverserTest,
	#superclass : #TestCase,
	#instVars : [
		'traverser',
		'graph'
	],
	#category : #'Moose-Algos-ObjectTraverser'
}

{ #category : #running }
MalObjectTraverserTest >> setUp [
	graph := Dictionary new.
	graph at: 0 put: {1}.
	graph at: 1 put: {2 . 3}.
	graph at: 2 put: {3}.
	graph at: 4 put: {3}.
	graph at: 10 put: { { 11 } }.
	traverser := self traverser
]

{ #category : #running }
MalObjectTraverserTest >> traverser [
	self subclassResponsibility 
]
