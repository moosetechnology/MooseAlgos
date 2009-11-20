Class {
	#name : #Unlimited,
	#superclass : #Magnitude,
	#classVars : [
		'Negative',
		'Positive'
	],
	#category : #'Moose-Algos-LinearAlgebra'
}

{ #category : #'as yet unclassified' }
Unlimited class >> negative [

	^Negative ifNil: [Negative := self new initializeWith: false]
]

{ #category : #'as yet unclassified' }
Unlimited class >> new [

	^self positive
]

{ #category : #'as yet unclassified' }
Unlimited class >> positive [

	^Positive ifNil: [Positive := self new initializeWith: true ]
]

{ #category : #'as yet unclassified' }
Unlimited >> < aMagnitude [
	"Any number is larger than Unlimited negative, except Unlimited negative itself."

	^(positive not) and: [ self ~~ aMagnitude ]
]

{ #category : #'as yet unclassified' }
Unlimited >> = aMagnitude [
	
	^self == aMagnitude
]

{ #category : #'as yet unclassified' }
Unlimited >> hash [

	^positive 
		ifTrue: [ 16r3FFF ]
		ifFalse: [ 16rBFFF ]
]

{ #category : #'as yet unclassified' }
Unlimited >> initializeWith: isPositive [

	positive := isPositive.
	^self
]

{ #category : #'as yet unclassified' }
Unlimited >> negated [

	^self positive 
		ifTrue: [ self class negative ] 
		ifFalse: [ self class positive ]
]

{ #category : #'as yet unclassified' }
Unlimited >> negative [

	^positive not
]

{ #category : #'as yet unclassified' }
Unlimited >> positive [

	^positive
]
