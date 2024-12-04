

la:
	git stash
	git pull
	./381_tf.sh test ./proj/mips/*.s
	

ga: 
	rm -rf ./output/
	./381_tf.sh test ./proj/mips/*.s -d DEBUG && /home/connero/nvim.appimage ./output/beq_04.s/vsim.log
