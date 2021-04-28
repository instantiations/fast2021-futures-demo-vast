| loader path |
path := (CfsPath named: '<insert path to root fast2021-futures-demo-vast local repo here>').
loader := TonelLoader readFromPath: path.
loader
	beUnattended;
	useGitVersion.
loader loadAllMapsWithRequiredMaps.
