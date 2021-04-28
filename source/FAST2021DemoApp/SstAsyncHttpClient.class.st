Class {
	#name : 'SstAsyncHttpClient',
	#superclass : 'SstHttpClient',
	#category : 'FAST2021DemoApp'
}

{ #category : 'Examples' }
SstAsyncHttpClient class >> fetch: aUrlObject [
	"The following demonstrates how to perform an async GET request
	 at a particular url.  A future that completes with a response object will be answered
	 
	 Arguments:
		aUrlObject - <SstHttpUrl | String>
	 Answers:
		<EsFuture> comples with <SstCommunicationMessage> response"

	| urlObject getClient |

	urlObject := aUrlObject sstAsUrl.
	getClient := self forTransportScheme: urlObject localEndpointUrl transport.
	^(getClient
		then: [:client | client startUp then: [(client get: aUrlObject) ensure: [client shutDown]]])


]

{ #category : 'Examples' }
SstAsyncHttpClient class >> fetchForPeerIdViolation: aUrlObject [
	"The following demonstrates how to perform a GET request
	 at a particular https url which presents an X509 certificate for
	 proof-of-identity
	 
	 Arguments:
		aUrlObject - <SstHttpsUrl | String>
	 Answers:
		<EsFuture> comples with <SstCommunicationMessage> response"

	| urlObject getClient |

	urlObject := aUrlObject sstAsUrl.
	getClient := self forTransportScheme: urlObject localEndpointUrl transport.
	^(getClient then: [:client |
		client startUp then: [
			client requiredPeerName: 'whodo'. "This is unlikely to match the server certificate ID."
			(client get: aUrlObject) ensure: [client shutDown]]])


]

{ #category : 'Examples' }
SstAsyncHttpClient class >> fetchHead: aUrlObject [
	"The following demonstrates how to perform a HEAD request
	 at a particular url.  A response object will be answered
	 
	 Arguments:
		aUrlObject - <SstHttpUrl | String>
	 Answers:
		<EsFuture> comples with <SstCommunicationMessage> response"

	| urlObject getClient |

	urlObject := aUrlObject sstAsUrl.
	getClient := self forTransportScheme: urlObject localEndpointUrl transport.
	^(getClient
		then: [:client | client startUp then: [(client head: aUrlObject) ensure: [client shutDown]]])


]

{ #category : 'Creation' }
SstAsyncHttpClient class >> forConfiguration: anHttpConfiguration [
	"Answer a new initialized instance of this http client
	 with the transport scheme set
	 
	 Arguments:
		schemeId - <String>
	 Answers:
		<EsFuture> completing with <SstHttpClient>"

	| promise |

	promise := EsPromise new.
	[promise complete: (self basicNew initializeForConfiguration: anHttpConfiguration)]
		on: Exception
		do: [:ex | promise completeError: ex stackTrace: (EsAsyncStackTrace for: ex)].
	^promise future
]

{ #category : 'Creation' }
SstAsyncHttpClient class >> forTransportScheme: schemeId [
	"Answer a new initialized instance of this http client
	 with the transport scheme set
	 
	 Arguments:
		schemeId - <String>
	 Answers:
		<EsFuture> completing with <SstHttpClient>"

	| promise |

	promise := EsPromise new.
	[promise complete: (super forTransportScheme: schemeId)]
		on: Exception
		do: [:ex | promise completeError: ex stackTrace: (EsAsyncStackTrace for: ex)].
	^promise future
]

{ #category : 'SST-Internal',
  #vaVisibility : 'private' }
SstAsyncHttpClient >> createAndSendRequestFor: aUrlObject typed: mediaType using: authCredentials withHeaders: headers templateMessage: templateMessage data: data [

	| promise |

	promise := EsPromise new.
	[
		[| response |
			response :=
				super
					createAndSendRequestFor: aUrlObject
					typed: mediaType
					using: authCredentials
					withHeaders: headers
					templateMessage: templateMessage
					data: data.
			promise complete: response]
				on: Exception
				do: [:ex | promise completeError: ex stackTrace: (EsAsyncStackTrace for: ex)]]
					fork.
	^promise future
]

{ #category : 'SST-Accessing' }
SstAsyncHttpClient >> shutDown [
	"Perform a synchronized shutdown the receiver and close any connections
	 Answer a future that completes with this client object when done"
	
	| promise |

	promise := EsPromise new.
	[
		[
			super shutDown.
			promise complete: self]
				on: Exception
				do: [:ex | promise completeError: ex stackTrace: (EsAsyncStackTrace for: ex)]]
					fork.
	^promise future
]

{ #category : 'SST-Accessing' }
SstAsyncHttpClient >> startUp [
	"Start up the client connection asynchronously for the specified transport scheme
	 Configure the proxy url if necessary
	 
	 Answers:
		<EsFuture> completing with <SstHttpClient>"

	| promise |

	promise := EsPromise new.
	[
		[
			super startUp.
			promise complete: self]
				on: Exception
				do: [:ex | promise completeError: ex stackTrace: (EsAsyncStackTrace for: ex)]]
					fork.
	^promise future
]
