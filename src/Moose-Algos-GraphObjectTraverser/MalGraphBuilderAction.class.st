Class {
	#name : #MalGraphBuilderAction,
	#superclass : #AnObsoleteMalObjectAction,
	#instVars : [
		'graph'
	],
	#category : #'Moose-Algos-GraphObjectTraverser'
}

{ #category : #hooks }
MalGraphBuilderAction >> executeOnObject: anObject [
	^ graph nodes: {anObject}
]

{ #category : #hooks }
MalGraphBuilderAction >> executeOnRelationFrom: originObject to: targetObject [
	^ graph edges: {originObject} from: [ :x | targetObject ] to: [ :x | x ]
]

{ #category : #accessing }
MalGraphBuilderAction >> graph [
	^ graph
]

{ #category : #accessing }
MalGraphBuilderAction >> graph: anObject [
	graph := anObject
]

{ #category : #private }
MalGraphBuilderAction >> initialize [ 
	super initialize.
	graph := MalGraphStructure new nodeClass: MalTraverserGraphNode; yourself.
]
