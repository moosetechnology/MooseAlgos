Class {
	#name : #MACyclesCoverage,
	#superclass : #MOTarjan,
	#traits : 'MATNormalize',
	#classTraits : 'MATNormalize classTrait',
	#instVars : [
		'circuits',
		'sccExtractorClass',
		'sccExtractor'
	],
	#category : #'Moose-Algos-Graph'
}

{ #category : #accessing }
MACyclesCoverage >> circuits [
	sccExtractor circuits do: [:c |
		circuits add: (c collect: [:n| n model]) ].
	^ circuits
]

{ #category : #running }
MACyclesCoverage >> directCircuit: aCollection [

	^ self normalize: (OrderedCollection with: aCollection first model with: aCollection second model)
]

{ #category : #'as yet unclassified' }
MACyclesCoverage >> initialize [

	super initialize.
	self useNodeDecomposition 
]

{ #category : #running }
MACyclesCoverage >> run [

	super run.
	circuits := OrderedCollection new.
	sccExtractor := sccExtractorClass new.
	self stronglyConnectedComponents do: [:scc|
		(scc size > 2) ifTrue: [
			sccExtractor nodes: scc.
			"graph injection remove outgoing edges from SCC"
			sccExtractor edges: scc from: #yourself toAll: #nextNodes.
			sccExtractor run ].
		(scc size = 2) ifTrue: [
			circuits add: (self directCircuit: scc) ]. "direct circuit"
		]
]

{ #category : #running }
MACyclesCoverage >> useCircuitSpan [

	sccExtractorClass := MACircuitSpanningEdges  
]

{ #category : #running }
MACyclesCoverage >> useEdgeDecomposition [

	sccExtractorClass := MASccEdgeDecomposition 
]

{ #category : #running }
MACyclesCoverage >> useNodeDecomposition [

	sccExtractorClass := MASccNodeDecomposition 
]
