Class {
	#name : #MOHitsNode,
	#superclass : #MOGraphNode,
	#traits : 'MATNodeNode',
	#classTraits : 'MATNodeNode classTrait',
	#instVars : [
		'previousNodes',
		'nextNodes',
		'auth',
		'hub'
	],
	#category : #'Moose-Algos-Graph'
}

{ #category : #accessing }
MOHitsNode >> auth [
	^ auth
]

{ #category : #accessing }
MOHitsNode >> auth: anObject [
	auth := anObject
]

{ #category : #accessing }
MOHitsNode >> hub [
	^ hub
]

{ #category : #accessing }
MOHitsNode >> hub: anObject [
	hub := anObject
]

{ #category : #accessing }
MOHitsNode >> initialize [

	previousNodes := OrderedCollection new.
	nextNodes := OrderedCollection new.
]

{ #category : #printing }
MOHitsNode >> label [

	^ 'H '
]

{ #category : #accessing }
MOHitsNode >> nextNodes [
	^ nextNodes
]

{ #category : #accessing }
MOHitsNode >> previousNodes [
	^ previousNodes
]

{ #category : #printing }
MOHitsNode >> printString [

	^ 	'(',
		self model printString,
		' ',
		(self auth printShowingDecimalPlaces: 2),
		' ',
		(self hub printShowingDecimalPlaces: 2),
		') '
]
