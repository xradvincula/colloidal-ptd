SHELL := /bin/bash
.PHONY : transform

# examples
# make RUNS=25 SRC=dump.3Dcolloid.13.xyz TS=3000 DIA=1.000 DEN=38.1971186342054884
transform:
	python extract.py $(SRC) $(TS) > colloid_$(TS).xyz
	obabel -ixyz colloid_$(TS).xyz -olmpdat -O traj-$(TS).data
	# extract atoms section
	awk 'NF >= 7 { print }' < traj-$(TS).data > $(TS)-atoms.tmp
	# remove column 2 and 4, add diamter and density columns
	awk '{ print $$1 " " $$3 " " $$5 " " $$6 " " $$7 " " "$(DIA)" " " "$(DEN)" " 0.000" }' < $(TS)-atoms.tmp > $(TS)-atoms-fmt.tmp
	sed '/Atoms/q' < traj-$(TS).data > $(TS)-header.tmp
	# remove last line ("Atoms")
	sed -i '' -e '$$ d' $(TS)-header.tmp
	# reconstruct new file
	cat $(TS)-header.tmp <(echo "Atoms") <(echo) $(TS)-atoms-fmt.tmp > traj-$(TS).fmt.data
	# remove tmp files
	rm $(TS)-atoms.tmp
	rm $(TS)-atoms-fmt.tmp
	rm $(TS)-header.tmp
	@-rm colloid_$(TS).xyz || true
	@-rm traj-$(TS).data || true
	# rename final file
	mv traj-$(TS).fmt.data trajectory-frame-$(TS).data
	# generate plumed files
	./gen-plumed.sh $(RUNS) trajectory-frame-$(TS).data
	# finish generating historical runs file
	echo "make RUNS=$(RUNS) SRC=$(SRC) TS=$(TS) DEN=$(DEN) DIA=$(DIA)" >> run-seeds
	echo "==<" >> run-seeds
	# bring everything into one directory
	mkdir $(TS)-$(RUNS)
	mv trajectory-frame-$(TS).data $(TS)-$(RUNS)
	cp plumed-automation/* $(TS)-$(RUNS)
	rm $(TS)-$(RUNS)/in.3Dcolloid.template
	rm $(TS)-$(RUNS)/plumed.template.dat
	# remove plumed automation generated files
	find plumed-automation -type f -name 'plumed.[0-9]*.dat' -delete
	rm plumed-automation/in.3Dcolloid
	# copy generated files to cluster
	scp -r $(TS)-$(RUNS) matteo:~/runs/

# make run-simulation RUNS=25 SRC=dump.3Dcolloid.13.xyz TS=3000 DIA=1.000 DEN=38.1971186342054884
run-simulation: transform
	ssh matteo 'pushd ~/runs/$(TS)-$(RUNS); nohup mpirun -np 8 lmp -in in.3Dcolloid > nohup.out &' 

# make basins RUNS=25 SRC=dump.3Dcolloid.13.xyz TS=3000 DIA=1.000 DEN=38.1971186342054884
basins: run-simulation
	# committor analysis
	./committor-analysis.sh $(TS) $(RUNS) > out.tmp
	ssh matteo < out.tmp > prob-basin-$(TS)-$(RUNS)
	
# make clean TS=3000 RUNS=25
clean:
	@-rm "$(TS)-atoms.tmp" || true
	@-rm "$(TS)-atoms-fmt.tmp" || true
	@-rm "$(TS)-header.tmp" || true
	@-rm colloid_$(TS).xyz || true
	@-rm "traj-$(TS).data" || true
	@-rm "traj-$(TS).fmt.data" || true
	@-rm trajectory-frame-$(TS).data || true
	@-rm out.tmp || true 
	# clean stuff from the plumed-automation directory
	@-find plumed-automation -type f -name 'plumed.[0-9]*.dat' -delete
	@-rm plumed-automation/in.3Dcolloid
	@-rm -rf $(TS)-$(RUNS)

# make clean-remote TS=3000 RUNS=25
clean-remote:
	ssh socrates "rm -rf $(TS)-$(RUNS)"
	ssh socrates "ssh matteo 'rm -rf ~/runs/$(TS)-$(RUNS)'"

# make clean-all TS=3000 RUNS=25
clean-all: clean clean-remote
