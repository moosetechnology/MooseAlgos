Class {
	#name : #MASccNodeDecomposition,
	#superclass : #MASccExtractor,
	#traits : 'MATNormalize',
	#classTraits : 'MATNormalize classTrait',
	#category : #'Moose-Algos-Graph'
}

{ #category : #running }
MASccNodeDecomposition >> nodeClass [

	^ MASndNode
]

{ #category : #running }
MASccNodeDecomposition >> retrieveCircuit: aNode [

	|c n i|
	c := OrderedCollection new.
	i := aNode.
	[ i notNil ] whileTrue: [
		c addFirst: i model.
		i := i bfsAncestor.
	].
	^ c
]

{ #category : #running }
MASccNodeDecomposition >> run [

	self nodes do: [:n|
		self run: n
	]
]

{ #category : #running }
MASccNodeDecomposition >> run: aNode [

	| fifo visited ancestors |
	visited := Set new.
	ancestors := aNode previousNodes.
	aNode bfsAncestor: nil.
	fifo := OrderedCollection with: aNode.
	[ancestors isEmpty] whileFalse: [ |p|
		p := fifo removeFirst.
		p nextNodes do: [:next|
			((visited includes: next) or: [fifo includes: next])
				ifFalse: [
					next bfsAncestor: p.
					fifo addLast: next ].
			(ancestors includes: next)
				ifTrue: [ |c|
					c := self retrieveCircuit: next.
					self addCircuit: (self normalize: c).
					ancestors remove: next ]
		].
		visited add: p ]
]
