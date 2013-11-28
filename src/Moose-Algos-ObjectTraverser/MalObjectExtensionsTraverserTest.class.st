Class {
	#name : #MalObjectExtensionsTraverserTest,
	#superclass : #MalObjectTraverserTest,
	#category : #'Moose-Algos-ObjectTraverser'
}

{ #category : #'as yet unclassified' }
MalObjectExtensionsTraverserTest >> testDeepCollect [
	| result |
	result := 1 deepCollect: [ :each | 
			graph at: each ifAbsent: [ #() ] ].
	self assert: result asSet equals: #(2 3) asSet
]

{ #category : #'as yet unclassified' }
MalObjectExtensionsTraverserTest >> testDeepDo [
	| trace |
	trace := Set new.
	1 
		deep: [ :each | graph at: each ifAbsent: [ #() ] ]
		do: [ :each | trace add: each ].
	self assert: trace equals: #(2 3) asSet
]

{ #category : #'as yet unclassified' }
MalObjectExtensionsTraverserTest >> testWithDeepCollect [
	| result |
	result := 1 withDeepCollect: [ :each | 
			graph at: each ifAbsent: [ #() ] ].
	self assert: result asSet equals: #(1 2 3) asSet
]
