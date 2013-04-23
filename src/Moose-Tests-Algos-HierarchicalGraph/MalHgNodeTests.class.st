Class {
	#name : #MalHgNodeTests,
	#superclass : #TestCase,
	#category : #'Moose-Tests-Algos-HierarchicalGraph'
}

{ #category : #setup }
MalHgNodeTests >> testParentOnLevel [
	| hg rootNodes  |
	
	rootNodes := OrderedCollection new.
	rootNodes add: 'a'; add: 'b'; add: 'c'.
	
	hg := MalHierarchicalGraph with: rootNodes name: 'aTopDownConstructedGraph'.

	hg topDown: [ :entity |  
		(entity size < 4) 
		ifTrue: [
			| result |
			result := Set new.
			result add: (entity, 'a').
			result add: (entity, 'b').
			result add: (entity, 'c').
			result.
		]
	].

	self should: [((hg nodeWrapping: 'aba') parentOnLevel: -1) = (hg nodeWrapping: 'a')] raise: AssertionFailure.
	self assert: (((hg nodeWrapping: 'aba') parentOnLevel: 10) = nil).
	
	self assert: (((hg nodeWrapping: 'aba') parentOnLevel: 0) = (hg nodeWrapping: 'a')).
	self assert: (((hg nodeWrapping: 'aba') parentOnLevel: 1) = (hg nodeWrapping: 'ab')).
	self assert: (((hg nodeWrapping: 'cabc') parentOnLevel: 1) = (hg nodeWrapping: 'ca')).
	self assert: (((hg nodeWrapping: 'baac') parentOnLevel: 3) = nil).
	self assert: (((hg nodeWrapping: 'baac') parentOnLevel: 2) = (hg nodeWrapping: 'baa')).
	self assert: (((hg nodeWrapping: 'bbbc') parentOnLevel: 0) = (hg nodeWrapping: 'b')).

	
]
