Class {
	#name : #MAGraphAlgorithm,
	#superclass : #Object,
	#traits : 'MATGraphBuilder',
	#classTraits : 'MATGraphBuilder classTrait',
	#instVars : [
		'nodes',
		'edges'
	],
	#category : #'Moose-Algos-Graph'
}

{ #category : #accessing }
MAGraphAlgorithm >> edges [

	^ edges
]

{ #category : #'initialize-release' }
MAGraphAlgorithm >> initialize [

	nodes := OrderedCollection new.
	edges := OrderedCollection new.
]

{ #category : #accessing }
MAGraphAlgorithm >> nodes [

	^ nodes
]

{ #category : #private }
MAGraphAlgorithm >> privateEdges: aCollection [

	edges := aCollection 
]

{ #category : #private }
MAGraphAlgorithm >> privateNodes: aCollection [

	nodes := aCollection 
]

{ #category : #running }
MAGraphAlgorithm >> run [

	self subclassResponsibility 
]
