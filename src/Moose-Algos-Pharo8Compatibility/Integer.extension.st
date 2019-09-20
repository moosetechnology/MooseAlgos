Extension { #name : #Integer }

{ #category : #'*Moose-Algos-Pharo8Compatibility' }
Integer >> byteAt: index [
	^ self digitAt: index
]

{ #category : #'*Moose-Algos-Pharo8Compatibility' }
Integer >> bytesCount [
	^ self digitLength
]
