CFLAGS=-std=c11 -g -static

DOCKER_IMAGE=compilerbook
DOCKER_RUN=docker run --rm --platform linux/amd64 -v "$(CURDIR)":/work -w /work

# chibicc.c をコンパイルして、自作コンパイラ chibicc を作る
chibicc: chibicc.c
	$(CC) $(CFLAGS) -o chibicc chibicc.c

test: chibicc
	./test.sh

clean:
	rm -f chibicc *.o *~ tmp*

# --- Docker 経由で実行するターゲット (ホストの Mac から使う) ---

# コンテナ内で chibicc をビルドだけする
docker-build:
	$(DOCKER_RUN) $(DOCKER_IMAGE) make clean chibicc

# ホスト側でビルドされたバイナリと混ざらないよう clean してからビルド・テスト
docker-test:
	$(DOCKER_RUN) $(DOCKER_IMAGE) make clean test

# コンテナ内のシェルに入る
docker-shell:
	$(DOCKER_RUN) -it $(DOCKER_IMAGE) bash

.PHONY: test clean docker-build docker-test docker-shell
