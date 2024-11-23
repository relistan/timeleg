build:
	./leg times.leg > times.c
	cc *.c -o times
	@./test.sh
