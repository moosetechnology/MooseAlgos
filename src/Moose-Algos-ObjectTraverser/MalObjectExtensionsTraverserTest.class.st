Class {
	#name : #MalObjectExtensionsTraverserTest,
	#superclass : #MalTraverserTest,
	#category : #'Moose-Algos-ObjectTraverser'
}

{ #category : #private }
MalObjectExtensionsTraverserTest >> nextGraphElementsFrom: each [
	^ graph at: each ifAbsent: [ #() ]
]

{ #category : #tests }
MalObjectExtensionsTraverserTest >> testDeepCollectAs [
	| result |
	result := 1 
		deep: [ :each | self nextGraphElementsFrom: each ]
		collect: [ :each | each * 10 ]
		as: Set.
	self assert: result equals: #(20 30) asSet
]

{ #category : #tests }
MalObjectExtensionsTraverserTest >> testDeepCollectAsSet [
	| result |
	result := 1 deepCollectAsSet: [ :each | self nextGraphElementsFrom: each ].
	self assert: result equals: #(2 3) asSet
]

{ #category : #tests }
MalObjectExtensionsTraverserTest >> testDeepCollectSimple [
	| result |
	result := 1 deepCollect: [ :each | self nextGraphElementsFrom: each ].
	self assert: result equals: #(2 3) asOrderedCollection
]

{ #category : #tests }
MalObjectExtensionsTraverserTest >> testDeepCollectWithBlock [
	| result |
	result := 1 
		deep: [ :each | self nextGraphElementsFrom: each ]
		collect: [ :each | each * 10 ].
	self assert: result equals: #(20 30) asOrderedCollection
]

{ #category : #tests }
MalObjectExtensionsTraverserTest >> testDeepDo [
	| trace |
	trace := OrderedCollection new.
	1 
		deep: [ :each | self nextGraphElementsFrom: each ]
		do: [ :each | trace add: each ].
	self assert: trace equals: #(2 3) asOrderedCollection
]

{ #category : #tests }
MalObjectExtensionsTraverserTest >> testWithDeepCollect [
	| result |
	result := 1 withDeepCollect: [ :each | self nextGraphElementsFrom: each ].
	self assert: result asSet equals: #(1 2 3) asSet
]

{ #category : #tests }
MalObjectExtensionsTraverserTest >> testWithDeepDo [
	| trace |
	trace := Set new.
	1 
		withDeep: [ :each | self nextGraphElementsFrom: each ] 
		do: [ :each | trace add: each ].
	self assert: trace equals: #(1 2 3) asSet
]
