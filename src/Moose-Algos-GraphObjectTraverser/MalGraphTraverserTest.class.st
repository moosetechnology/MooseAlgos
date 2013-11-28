Class {
	#name : #MalGraphTraverserTest,
	#superclass : #MalObjectTraverserTest,
	#category : #'Moose-Algos-GraphObjectTraverser'
}

{ #category : #tests }
MalGraphTraverserTest >> testGraph [
	traverser traverse: 0.
	self assert: traverser action graph nodeModels equals: { 0 . 1 . 2 . 3 } asOrderedCollection.
	self assert: traverser action graph nodes first model equals: 0.
	self assert: traverser action graph nodes first nextNodes size equals: 1.
	self assert: traverser action graph nodes first nextNodes first model equals: 1.
	self assert: traverser action graph edges isEmpty
]

{ #category : #tests }
MalGraphTraverserTest >> testGraphNode [
	traverser traverse: 0.
	self assert: (traverser action graph nodes first isKindOf: MalTraverserGraphNode)
]

{ #category : #running }
MalGraphTraverserTest >> traverser [
	^ MalObjectTraverser new
		action: MalGraphBuilderAction new;
		traversal: (MalCustomObjectTraversal 
						with: [ :each | graph at: each ifAbsent: [{ }] ])
		
]
