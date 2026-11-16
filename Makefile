CFLAGS=-std=c11 -g -static

# コンパイル: chibicc.c → chibicc
compile:
	cc $(CFLAGS) -o chibicc chibicc.c

# アセンブル: tmp.s → tmp
assemble:
	cc -o tmp tmp.s

test: compile
	./test.sh

clean:
	rm -f chibicc *.o *~ tmp*

# Mac からコンテナに入る
shell:
	docker run --rm -it --platform linux/amd64 -v "$(CURDIR)":/work -w /work compilerbook

.PHONY: compile assemble test clean shell
