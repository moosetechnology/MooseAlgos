Class {
	#name : #MalGraphTraverser,
	#superclass : #MalObjectTraverser,
	#instVars : [
		'graph'
	],
	#category : #'Moose-Algos-ObjectTraverser'
}

{ #category : #private }
MalGraphTraverser >> actOnObject: anObject [
	graph nodes: {anObject}
]

{ #category : #private }
MalGraphTraverser >> actOnRelationFrom: originObject to: targetObject [
	^ graph edges: {originObject} from: [ :x | targetObject ] to: [ :x | x ]
]

{ #category : #accessing }
MalGraphTraverser >> graph [
	^ graph
]

{ #category : #accessing }
MalGraphTraverser >> graph: anObject [
	graph := anObject
]

{ #category : #private }
MalGraphTraverser >> initialize [ 
	super initialize.
	graph := MalGraphStructure new nodeClass: MalTraverserGraphNode; yourself.
]
