Class {
	#name : #MASccExtractor,
	#superclass : #MAGraphAlgorithm,
	#instVars : [
		'circuits'
	],
	#category : #'Moose-Algos-Graph'
}

{ #category : #accessing }
MASccExtractor >> addCircuit: aCollectionOfNodes [
	
	circuits add: aCollectionOfNodes
]

{ #category : #accessing }
MASccExtractor >> circuits [
	^ circuits
]

{ #category : #accessing }
MASccExtractor >> initialize [ 

	super initialize.
	circuits := Set new.

]

{ #category : #running }
MASccExtractor >> run [

	self subclassResponsibility
]
