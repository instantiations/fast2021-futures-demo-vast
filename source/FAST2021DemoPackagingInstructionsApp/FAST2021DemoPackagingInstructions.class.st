Class {
	#name : 'FAST2021DemoPackagingInstructions',
	#superclass : 'AbtXDSingleImagePackagingInstructions',
	#category : 'FAST2021DemoPackagingInstructionsApp'
}

{ #category : 'EP-API (Modifiable)' }
FAST2021DemoPackagingInstructions class >> actualIncludedSubApplicationNames [

^((Array basicNew: 90)
	at: 1 put: #'AbtImageSupportApp';
	at: 2 put: #'AbtKernelExtensions';
	at: 3 put: #'AbtWsBatchImageCfsSupportSupApp';
	at: 4 put: #'AbtWsBatchImageSupportSubApp';
	at: 5 put: #'BrotliCompressionApp';
	at: 6 put: #'CfsImplementationUnix';
	at: 7 put: #'CfsPaths';
	at: 8 put: #'CfsStreams';
	at: 9 put: #'CLDT';
	at: 10 put: #'CLIM';
	at: 11 put: #'CommonFileSystem';
	at: 12 put: #'Core';
	at: 13 put: #'CorePI';
	at: 14 put: #'CPM';
	at: 15 put: #'DM';
	at: 16 put: #'EmApplicationSettingsSupport';
	at: 17 put: #'EmApplicationSupport';
	at: 18 put: #'EsAsynchronousCallout';
	at: 19 put: #'EsAsynchronousSupport';
	at: 20 put: #'EsBase64CoderApp';
	at: 21 put: #'EsBatchSupport';
	at: 22 put: #'EsCodePageUtilitiesApp';
	at: 23 put: #'EsCompressionStreamsApp';
	at: 24 put: #'EsLoggingFrameworkApp';
	at: 25 put: #'EsLoggingFrameworkAppenders';
	at: 26 put: #'EsLoggingFrameworkConverters';
	at: 27 put: #'EsLoggingFrameworkFilters';
	at: 28 put: #'EsLoggingFrameworkLayouts';
	at: 29 put: #'EsStackDumpDebugSupport';
	at: 30 put: #'EsStackDumperSupport';
	at: 31 put: #'EsTimeZoneApp';
	at: 32 put: #'EsTimeZoneAppUnix';
	at: 33 put: #'EsTimeZoneAppUnixTzif';
	at: 34 put: #'EsTTYTools';
	at: 35 put: #'EsWaitApp';
	at: 36 put: #'FAST2021DemoApp';
	at: 37 put: #'Kernel';
	at: 38 put: #'LZ4CompressionApp';
	at: 39 put: #'MZZipUnzipApp';
	at: 40 put: #'MZZipUnzipExtensionsApp';
	at: 41 put: #'NeoJSONCoreApp';
	at: 42 put: #'NeoJSONVASTCoreApp';
	at: 43 put: #'OpenSSLCryptoInterfaceApp';
	at: 44 put: #'OpenSSLCryptoInterfaceASN1';
	at: 45 put: #'OpenSSLCryptoInterfaceBIO';
	at: 46 put: #'OpenSSLCryptoInterfaceBN';
	at: 47 put: #'OpenSSLCryptoInterfaceCIPH';
	at: 48 put: #'OpenSSLCryptoInterfaceERR';
	at: 49 put: #'OpenSSLCryptoInterfaceKDF';
	at: 50 put: #'OpenSSLCryptoInterfaceMAC';
	at: 51 put: #'OpenSSLCryptoInterfaceMD';
	at: 52 put: #'OpenSSLCryptoInterfaceMEM';
	at: 53 put: #'OpenSSLCryptoInterfacePKEY';
	at: 54 put: #'OpenSSLCryptoInterfaceRNG';
	at: 55 put: #'OpenSSLCryptoInterfaceX509';
	at: 56 put: #'OsProcessesApp';
	at: 57 put: #'PlatformFramework';
	at: 58 put: #'PlatformInterface';
	at: 59 put: #'SciComBlocking';
	at: 60 put: #'SciComPolled';
	at: 61 put: #'SciComUNIX';
	at: 62 put: #'SciPlatformInterface';
	at: 63 put: #'SciPolledUNIXApp';
	at: 64 put: #'SciSslOpenSSLInterface';
	at: 65 put: #'SciSslOpenSSLInterfaceSSL';
	at: 66 put: #'SciSslSocketInterface';
	at: 67 put: #'SocketCommunicationsInterface';
	at: 68 put: #'SocketFrameworkApp';
	at: 69 put: #'SstCommunications';
	at: 70 put: #'SstDefaultPlatformHttpSupport';
	at: 71 put: #'SstEnhancedSelect';
	at: 72 put: #'SstEnhancedSelectUNIX';
	at: 73 put: #'SstHttpCommunications';
	at: 74 put: #'SstHttpsCommunications';
	at: 75 put: #'SstKernelExtensions';
	at: 76 put: #'SstMarshaling';
	at: 77 put: #'SstMethodInvocation';
	at: 78 put: #'SstNullUnicodeConversion';
	at: 79 put: #'SstSocketCommunications';
	at: 80 put: #'SstSslCommunications';
	at: 81 put: #'SstTcpCommunications';
	at: 82 put: #'SstUNIXSocketCommunications';
	at: 83 put: #'TimeZones';
	at: 84 put: #'XCompatiblePlatformInterface';
	at: 85 put: #'XObsoletePlatformInterface';
	at: 86 put: #'XPlatformAccessors';
	at: 87 put: #'XPlatformExtensions';
	at: 88 put: #'XPlatformFramework';
	at: 89 put: #'XPlatformFunctions';
	at: 90 put: #'ZstdCompressionApp';
	yourself)
]

{ #category : 'Not categorized' }
FAST2021DemoPackagingInstructions class >> applicationLaunchCode [

^'FAST2021Demo asyncProcessCovidData'
]

{ #category : 'EP-API (Modifiable)' }
FAST2021DemoPackagingInstructions class >> applicationNamesToPackage [

^((OrderedCollection new)
	add: #'AbtImageSupportApp';
	add: #'EsTimeZoneApp';
	add: #'EsStackDumperSupport';
	add: #'FAST2021DemoApp';
	yourself)
]

{ #category : 'Not categorized' }
FAST2021DemoPackagingInstructions class >> buildImage [

	| abs |

	abs :=
		(Smalltalk at: #AbsXDBuildSpecification)
			name: 'FAST 2021 Futures Demo'
			mapWithPackagingInstructions: 'FAST 2021 - Demo'
			packagingMapVersion: nil
			packagingInstructions: 'FAST2021DemoPackagingInstructions'
			mapsWithAppsToPackage: #('FAST 2021 - Demo Runtime')
			xdFeatures: #(AbtJSONSupportFeature AbtSstFeature AbtTCPIPFeature)
			xdFeaturesMaps:  #('z.ST: Server, SST')
			xdEnvironment: 'UNIX'
			xdImageSubsystems: nil.
	abs notNil ifTrue: [abs build]
]

{ #category : 'Not categorized' }
FAST2021DemoPackagingInstructions class >> controlPanelName [

^'FAST 2021 Demo'
]

{ #category : 'Not categorized' }
FAST2021DemoPackagingInstructions class >> description [

^'XD Single Runtime-reduced Image for FAST 2021 Demo'
]

{ #category : 'EP-API (Modifiable)' }
FAST2021DemoPackagingInstructions class >> dumperOptions [

^((EpDumperOptions basicNew)
	instVarAt: 1 put: ((Set new)
	add: EpAllStatistics;
	add: EpRemoveCategories;
	add: EpCorrectManagerStructures;
	add: EpRemoveUnusedMetaclasses;
	add: EpCreateSnapshot;
	add: EpMakeCatalogsResident;
	add: EpRemoveSourcePointers;
	add: EpOptimizeAssociations;
	add: EpUniqueEmptyMethodDictionary;
	yourself);
	instVarAt: 2 put: EsRomerImageDumper;
	instVarAt: 3 put: 'FAST2021demo.icx';
	instVarAt: 4 put: '';
	instVarAt: 5 put: nil;
	yourself)
]

{ #category : 'Not categorized' }
FAST2021DemoPackagingInstructions class >> imageFileName [

	^'FAST2021demo.icx'
]

{ #category : 'Not categorized' }
FAST2021DemoPackagingInstructions class >> isKeptByDefault [

	^false
]

{ #category : 'Not categorized' }
FAST2021DemoPackagingInstructions class >> isSavedByDefault [

	^false
]

{ #category : 'Not categorized' }
FAST2021DemoPackagingInstructions class >> packagingRulesFor: aRuleCreationInterface [

	super packagingRulesFor: aRuleCreationInterface.
"	self actualIncludedSubApplicationNames do: [:each |
		aRuleCreationInterface doNotReduceSubApplicationNamed: each.
		aRuleCreationInterface doNotReduceClassNamed: each]"
]

{ #category : 'Not categorized' }
FAST2021DemoPackagingInstructions class >> startUpClassName [

	"For binary stack dump, use AbtStackDumpStartUp. 
	 For interactive remote debugger, use AbtInteractiveDebugStartUp.
	 For regular string-based walkback.log use AbtHeadlessRuntimeStartUp.
	 "

	^#AbtHeadlessRuntimeStartUp
]

{ #category : 'Not categorized' }
FAST2021DemoPackagingInstructions class >> xxxdumperOptions [

	^EpDumperOptions new
		createSnapshot;
		removeCategories;
		removeSourcePointers;
		optimizeAssociations;
		uniqueEmptyMethodDictionary;
		dumperClass: EsRomerImageDumper;
		outputDirectoryName: ''; "$NON-NLS$"
		makeMessageCatalogsResident;
		correctManagerStructures;
		removeUnusedMetaclasses;
		enable: EpAllStatistics;
		imageFileName: self imageFileName;
		yourself
]

{ #category : 'EP-API (Modifiable)' }
FAST2021DemoPackagingInstructions class >> yyydumperOptions [

^((EpDumperOptions basicNew)
	instVarAt: 1 put: ((Set new)
	add: EpMakeCatalogsResident;
	add: EpRemoveCategories;
	add: EpRemoveSourcePointers;
	add: EpOptimizeAssociations;
	add: EpUniqueEmptyMethodDictionary;
	yourself);
	instVarAt: 2 put: EsRomerImageDumper;
	instVarAt: 3 put: (System osType = 'WIN32_NT' ifTrue: ['FAST2021demoWin.icx'] ifFalse: ['FAST2021demoUnix.icx']);
	instVarAt: 4 put: '';
	instVarAt: 5 put: ((OrderedCollection new)
	add: EpCorrectManagerStructures;
	add: EpMakeCatalogsResident;
	add: EpOptimizeAssociations;
	add: EpRemoveCategories;
	add: EpRemoveSourcePointers;
	add: EpRemoveUnusedMetaclasses;
	add: EpUniqueEmptyMethodDictionary;
	add: EpAllStatistics;
	yourself);
	yourself)
]

{ #category : 'Not categorized' }
FAST2021DemoPackagingInstructions class >> zzzdumperOptions [

^((EpDumperOptions basicNew)
	instVarAt: 1 put: ((Set new)
	add: EpAllStatistics;
	add: EpRemoveCategories;
	add: EpCorrectManagerStructures;
	add: EpRemoveUnusedMetaclasses;
	add: EpCreateSnapshot;
	add: EpMakeCatalogsResident;
	add: EpRemoveSourcePointers;
	add: EpOptimizeAssociations;
	add: EpUniqueEmptyMethodDictionary;
	yourself);
	instVarAt: 2 put: EsRomerImageDumper;
	instVarAt: 3 put: 'FAST2021demo.icx';
	instVarAt: 4 put: '';
	instVarAt: 5 put: nil;
	yourself)
]
