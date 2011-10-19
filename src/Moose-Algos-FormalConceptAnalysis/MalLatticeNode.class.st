Class {
	#name : #MalLatticeNode,
	#superclass : #MONode,
	#instVars : [
		'concept',
		'descendants'
	],
	#category : #'Moose-Algos-FormalConceptAnalysis'
}

{ #category : #'as yet unclassified' }
MalLatticeNode class >> with: anObject [

	self new
		self concept: anObject
		yourself
]

{ #category : #'as yet unclassified' }
MalLatticeNode class >> withNew: concept [
	| latticeNode |
	latticeNode := MalLatticeNode on: concept .
	latticeNode concept: concept.
	^latticeNode
]

{ #category : #accessing }
MalLatticeNode >> addDescendant: aNode [
	descendants ifNil: [ descendants := OrderedCollection new ].
	descendants add: aNode
]

{ #category : #accessing }
MalLatticeNode >> concept [
	
	^concept
]

{ #category : #accessing }
MalLatticeNode >> concept: anObject [
	
	concept := anObject
]

{ #category : #accessing }
MalLatticeNode >> descendants [
	^descendants ifNil: OrderedCollection new.
]

{ #category : #enumerating }
MalLatticeNode >> descendantsDo: aBlock [

	self nodes do: aBlock.
	self nodes do: [ :each |
		each descendantsDo: aBlock ]
]

{ #category : #enumerating }
MalLatticeNode >> hasDescendant: aNode [
	self descendantsDo: [:each | each = aNode ifTrue: [^true]].
	^false
]

{ #category : #accessing }
MalLatticeNode >> layer [
	
	^self concept numAttributes
]

{ #category : #accessing }
MalLatticeNode >> maybeAppendChild: aNode [

	"Creates layers of concepts for all concepts except top and bottom"
	[self layer < aNode layer] assert.
	(self hasDescendant: aNode)
		ifFalse:
			[(aNode concept intent allMask: self concept intent)
				ifTrue: [self addDescendant: aNode]]
]

{ #category : #accessing }
MalLatticeNode >> removeDescendant: aCollection [
	descendants isEmpty not ifTrue: [aCollection do:[:aNode | descendants remove: aNode]].
	
]
