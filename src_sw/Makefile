

test:
	./381_tf.sh test ./proj/mips/*.s

test-pull:
	git stash
	git pull
	./381_tf.sh test ./proj/mips/*.s
	
test-pull-rep:
	while git stash && git pull && ./381_tf.sh test ./proj/mips/*.s; do :; done
