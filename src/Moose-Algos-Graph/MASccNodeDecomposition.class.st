Class {
	#name : #MASccNodeDecomposition,
	#superclass : #MASccExtractor,
	#traits : 'MATNormalize',
	#classTraits : 'MATNormalize classTrait',
	#category : #'Moose-Algos-Graph'
}

{ #category : #running }
MASccNodeDecomposition >> nodeClass [

	^ MASndNode
]

{ #category : #running }
MASccNodeDecomposition >> run [

	self nodes do: [:n|
		
	]
]
