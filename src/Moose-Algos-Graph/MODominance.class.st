Class {
	#name : #MODominance,
	#superclass : #MOGraphAlgorithm,
	#category : #'Moose-Algos-Graph'
}

{ #category : #configuration }
MODominance >> nodeClass [

	^ MODominanceNode
]

{ #category : #running }
MODominance >> run [

	| source |
	self nodes do: [ :n | n makeSet ].
	self nodes do: [ :n | n hasUniqueSource ifTrue: [ 
								source := n firstSource.
								source flagUnique.
								source union: n ] ]
]
