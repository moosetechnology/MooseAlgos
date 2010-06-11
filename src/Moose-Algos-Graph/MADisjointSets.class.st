Class {
	#name : #MADisjointSets,
	#superclass : #MOGraphAlgorithm,
	#instVars : [
		'components'
	],
	#category : #'Moose-Algos-Graph'
}

{ #category : #'as yet unclassified' }
MADisjointSets >> components [

	^ (components keys collect: [:parent| 
		(components at: parent) collect: [:n| n model] ]) asOrderedCollection 
]

{ #category : #'as yet unclassified' }
MADisjointSets >> nodeClass [

	^ MANextNode 
]

{ #category : #'as yet unclassified' }
MADisjointSets >> run [

	"partition nodes by connectivity"
	self nodes do: [:n|
		n nextNodes do: [:next | 
			n union: next ]].
	components := Dictionary new.
	self nodes inject: components into: [:d :n |
		(d at: n find ifAbsentPut: [OrderedCollection new]) add: n. d ]
]
