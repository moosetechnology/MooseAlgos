Class {
	#name : #MOGraphNode,
	#superclass : #Object,
	#instVars : [
		'model'
	],
	#category : #'MooseAlgos-Graph'
}

{ #category : #'as yet unclassified' }
MOGraphNode class >> with: aModel [

	^ self new model: aModel
]

{ #category : #accessing }
MOGraphNode >> from: sourceNode [
]

{ #category : #accessing }
MOGraphNode >> from: sourceNode edge: anEdge [
]

{ #category : #accessing }
MOGraphNode >> label [

	^ 'N '
]

{ #category : #accessing }
MOGraphNode >> model [
	^ model
]

{ #category : #accessing }
MOGraphNode >> model: aModel [

	model := aModel
]

{ #category : #accessing }
MOGraphNode >> printString [

	^ self label, self model printString
]

{ #category : #accessing }
MOGraphNode >> to: targetNode [
]

{ #category : #accessing }
MOGraphNode >> to: targetNode edge: anEdge [
]
