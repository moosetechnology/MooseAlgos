Extension { #name : #Number }

{ #category : #'*moosealgos-linearalgebra' }
Number >> dist: aNumber [

	^self < aNumber
		ifTrue: [ aNumber - self ]
		ifFalse: [ self - aNumber ]
]

{ #category : #'*moosealgos-linearalgebra' }
Number >> quotientFromVector: aVector [

	^aVector collect: [ :a | a / self ]
]
