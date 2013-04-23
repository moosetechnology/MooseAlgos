Class {
	#name : #MalHgEdge,
	#superclass : #MalGraphEdge,
	#category : #'Moose-Algos-HierarchicalGraph'
}

{ #category : #'instance creation' }
MalHgEdge class >> with: aModel from: srcNode to: dstNode [
	| edge |
	edge := MalHgEdge new.
	edge model: aModel.
	edge from: srcNode.
	edge to: dstNode.
	^ edge.
]
