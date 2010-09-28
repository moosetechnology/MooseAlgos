Class {
	#name : #MalGraphAlgorithm,
	#superclass : #Object,
	#traits : 'MalTGraphBuilder',
	#classTraits : 'MalTGraphBuilder classTrait',
	#instVars : [
		'nodes',
		'edges'
	],
	#category : #'Moose-Algos-Graph'
}

{ #category : #accessing }
MalGraphAlgorithm >> edges [

	^ edges
]

{ #category : #'initialize-release' }
MalGraphAlgorithm >> initialize [

	nodes := OrderedCollection new.
	edges := OrderedCollection new.
]

{ #category : #configuration }
MalGraphAlgorithm >> nodeClass [

	^ MalGraphNode
]

{ #category : #accessing }
MalGraphAlgorithm >> nodes [

	^ nodes
]

{ #category : #private }
MalGraphAlgorithm >> privateEdges: aCollection [

	edges := aCollection 
]

{ #category : #private }
MalGraphAlgorithm >> privateNodes: aCollection [

	nodes := aCollection 
]

{ #category : #running }
MalGraphAlgorithm >> run [

	self subclassResponsibility 
]
