Class {
	#name : #MalHgPropagatedEdge,
	#superclass : #MalHgEdge,
	#category : #'Moose-Algos-HierarchicalGraph'
}

{ #category : #'instance creation' }
MalHgPropagatedEdge class >> with: aModel from: srcNode to: dstNode [
	| edge |
	edge := MalHgPropagatedEdge new.
	edge model: aModel.
	edge from: srcNode.
	edge to: dstNode.
	^ edge.
]
