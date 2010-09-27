Class {
	#name : #MADominance,
	#superclass : #MAGraphAlgorithm,
	#category : #'Moose-Algos-Graph'
}

{ #category : #configuration }
MADominance >> nodeClass [

	^ MADominanceNode
]

{ #category : #running }
MADominance >> run [

	| source |
	self nodes do: [ :n | n makeSet ].
	self nodes do: [ :n | n hasUniqueSource ifTrue: [ 
								source := n firstSource.
								source flagUnique.
								source union: n ] ]
]
