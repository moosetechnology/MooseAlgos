Class {
	#name : #MalGraphBuilderStrategy,
	#superclass : #MalActionStrategy,
	#instVars : [
		'graph'
	],
	#category : #'Moose-Algos-GraphObjectTraverser'
}

{ #category : #hooks }
MalGraphBuilderStrategy >> executeOnObject: anObject [
	^ graph nodes: {anObject}
]

{ #category : #hooks }
MalGraphBuilderStrategy >> executeOnRelationFrom: originObject to: targetObject [
	^ graph edges: {originObject} from: [ :x | targetObject ] to: [ :x | x ]
]

{ #category : #accessing }
MalGraphBuilderStrategy >> graph [
	^ graph
]

{ #category : #accessing }
MalGraphBuilderStrategy >> graph: anObject [
	graph := anObject
]

{ #category : #private }
MalGraphBuilderStrategy >> initialize [ 
	super initialize.
	graph := MalGraphStructure new nodeClass: MalTraverserGraphNode; yourself.
]
