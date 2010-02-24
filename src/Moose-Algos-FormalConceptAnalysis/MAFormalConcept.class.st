Class {
	#name : #MAFormalConcept,
	#superclass : #Object,
	#instVars : [
		'context',
		'intent',
		'extent'
	],
	#category : #'Moose-Algos-FormalConceptAnalysis'
}

{ #category : #'instance creation' }
MAFormalConcept class >> on: formalContext extent: objectsMask intent: attributesMask [
	
	^(self new on: formalContext)
		extent: objectsMask;
		intent: attributesMask;
		yourself
]

{ #category : #accessing }
MAFormalConcept >> attributes [
	
	^context attributes selectMask: intent
]

{ #category : #accessing }
MAFormalConcept >> extent [
	
	^extent
]

{ #category : #'initialize-release' }
MAFormalConcept >> extent: anObject [
	
	extent := anObject
]

{ #category : #accessing }
MAFormalConcept >> intent [
	
	^intent
]

{ #category : #'initialize-release' }
MAFormalConcept >> intent: anObject [
	
	intent := anObject
]

{ #category : #accessing }
MAFormalConcept >> numAttributes [
	
	^intent cardinality
]

{ #category : #accessing }
MAFormalConcept >> numObjects [
	
	^extent cardinality
]

{ #category : #accessing }
MAFormalConcept >> objects [
	
	^context objects selectMask: extent
]

{ #category : #'initialize-release' }
MAFormalConcept >> on: formalContext [
	
	context := formalContext
]

{ #category : #printing }
MAFormalConcept >> printOn: stream [
	
	stream
		nextPut: ${;
		nextPut: ${.
	self objects
		do: [:each | stream print: each]
		separatedBy:
			[stream
				nextPut: $,;
				space].
	stream
		nextPut: $};
		nextPut: $,;
		space;
		nextPut: ${.
	self attributes
		do: [:each | stream print: each]
		separatedBy:
			[stream
				nextPut: $,;
				space].
	stream
		nextPut: $};
		nextPut: $}
]
