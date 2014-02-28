Class {
	#name : #MalTraverserWithGraphBuilderTest,
	#superclass : #DeepTraverserTest,
	#instVars : [
		'traverser'
	],
	#category : #'Moose-Algos-GraphObjectTraverser'
}

{ #category : #running }
MalTraverserWithGraphBuilderTest >> setUp [
	super setUp.
	traverser := self traverser
]

{ #category : #tests }
MalTraverserWithGraphBuilderTest >> testGraphFrom0 [
	traverser traverse: 0.
	self assert: traverser action graph nodeModels equals: { 0 . 1 . 2 . 3 } asOrderedCollection.
	self assert: traverser action graph nodes first model equals: 0.
	self assert: traverser action graph nodes first nextNodes size equals: 1.
	self assert: traverser action graph nodes first nextNodes first model equals: 1.
	self assert: traverser action graph edges isEmpty
]

{ #category : #tests }
MalTraverserWithGraphBuilderTest >> testGraphFrom2 [
	traverser traverse: 2.
	self assert: traverser action graph nodeModels equals: { 2 . 3 } asOrderedCollection.
	self assert: traverser action graph nodes first model equals: 2.
	self assert: traverser action graph nodes first nextNodes size equals: 1.
	self assert: traverser action graph nodes first nextNodes first model equals: 3.
	self assert: traverser action graph edges isEmpty
]

{ #category : #tests }
MalTraverserWithGraphBuilderTest >> testGraphNode [
	traverser traverse: 0.
	self assert: (traverser action graph nodes first isKindOf: MalTraverserGraphNode)
]

{ #category : #running }
MalTraverserWithGraphBuilderTest >> traverser [
	| action |
	action := MalGraphBuilderStrategy new.
	^ DeepTraverser new
		action: action;
		firstObjectAction: action;
		traversal: (DeepCustomTraversal 
						with: [ :each | graph at: each ifAbsent: [{ }] ])
		
]
