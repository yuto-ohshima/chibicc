CFLAGS=-std=c11 -g -static

# x86-64 Linux 環境 (Apple Silicon でも Rosetta/QEMU 経由で動く)
DOCKER_IMAGE=compilerbook
DOCKER_RUN=docker run --rm --platform linux/amd64 -v "$(CURDIR)":/work -w /work

chibicc: chibicc.c

test: chibicc
	./test.sh

clean:
	rm -f chibicc *.o *~ tmp*

# --- Docker 経由で実行するターゲット (ホストの Mac から使う) ---

# ホスト側でビルドされたバイナリと混ざらないよう clean してからビルド・テスト
docker-test:
	$(DOCKER_RUN) $(DOCKER_IMAGE) make clean test

# コンテナ内のシェルに入る
docker-shell:
	$(DOCKER_RUN) -it $(DOCKER_IMAGE) bash

.PHONY: test clean docker-test docker-shell
