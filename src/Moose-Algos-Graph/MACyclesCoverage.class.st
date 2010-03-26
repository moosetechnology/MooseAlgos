Class {
	#name : #MACyclesCoverage,
	#superclass : #MOTarjan,
	#traits : 'MATNormalize',
	#classTraits : 'MATNormalize classTrait',
	#instVars : [
		'circuits',
		'sccExtractorClass'
	],
	#category : #'Moose-Algos-Graph'
}

{ #category : #accessing }
MACyclesCoverage >> circuits [
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

{ #category : #accessing }
MACyclesCoverage >> retrieveCircuitsFromSccExtractor: sccExtractor [

	sccExtractor circuits do: [:c |
		circuits add: (c collect: [:n| n model]) ]
]

{ #category : #running }
MACyclesCoverage >> run [

	super run.
	circuits := OrderedCollection new.
	self stronglyConnectedComponents do: [:scc|
		(scc size > 2) ifTrue: [|sccExtractor|
			sccExtractor := sccExtractorClass new.
			sccExtractor nodes: scc.
			"graph injection remove outgoing edges from SCC"
			sccExtractor edges: scc from: #yourself toAll: #nextNodes.
			sccExtractor run.
			self retrieveCircuitsFromSccExtractor: sccExtractor ].
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
