Class {
	#name : #MACircuitsSpan,
	#superclass : #MOTarjan,
	#instVars : [
		'cse'
	],
	#category : #'Moose-Algos-Graph'
}

{ #category : #accessing }
MACircuitsSpan >> circuits [
	^ cse circuits collect: [:c |
		c collect: [:n| n model ]]
]

{ #category : #running }
MACircuitsSpan >> run [

	super run.
	cse := MACircuitSpanningEdges new.
	self stronglyConnectedComponents do: [:scc|
		(scc size > 1) ifTrue: [
			self flag: #dirtyCode.
			"Dirty on 2 accounts: 
			 - we inject graph model, not the original model, into another graph model
		 	- we iterate over all edges of the graph, not just the ones inside the current SCC "
			cse nodes: scc.
			cse edges: scc from: #yourself toAll: #nextNodes.
			cse run ]]
]
