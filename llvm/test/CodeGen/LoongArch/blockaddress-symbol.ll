; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc --mtriple=loongarch32 -mattr=+d < %s | FileCheck %s
; RUN: llc --mtriple=loongarch64 -mattr=+d < %s | FileCheck %s
; RUN: llc --mtriple=loongarch32 -mattr=+d --no-integrated-as < %s | FileCheck %s
; RUN: llc --mtriple=loongarch64 -mattr=+d --no-integrated-as < %s | FileCheck %s

;; This regression test is for ensuring the AsmParser does not use the
;; getOrCreateSymbol interface to create blockaddress symbols.
;; Otherwise incorrect symbols will be created:
;; `.Ltmp0` -> `.Ltmp00`.

define void @operand_block_address() nounwind {
; CHECK-LABEL: operand_block_address:
; CHECK:       # %bb.0:
; CHECK-NEXT:    #APP
; CHECK-NEXT:    b .Ltmp0
; CHECK-NEXT:    #NO_APP
; CHECK-NEXT:  .Ltmp0: # Block address taken
; CHECK-NEXT:  # %bb.1: # %bb
; CHECK-NEXT:    ret
  call void asm sideeffect "b $0", "i"(ptr blockaddress(@operand_block_address, %bb))
  br label %bb
bb:
  ret void
}
