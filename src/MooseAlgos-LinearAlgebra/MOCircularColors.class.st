Class {
	#name : #MOCircularColors,
	#superclass : #Object,
	#instVars : [
		'colors',
		'index'
	],
	#category : #'MooseAlgos-DependencyTable'
}

{ #category : #testing }
MOCircularColors >> atEnd [

	^ index = colors size
]

{ #category : #initialization }
MOCircularColors >> colors: aCollectionOfColors [

	colors := aCollectionOfColors 
]

{ #category : #initialization }
MOCircularColors >> initialize [

	index := 0.
	self colors: Color strongColors 
]

{ #category : #public }
MOCircularColors >> nextColor [

	self atEnd ifTrue: [index := 0].
	index := index + 1.
	^ colors at: index
]
