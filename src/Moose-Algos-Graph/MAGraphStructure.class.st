Class {
	#name : #MAGraphStructure,
	#superclass : #MAGraphAlgorithm,
	#instVars : [
		'nodeClass',
		'edgeClass'
	],
	#category : #'Moose-Algos-Graph'
}

{ #category : #configuration }
MAGraphStructure >> edgeClass [

	^ edgeClass
]

{ #category : #configuration }
MAGraphStructure >> edgeClass: anObject [
	edgeClass := anObject
]

{ #category : #accessing }
MAGraphStructure >> edgeModels [

	^ self edges collect: [:e | e model]
]

{ #category : #configuration }
MAGraphStructure >> nodeClass [

	^ nodeClass
]

{ #category : #configuration }
MAGraphStructure >> nodeClass: anObject [
	nodeClass := anObject
]

{ #category : #accessing }
MAGraphStructure >> nodeModels [

	^ self nodes collect: [:n | n model]
]
