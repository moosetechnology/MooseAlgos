Class {
	#name : #MACyclesCoverage,
	#superclass : #MOTarjan,
	#traits : 'MATNormalize',
	#classTraits : 'MATNormalize classTrait',
	#instVars : [
		'circuits',
		'sed'
	],
	#category : #'Moose-Algos-Graph'
}

{ #category : #accessing }
MACyclesCoverage >> circuits [
	sed circuits do: [:c |
		circuits add: (c collect: [:n| n model]) ].
	^ circuits
]

{ #category : #running }
MACyclesCoverage >> directCircuit: aCollection [

	^ self normalize: (OrderedCollection with: aCollection first model with: aCollection second model)
]

{ #category : #running }
MACyclesCoverage >> run [

	super run.
	circuits := OrderedCollection new.
	sed := MASccEdgeDecomposition new.
	self stronglyConnectedComponents do: [:scc|
		(scc size > 2) ifTrue: [
			sed nodes: scc.
			"graph injection remove outgoing edges from SCC"
			sed edges: scc from: #yourself toAll: #nextNodes.
			sed run ].
		(scc size = 2) ifTrue: [
			circuits add: (self directCircuit: scc) ]. "direct circuit"
		]
]
