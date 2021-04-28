| writer path |
path := (CfsPath named: '<insert path to root fast2021-futures-demo-vast local repo here>').
writer := TonelWriter new.
writer
	addLatestConfigurationMapNamed: 'FAST 2021 - Demo';
  addLatestConfigurationMapNamed: 'FAST 2021 - Demo Runtime';
	addApplicationsFromConfigurationMaps.
writer writeProjectInto: path.
