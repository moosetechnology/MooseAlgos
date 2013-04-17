Class {
	#name : #MalHgPropagatedEdge,
	#superclass : #MalHgEdge,
	#category : #'Moose-Algos-HierarchicalGraph'
}

{ #category : #'instance creation' }
MalHgPropagatedEdge class >> with: anEntity source: srcNode destination: dstNode [
	| relationship |
	relationship:= MalHgPropagatedEdge new.
	relationship entity: anEntity.
	relationship source: srcNode.
	relationship destination: dstNode.
	^ relationship.
]
