"
Signalled when ReadStream>>next encounters a premature end.
"
Class {
	#name : #MOEndOfStream,
	#superclass : #Error,
	#category : #'Moose-Algos-InformationRetrieval'
}

{ #category : #exceptiondescription }
MOEndOfStream >> defaultAction [
	"Answer ReadStream>>next default reply."

	^ nil
]

{ #category : #description }
MOEndOfStream >> isResumable [
	"EndOfStream is resumable, so ReadStream>>next can answer."

	^ true
]
