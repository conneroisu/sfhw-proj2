# Makefile

.PHONY: test-all
test-all:
	@echo "Launching all questasim tests in test directory..."
	sh cmd/run-all.sh proj/test

.PHONY: test-sc
test-sc:
	cd ./src_sc/ && ./381_tf.sh test ./proj/mips/*.s

.PHONY: test-hw
test-hw:
	cd ./src_hw/ && ./381_tf.sh test ./proj/mips/*.s

.PHONY: test-sw
test-sw:
	cd ./src_sw/ && ./381_tf.sh test ./proj/mips/*.s
