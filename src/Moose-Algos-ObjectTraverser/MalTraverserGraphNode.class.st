Class {
	#name : #MalTraverserGraphNode,
	#superclass : #MalGraphNode,
	#traits : 'MalTNodeNode',
	#classTraits : 'MalTNodeNode classTrait',
	#instVars : [
		'previousNodes',
		'nextNodes'
	],
	#category : #'Moose-Algos-ObjectTraverser'
}

{ #category : #accessing }
MalTraverserGraphNode >> from: sourceNode [

	self previousNodes add: sourceNode 
]

{ #category : #'initialize-release' }
MalTraverserGraphNode >> initialize [

	previousNodes := OrderedCollection new.
	nextNodes := OrderedCollection new.
]

{ #category : #testing }
MalTraverserGraphNode >> isLeaf [
	^ self nextNodes isEmpty
]

{ #category : #testing }
MalTraverserGraphNode >> isRoot [
	^ self previousNodes isEmpty
]

{ #category : #accessing }
MalTraverserGraphNode >> nextNodes [
	^ nextNodes
]

{ #category : #accessing }
MalTraverserGraphNode >> nextNodes: anObject [
	nextNodes := anObject
]

{ #category : #accessing }
MalTraverserGraphNode >> previousNodes [
	^ previousNodes
]

{ #category : #accessing }
MalTraverserGraphNode >> previousNodes: anObject [
	previousNodes := anObject
]

{ #category : #accessing }
MalTraverserGraphNode >> to: targetNode [

	self nextNodes add: targetNode 
]
