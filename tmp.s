.intel_syntax noprefix
.global main
main:
  push 10
  push 10
  pop rdi
  pop rax
  add rax, rdi
  push rax
  push 5
  push 4
  pop rdi
  pop rax
  imul rax, rdi
  push rax
  pop rdi
  pop rax
  sub rax, rdi
  push rax
  push 1
  pop rdi
  pop rax
  sub rax, rdi
  push rax
  pop rax
  ret
