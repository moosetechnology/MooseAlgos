Extension { #name : #Number }

{ #category : #'*moose-algos-linearalgebra' }
Number >> dist: aNumber [

	^self < aNumber
		ifTrue: [ aNumber - self ]
		ifFalse: [ self - aNumber ]
]

{ #category : #'*moose-algos-linearalgebra' }
Number >> quotientFromVector: aVector [

	^aVector collect: [ :a | a / self ]
]
