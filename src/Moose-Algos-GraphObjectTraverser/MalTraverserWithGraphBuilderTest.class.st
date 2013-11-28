Class {
	#name : #MalTraverserWithGraphBuilderTest,
	#superclass : #MalTraverserTest,
	#category : #'Moose-Algos-GraphObjectTraverser'
}

{ #category : #tests }
MalTraverserWithGraphBuilderTest >> testGraph [
	traverser traverse: 0.
	self assert: traverser action graph nodeModels equals: { 0 . 1 . 2 . 3 } asOrderedCollection.
	self assert: traverser action graph nodes first model equals: 0.
	self assert: traverser action graph nodes first nextNodes size equals: 1.
	self assert: traverser action graph nodes first nextNodes first model equals: 1.
	self assert: traverser action graph edges isEmpty
]

{ #category : #tests }
MalTraverserWithGraphBuilderTest >> testGraphNode [
	traverser traverse: 0.
	self assert: (traverser action graph nodes first isKindOf: MalTraverserGraphNode)
]

{ #category : #running }
MalTraverserWithGraphBuilderTest >> traverser [
	^ MalTraverser new
		action: MalGraphBuilderStrategy new;
		traversal: (MalCustomTraversal 
						with: [ :each | graph at: each ifAbsent: [{ }] ])
		
]
