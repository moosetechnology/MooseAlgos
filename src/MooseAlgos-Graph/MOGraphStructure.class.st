Class {
	#name : #MOGraphStructure,
	#superclass : #MOGraphAlgorithm,
	#instVars : [
		'nodeClass',
		'edgeClass'
	],
	#category : #'MooseAlgos-Graph'
}

{ #category : #configuration }
MOGraphStructure >> edgeClass [

	^ edgeClass
]

{ #category : #configuration }
MOGraphStructure >> edgeClass: anObject [
	edgeClass := anObject
]

{ #category : #accessing }
MOGraphStructure >> edgeModels [

	^ self edges collect: [:e | e model]
]

{ #category : #configuration }
MOGraphStructure >> nodeClass [

	^ nodeClass
]

{ #category : #configuration }
MOGraphStructure >> nodeClass: anObject [
	nodeClass := anObject
]

{ #category : #accessing }
MOGraphStructure >> nodeModels [

	^ self nodes collect: [:n | n model]
]
