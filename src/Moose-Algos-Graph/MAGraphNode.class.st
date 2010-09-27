Class {
	#name : #MAGraphNode,
	#superclass : #Object,
	#instVars : [
		'model'
	],
	#category : #'Moose-Algos-Graph'
}

{ #category : #'as yet unclassified' }
MAGraphNode class >> with: aModel [

	^ self new model: aModel
]

{ #category : #accessing }
MAGraphNode >> from: sourceNode [
]

{ #category : #accessing }
MAGraphNode >> from: sourceNode edge: anEdge [
]

{ #category : #accessing }
MAGraphNode >> label [

	^ 'N '
]

{ #category : #accessing }
MAGraphNode >> model [
	^ model
]

{ #category : #accessing }
MAGraphNode >> model: aModel [

	model := aModel
]

{ #category : #accessing }
MAGraphNode >> printString [

	^ self label, self model printString
]

{ #category : #accessing }
MAGraphNode >> to: targetNode [
]

{ #category : #accessing }
MAGraphNode >> to: targetNode edge: anEdge [
]
