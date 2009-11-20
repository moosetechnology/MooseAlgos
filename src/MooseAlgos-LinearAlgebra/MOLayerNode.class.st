Class {
	#name : #MOLayerNode,
	#superclass : #MOGraphNode,
	#instVars : [
		'layer',
		'nextNodes',
		'nextCyclicNodes',
		'fillColor',
		'borderColor'
	],
	#category : #'MooseAlgos-DependencyTable'
}

{ #category : #accessing }
MOLayerNode >> borderColor [
	^ borderColor
]

{ #category : #accessing }
MOLayerNode >> borderColor: anObject [
	borderColor := anObject
]

{ #category : #accessing }
MOLayerNode >> commonNodes: aLayerNode [
	"refactor to trait - MOCycleEdge"
	^ self nodes intersection: aLayerNode nodes
]

{ #category : #accessing }
MOLayerNode >> fillColor [
	^ fillColor
]

{ #category : #accessing }
MOLayerNode >> fillColor: anObject [
	fillColor := anObject
]

{ #category : #'initialize-release' }
MOLayerNode >> initialize [

	nextNodes := OrderedCollection new.
	borderColor := Color black.
	fillColor := Color white.
]

{ #category : #accessing }
MOLayerNode >> label [

	^ 'L '
]

{ #category : #accessing }
MOLayerNode >> layer [
	^ layer
]

{ #category : #accessing }
MOLayerNode >> layer: anObject [
	layer := anObject
]

{ #category : #accessing }
MOLayerNode >> model [
	^ model
]

{ #category : #accessing }
MOLayerNode >> model: anObject [
	model := anObject
]

{ #category : #accessing }
MOLayerNode >> nextCyclicNodes [
	^ nextCyclicNodes
]

{ #category : #accessing }
MOLayerNode >> nextCyclicNodes: anObject [
	nextCyclicNodes := anObject
]

{ #category : #accessing }
MOLayerNode >> nextNodes [
	^ nextNodes
]

{ #category : #accessing }
MOLayerNode >> nextNodes: anObject [
	nextNodes := anObject
]

{ #category : #accessing }
MOLayerNode >> nodes [

	^ self nextNodes copyWith: self
]

{ #category : #accessing }
MOLayerNode >> similarity: aLayerNode [
	"refactor to trait - MOCycleEdge"
	^ (self commonNodes: aLayerNode) size
]

{ #category : #accessing }
MOLayerNode >> to: aNode [

	nextNodes add: aNode
]
