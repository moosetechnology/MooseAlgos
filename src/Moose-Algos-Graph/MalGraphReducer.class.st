"
The reduced graph of G is the graph G where each strongly connected components was merged into one vertice / node.

circuitsNodes instance variabel will collect all nodes created by merging nodes in a circuit.
"
Class {
	#name : #MalGraphReducer,
	#superclass : #MalGraphAlgorithm,
	#instVars : [
		'circuits',
		'circuitNodes'
	],
	#category : #'Moose-Algos-Graph'
}

{ #category : #updating }
MalGraphReducer >> addCircuitNodes [
	nodes addAll: circuitNodes
]

{ #category : #running }
MalGraphReducer >> findCircuits [
	| tarjanCircuits |
	tarjanCircuits := MalTarjan new
		nodesAndNextFrom: nodes;
		run;
		circuits.
	circuits := tarjanCircuits 
		collect: [ :circuit | 
			circuit collect: [ :each | self findNode: each model ] ]
]

{ #category : #'as yet unclassified' }
MalGraphReducer >> initialize [
	super initialize.
	circuitNodes := OrderedCollection new.
	circuits := OrderedCollection new
]

{ #category : #merging }
MalGraphReducer >> mergeNodesInCircuit: aNodeList [
	circuitNodes add: (self nodeClass new
		mergedNodes: aNodeList;
		model: (aNodeList collect: #model);
		nextNodes: (self nextNodesFor: aNodeList);
		previousNodes: (self previousNodesFor: aNodeList);
		yourself)
]

{ #category : #merging }
MalGraphReducer >> mergeNodesInCircuits [
	circuits do: [ :each | self mergeNodesInCircuit: each ].
	self removeReferencesToMergedNodes.
	self removeMergedNodes.
	self addCircuitNodes
]

{ #category : #computing }
MalGraphReducer >> nextNodesFor: aNodeList [
	"compute next nodes for the future node replacing aNodeList"
	^ ((aNodeList flatCollect: #nextNodes as: Set)
		difference: aNodeList) asArray
]

{ #category : #'as yet unclassified' }
MalGraphReducer >> nodeClass [
	^ MalReducedGraphNode
]

{ #category : #computing }
MalGraphReducer >> previousNodesFor: aNodeList [
	"compute previous nodes for the future node replacing aNodeList"
	^ ((aNodeList flatCollect: #previousNodes as: Set)
		difference: aNodeList) asArray
]

{ #category : #updating }
MalGraphReducer >> removeMergedNodes [
	nodes removeAll: (circuitNodes flatCollect: #mergedNodes)
]

{ #category : #merging }
MalGraphReducer >> removeReferencesToMergedNodes [
	circuitNodes do: [ :circuitNode |
		circuitNode mergedNodes do: [ :mergedNode |
			self updateReferencesTo: mergedNode by: circuitNode ] ]
]

{ #category : #running }
MalGraphReducer >> run [
	self findCircuits.
	self mergeNodesInCircuits.
	^ nodes
]

{ #category : #updating }
MalGraphReducer >> updateReferencesTo: aNode by: anotherNode [
	aNode previousNodes 
		do: [ :node | | index |
				index := node previousNodes indexOf: aNode.
				(index > 0) 
					ifTrue: [ node previousNodes 
									at: index
									put: anotherNode ] ]
]
