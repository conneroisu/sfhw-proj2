all: generate

.PHONY: generate
generate:
	@echo "Launching questasim in test directory..."
	cd proj/test; pwd; questasim .

