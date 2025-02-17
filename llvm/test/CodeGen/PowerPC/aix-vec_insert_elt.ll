; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -verify-machineinstrs -mtriple=powerpc64-ibm-aix-xcoff -vec-extabi -mcpu=pwr9 < %s | FileCheck %s -check-prefix=CHECK-64
; RUN: llc -verify-machineinstrs -mtriple=powerpc-ibm-aix-xcoff -vec-extabi -mcpu=pwr9 < %s | FileCheck %s -check-prefix=CHECK-32
; RUN: llc -verify-machineinstrs -mtriple=powerpc64-ibm-aix-xcoff -vec-extabi -mcpu=pwr10 < %s | FileCheck %s -check-prefix=CHECK-64-P10
; RUN: llc -verify-machineinstrs -mtriple=powerpc-ibm-aix-xcoff -vec-extabi -mcpu=pwr10 < %s | FileCheck %s -check-prefix=CHECK-32-P10

; Byte indexed

define <16 x i8> @testByte(<16 x i8> %a, i64 %b, i64 %idx) {
; CHECK-64-LABEL: testByte:
; CHECK-64:       # %bb.0: # %entry
; CHECK-64-NEXT:    addi 5, 1, -16
; CHECK-64-NEXT:    clrldi 4, 4, 60
; CHECK-64-NEXT:    stxv 34, -16(1)
; CHECK-64-NEXT:    stbx 3, 5, 4
; CHECK-64-NEXT:    lxv 34, -16(1)
; CHECK-64-NEXT:    blr
;
; CHECK-32-LABEL: testByte:
; CHECK-32:       # %bb.0: # %entry
; CHECK-32-NEXT:    addi 5, 1, -16
; CHECK-32-NEXT:    clrlwi 3, 6, 28
; CHECK-32-NEXT:    stxv 34, -16(1)
; CHECK-32-NEXT:    stbx 4, 5, 3
; CHECK-32-NEXT:    lxv 34, -16(1)
; CHECK-32-NEXT:    blr
;
; CHECK-64-P10-LABEL: testByte:
; CHECK-64-P10:       # %bb.0: # %entry
; CHECK-64-P10-NEXT:    vinsblx 2, 4, 3
; CHECK-64-P10-NEXT:    blr
;
; CHECK-32-P10-LABEL: testByte:
; CHECK-32-P10:       # %bb.0: # %entry
; CHECK-32-P10-NEXT:    vinsblx 2, 6, 4
; CHECK-32-P10-NEXT:    blr
entry:
  %conv = trunc i64 %b to i8
  %vecins = insertelement <16 x i8> %a, i8 %conv, i64 %idx
  ret <16 x i8> %vecins
}

; Halfword indexed

define <8 x i16> @testHalf(<8 x i16> %a, i64 %b, i64 %idx) {
; CHECK-64-LABEL: testHalf:
; CHECK-64:       # %bb.0: # %entry
; CHECK-64-NEXT:    addi 5, 1, -16
; CHECK-64-NEXT:    rlwinm 4, 4, 1, 28, 30
; CHECK-64-NEXT:    stxv 34, -16(1)
; CHECK-64-NEXT:    sthx 3, 5, 4
; CHECK-64-NEXT:    lxv 34, -16(1)
; CHECK-64-NEXT:    blr
;
; CHECK-32-LABEL: testHalf:
; CHECK-32:       # %bb.0: # %entry
; CHECK-32-NEXT:    addi 5, 1, -16
; CHECK-32-NEXT:    rlwinm 3, 6, 1, 28, 30
; CHECK-32-NEXT:    stxv 34, -16(1)
; CHECK-32-NEXT:    sthx 4, 5, 3
; CHECK-32-NEXT:    lxv 34, -16(1)
; CHECK-32-NEXT:    blr
;
; CHECK-64-P10-LABEL: testHalf:
; CHECK-64-P10:       # %bb.0: # %entry
; CHECK-64-P10-NEXT:    slwi 4, 4, 1
; CHECK-64-P10-NEXT:    vinshlx 2, 4, 3
; CHECK-64-P10-NEXT:    blr
;
; CHECK-32-P10-LABEL: testHalf:
; CHECK-32-P10:       # %bb.0: # %entry
; CHECK-32-P10-NEXT:    slwi 3, 6, 1
; CHECK-32-P10-NEXT:    vinshlx 2, 3, 4
; CHECK-32-P10-NEXT:    blr
entry:
  %conv = trunc i64 %b to i16
  %vecins = insertelement <8 x i16> %a, i16 %conv, i64 %idx
  ret <8 x i16> %vecins
}

; Word indexed

define <4 x i32> @testWord(<4 x i32> %a, i64 %b, i64 %idx) {
; CHECK-64-LABEL: testWord:
; CHECK-64:       # %bb.0: # %entry
; CHECK-64-NEXT:    addi 5, 1, -16
; CHECK-64-NEXT:    rlwinm 4, 4, 2, 28, 29
; CHECK-64-NEXT:    stxv 34, -16(1)
; CHECK-64-NEXT:    stwx 3, 5, 4
; CHECK-64-NEXT:    lxv 34, -16(1)
; CHECK-64-NEXT:    blr
;
; CHECK-32-LABEL: testWord:
; CHECK-32:       # %bb.0: # %entry
; CHECK-32-NEXT:    addi 5, 1, -16
; CHECK-32-NEXT:    rlwinm 3, 6, 2, 28, 29
; CHECK-32-NEXT:    stxv 34, -16(1)
; CHECK-32-NEXT:    stwx 4, 5, 3
; CHECK-32-NEXT:    lxv 34, -16(1)
; CHECK-32-NEXT:    blr
;
; CHECK-64-P10-LABEL: testWord:
; CHECK-64-P10:       # %bb.0: # %entry
; CHECK-64-P10-NEXT:    slwi 4, 4, 2
; CHECK-64-P10-NEXT:    vinswlx 2, 4, 3
; CHECK-64-P10-NEXT:    blr
;
; CHECK-32-P10-LABEL: testWord:
; CHECK-32-P10:       # %bb.0: # %entry
; CHECK-32-P10-NEXT:    slwi 3, 6, 2
; CHECK-32-P10-NEXT:    vinswlx 2, 3, 4
; CHECK-32-P10-NEXT:    blr
entry:
  %conv = trunc i64 %b to i32
  %vecins = insertelement <4 x i32> %a, i32 %conv, i64 %idx
  ret <4 x i32> %vecins
}

; Word immediate

define <4 x i32> @testWordImm(<4 x i32> %a, i64 %b) {
; CHECK-64-LABEL: testWordImm:
; CHECK-64:       # %bb.0: # %entry
; CHECK-64-NEXT:    mtfprwz 0, 3
; CHECK-64-NEXT:    xxinsertw 34, 0, 4
; CHECK-64-NEXT:    xxinsertw 34, 0, 12
; CHECK-64-NEXT:    blr
;
; CHECK-32-LABEL: testWordImm:
; CHECK-32:       # %bb.0: # %entry
; CHECK-32-NEXT:    mtfprwz 0, 4
; CHECK-32-NEXT:    xxinsertw 34, 0, 4
; CHECK-32-NEXT:    xxinsertw 34, 0, 12
; CHECK-32-NEXT:    blr
;
; CHECK-64-P10-LABEL: testWordImm:
; CHECK-64-P10:       # %bb.0: # %entry
; CHECK-64-P10-NEXT:    vinsw 2, 3, 4
; CHECK-64-P10-NEXT:    vinsw 2, 3, 12
; CHECK-64-P10-NEXT:    blr
;
; CHECK-32-P10-LABEL: testWordImm:
; CHECK-32-P10:       # %bb.0: # %entry
; CHECK-32-P10-NEXT:    vinsw 2, 4, 4
; CHECK-32-P10-NEXT:    vinsw 2, 4, 12
; CHECK-32-P10-NEXT:    blr
entry:
  %conv = trunc i64 %b to i32
  %vecins = insertelement <4 x i32> %a, i32 %conv, i32 1
  %vecins2 = insertelement <4 x i32> %vecins, i32 %conv, i32 3
  ret <4 x i32> %vecins2
}

; Doubleword indexed

define <2 x i64> @testDoubleword(<2 x i64> %a, i64 %b, i64 %idx) {
; CHECK-64-LABEL: testDoubleword:
; CHECK-64:       # %bb.0: # %entry
; CHECK-64-NEXT:    addi 5, 1, -16
; CHECK-64-NEXT:    rlwinm 4, 4, 3, 28, 28
; CHECK-64-NEXT:    stxv 34, -16(1)
; CHECK-64-NEXT:    stdx 3, 5, 4
; CHECK-64-NEXT:    lxv 34, -16(1)
; CHECK-64-NEXT:    blr
;
; CHECK-32-LABEL: testDoubleword:
; CHECK-32:       # %bb.0: # %entry
; CHECK-32-NEXT:    add 5, 6, 6
; CHECK-32-NEXT:    addi 7, 1, -32
; CHECK-32-NEXT:    stxv 34, -32(1)
; CHECK-32-NEXT:    rlwinm 6, 5, 2, 28, 29
; CHECK-32-NEXT:    stwx 3, 7, 6
; CHECK-32-NEXT:    addi 3, 5, 1
; CHECK-32-NEXT:    addi 5, 1, -16
; CHECK-32-NEXT:    lxv 0, -32(1)
; CHECK-32-NEXT:    rlwinm 3, 3, 2, 28, 29
; CHECK-32-NEXT:    stxv 0, -16(1)
; CHECK-32-NEXT:    stwx 4, 5, 3
; CHECK-32-NEXT:    lxv 34, -16(1)
; CHECK-32-NEXT:    blr
;
; CHECK-64-P10-LABEL: testDoubleword:
; CHECK-64-P10:       # %bb.0: # %entry
; CHECK-64-P10-NEXT:    rlwinm 4, 4, 3, 0, 28
; CHECK-64-P10-NEXT:    vinsdlx 2, 4, 3
; CHECK-64-P10-NEXT:    blr
;
; CHECK-32-P10-LABEL: testDoubleword:
; CHECK-32-P10:       # %bb.0: # %entry
; CHECK-32-P10-NEXT:    add 5, 6, 6
; CHECK-32-P10-NEXT:    slwi 6, 5, 2
; CHECK-32-P10-NEXT:    vinswlx 2, 6, 3
; CHECK-32-P10-NEXT:    addi 3, 5, 1
; CHECK-32-P10-NEXT:    slwi 3, 3, 2
; CHECK-32-P10-NEXT:    vinswlx 2, 3, 4
; CHECK-32-P10-NEXT:    blr
entry:
  %vecins = insertelement <2 x i64> %a, i64 %b, i64 %idx
  ret <2 x i64> %vecins
}

; Doubleword immediate

define <2 x i64> @testDoublewordImm(<2 x i64> %a, i64 %b) {
; CHECK-64-LABEL: testDoublewordImm:
; CHECK-64:       # %bb.0: # %entry
; CHECK-64-NEXT:    mtfprd 0, 3
; CHECK-64-NEXT:    xxmrghd 34, 34, 0
; CHECK-64-NEXT:    blr
;
; CHECK-32-LABEL: testDoublewordImm:
; CHECK-32:       # %bb.0: # %entry
; CHECK-32-NEXT:    mtfprwz 0, 3
; CHECK-32-NEXT:    xxinsertw 34, 0, 8
; CHECK-32-NEXT:    mtfprwz 0, 4
; CHECK-32-NEXT:    xxinsertw 34, 0, 12
; CHECK-32-NEXT:    blr
;
; CHECK-64-P10-LABEL: testDoublewordImm:
; CHECK-64-P10:       # %bb.0: # %entry
; CHECK-64-P10-NEXT:    vinsd 2, 3, 8
; CHECK-64-P10-NEXT:    blr
;
; CHECK-32-P10-LABEL: testDoublewordImm:
; CHECK-32-P10:       # %bb.0: # %entry
; CHECK-32-P10-NEXT:    vinsw 2, 3, 8
; CHECK-32-P10-NEXT:    vinsw 2, 4, 12
; CHECK-32-P10-NEXT:    blr
entry:
  %vecins = insertelement <2 x i64> %a, i64 %b, i32 1
  ret <2 x i64> %vecins
}

define <2 x i64> @testDoublewordImm2(<2 x i64> %a, i64 %b) {
; CHECK-64-LABEL: testDoublewordImm2:
; CHECK-64:       # %bb.0: # %entry
; CHECK-64-NEXT:    mtfprd 0, 3
; CHECK-64-NEXT:    xxpermdi 34, 0, 34, 1
; CHECK-64-NEXT:    blr
;
; CHECK-32-LABEL: testDoublewordImm2:
; CHECK-32:       # %bb.0: # %entry
; CHECK-32-NEXT:    mtfprwz 0, 3
; CHECK-32-NEXT:    xxinsertw 34, 0, 0
; CHECK-32-NEXT:    mtfprwz 0, 4
; CHECK-32-NEXT:    xxinsertw 34, 0, 4
; CHECK-32-NEXT:    blr
;
; CHECK-64-P10-LABEL: testDoublewordImm2:
; CHECK-64-P10:       # %bb.0: # %entry
; CHECK-64-P10-NEXT:    vinsd 2, 3, 0
; CHECK-64-P10-NEXT:    blr
;
; CHECK-32-P10-LABEL: testDoublewordImm2:
; CHECK-32-P10:       # %bb.0: # %entry
; CHECK-32-P10-NEXT:    vinsw 2, 3, 0
; CHECK-32-P10-NEXT:    vinsw 2, 4, 4
; CHECK-32-P10-NEXT:    blr
entry:
  %vecins = insertelement <2 x i64> %a, i64 %b, i32 0
  ret <2 x i64> %vecins
}

; Float indexed

define <4 x float> @testFloat1(<4 x float> %a, float %b, i32 zeroext %idx1) {
; CHECK-64-LABEL: testFloat1:
; CHECK-64:       # %bb.0: # %entry
; CHECK-64-DAG:     rlwinm 3, 4, 2, 28, 29
; CHECK-64-DAG:     addi 4, 1, -16
; CHECK-64-NEXT:    stxv 34, -16(1)
; CHECK-64-NEXT:    stfsx 1, 4, 3
; CHECK-64-NEXT:    lxv 34, -16(1)
; CHECK-64-NEXT:    blr
;
; CHECK-32-LABEL: testFloat1:
; CHECK-32:       # %bb.0: # %entry
; CHECK-32-NEXT:    rlwinm 3, 4, 2, 28, 29
; CHECK-32-NEXT:    addi 4, 1, -16
; CHECK-32-NEXT:    stxv 34, -16(1)
; CHECK-32-NEXT:    stfsx 1, 4, 3
; CHECK-32-NEXT:    lxv 34, -16(1)
; CHECK-32-NEXT:    blr
;
; CHECK-64-P10-LABEL: testFloat1:
; CHECK-64-P10:       # %bb.0: # %entry
; CHECK-64-P10-NEXT:    xscvdpspn 35, 1
; CHECK-64-P10-NEXT:    extsw 3, 4
; CHECK-64-P10-NEXT:    slwi 3, 3, 2
; CHECK-64-P10-NEXT:    vinswvlx 2, 3, 3
; CHECK-64-P10-NEXT:    blr
;
; CHECK-32-P10-LABEL: testFloat1:
; CHECK-32-P10:       # %bb.0: # %entry
; CHECK-32-P10-NEXT:    xscvdpspn 35, 1
; CHECK-32-P10-NEXT:    slwi 3, 4, 2
; CHECK-32-P10-NEXT:    vinswvlx 2, 3, 3
; CHECK-32-P10-NEXT:    blr
entry:
  %vecins = insertelement <4 x float> %a, float %b, i32 %idx1
  ret <4 x float> %vecins
}

define <4 x float> @testFloat2(<4 x float> %a, ptr %b, i32 zeroext %idx1, i32 zeroext %idx2) {
; CHECK-64-LABEL: testFloat2:
; CHECK-64:       # %bb.0: # %entry
; CHECK-64-NEXT:    lwz 6, 0(3)
; CHECK-64-DAG:     rlwinm 4, 4, 2, 28, 29
; CHECK-64-DAG:     addi 7, 1, -16
; CHECK-64-NEXT:    stxv 34, -16(1)
; CHECK-64-NEXT:    stwx 6, 7, 4
; CHECK-64-NEXT:    rlwinm 4, 5, 2, 28, 29
; CHECK-64-NEXT:    addi 5, 1, -32
; CHECK-64-NEXT:    lxv 0, -16(1)
; CHECK-64-NEXT:    lwz 3, 1(3)
; CHECK-64-NEXT:    stxv 0, -32(1)
; CHECK-64-NEXT:    stwx 3, 5, 4
; CHECK-64-NEXT:    lxv 34, -32(1)
; CHECK-64-NEXT:    blr
;
; CHECK-32-LABEL: testFloat2:
; CHECK-32:       # %bb.0: # %entry
; CHECK-32-NEXT:    lwz 6, 0(3)
; CHECK-32-NEXT:    addi 7, 1, -16
; CHECK-32-NEXT:    rlwinm 4, 4, 2, 28, 29
; CHECK-32-NEXT:    stxv 34, -16(1)
; CHECK-32-NEXT:    rlwinm 5, 5, 2, 28, 29
; CHECK-32-NEXT:    stwx 6, 7, 4
; CHECK-32-NEXT:    addi 4, 1, -48
; CHECK-32-NEXT:    lxv 0, -16(1)
; CHECK-32-NEXT:    lwz 3, 1(3)
; CHECK-32-NEXT:    stxv 0, -48(1)
; CHECK-32-NEXT:    stwx 3, 4, 5
; CHECK-32-NEXT:    lxv 34, -48(1)
; CHECK-32-NEXT:    blr
;
; CHECK-64-P10-LABEL: testFloat2:
; CHECK-64-P10:       # %bb.0: # %entry
; CHECK-64-P10-NEXT:    lwz 6, 0(3)
; CHECK-64-P10-NEXT:    extsw 4, 4
; CHECK-64-P10-NEXT:    lwz 3, 1(3)
; CHECK-64-P10-NEXT:    slwi 4, 4, 2
; CHECK-64-P10-NEXT:    vinswlx 2, 4, 6
; CHECK-64-P10-NEXT:    extsw 4, 5
; CHECK-64-P10-NEXT:    slwi 4, 4, 2
; CHECK-64-P10-NEXT:    vinswlx 2, 4, 3
; CHECK-64-P10-NEXT:    blr
;
; CHECK-32-P10-LABEL: testFloat2:
; CHECK-32-P10:       # %bb.0: # %entry
; CHECK-32-P10-NEXT:    lwz 6, 0(3)
; CHECK-32-P10-NEXT:    lwz 3, 1(3)
; CHECK-32-P10-NEXT:    slwi 4, 4, 2
; CHECK-32-P10-NEXT:    vinswlx 2, 4, 6
; CHECK-32-P10-NEXT:    slwi 4, 5, 2
; CHECK-32-P10-NEXT:    vinswlx 2, 4, 3
; CHECK-32-P10-NEXT:    blr
entry:
  %add.ptr1 = getelementptr inbounds i8, ptr %b, i64 1
  %0 = load float, ptr %b, align 4
  %vecins = insertelement <4 x float> %a, float %0, i32 %idx1
  %1 = load float, ptr %add.ptr1, align 4
  %vecins2 = insertelement <4 x float> %vecins, float %1, i32 %idx2
  ret <4 x float> %vecins2
}

define <4 x float> @testFloat3(<4 x float> %a, ptr %b, i32 zeroext %idx1, i32 zeroext %idx2) {
; CHECK-64-LABEL: testFloat3:
; CHECK-64:       # %bb.0: # %entry
; CHECK-64-NEXT:    lis 6, 1
; CHECK-64-DAG:         rlwinm 4, 4, 2, 28, 29
; CHECK-64-DAG:    addi 7, 1, -16
; CHECK-64-NEXT:    lwzx 6, 3, 6
; CHECK-64-NEXT:    stxv 34, -16(1)
; CHECK-64-NEXT:    stwx 6, 7, 4
; CHECK-64-NEXT:    li 4, 1
; CHECK-64-NEXT:    lxv 0, -16(1)
; CHECK-64-NEXT:    rldic 4, 4, 36, 27
; CHECK-64-NEXT:    lwzx 3, 3, 4
; CHECK-64-NEXT:    rlwinm 4, 5, 2, 28, 29
; CHECK-64-NEXT:    addi 5, 1, -32
; CHECK-64-NEXT:    stxv 0, -32(1)
; CHECK-64-NEXT:    stwx 3, 5, 4
; CHECK-64-NEXT:    lxv 34, -32(1)
; CHECK-64-NEXT:    blr
;
; CHECK-32-LABEL: testFloat3:
; CHECK-32:       # %bb.0: # %entry
; CHECK-32-NEXT:    lis 6, 1
; CHECK-32-NEXT:    addi 7, 1, -16
; CHECK-32-NEXT:    rlwinm 4, 4, 2, 28, 29
; CHECK-32-NEXT:    rlwinm 5, 5, 2, 28, 29
; CHECK-32-NEXT:    lwzx 6, 3, 6
; CHECK-32-NEXT:    stxv 34, -16(1)
; CHECK-32-NEXT:    stwx 6, 7, 4
; CHECK-32-NEXT:    addi 4, 1, -48
; CHECK-32-NEXT:    lxv 0, -16(1)
; CHECK-32-NEXT:    lwz 3, 0(3)
; CHECK-32-NEXT:    stxv 0, -48(1)
; CHECK-32-NEXT:    stwx 3, 4, 5
; CHECK-32-NEXT:    lxv 34, -48(1)
; CHECK-32-NEXT:    blr
;
; CHECK-64-P10-LABEL: testFloat3:
; CHECK-64-P10:       # %bb.0: # %entry
; CHECK-64-P10-NEXT:    plwz 6, 65536(3), 0
; CHECK-64-P10-NEXT:    extsw 4, 4
; CHECK-64-P10-NEXT:    slwi 4, 4, 2
; CHECK-64-P10-NEXT:    vinswlx 2, 4, 6
; CHECK-64-P10-NEXT:    li 4, 1
; CHECK-64-P10-NEXT:    rldic 4, 4, 36, 27
; CHECK-64-P10-NEXT:    lwzx 3, 3, 4
; CHECK-64-P10-NEXT:    extsw 4, 5
; CHECK-64-P10-NEXT:    slwi 4, 4, 2
; CHECK-64-P10-NEXT:    vinswlx 2, 4, 3
; CHECK-64-P10-NEXT:    blr
;
; CHECK-32-P10-LABEL: testFloat3:
; CHECK-32-P10:       # %bb.0: # %entry
; CHECK-32-P10-NEXT:    plwz 6, 65536(3), 0
; CHECK-32-P10-NEXT:    lwz 3, 0(3)
; CHECK-32-P10-NEXT:    slwi 4, 4, 2
; CHECK-32-P10-NEXT:    vinswlx 2, 4, 6
; CHECK-32-P10-NEXT:    slwi 4, 5, 2
; CHECK-32-P10-NEXT:    vinswlx 2, 4, 3
; CHECK-32-P10-NEXT:    blr
entry:
  %add.ptr = getelementptr inbounds i8, ptr %b, i64 65536
  %add.ptr1 = getelementptr inbounds i8, ptr %b, i64 68719476736
  %0 = load float, ptr %add.ptr, align 4
  %vecins = insertelement <4 x float> %a, float %0, i32 %idx1
  %1 = load float, ptr %add.ptr1, align 4
  %vecins2 = insertelement <4 x float> %vecins, float %1, i32 %idx2
  ret <4 x float> %vecins2
}

; Float immediate

define <4 x float> @testFloatImm1(<4 x float> %a, float %b) {
; CHECK-64-LABEL: testFloatImm1:
; CHECK-64:       # %bb.0: # %entry
; CHECK-64-NEXT:    xscvdpspn 0, 1
; CHECK-64-NEXT:    xxinsertw 34, 0, 0
; CHECK-64-NEXT:    xxinsertw 34, 0, 8
; CHECK-64-NEXT:    blr
;
; CHECK-32-LABEL: testFloatImm1:
; CHECK-32:       # %bb.0: # %entry
; CHECK-32-NEXT:    xscvdpspn 0, 1
; CHECK-32-NEXT:    xxinsertw 34, 0, 0
; CHECK-32-NEXT:    xxinsertw 34, 0, 8
; CHECK-32-NEXT:    blr
;
; CHECK-64-P10-LABEL: testFloatImm1:
; CHECK-64-P10:       # %bb.0: # %entry
; CHECK-64-P10-NEXT:    xscvdpspn 0, 1
; CHECK-64-P10-NEXT:    xxinsertw 34, 0, 0
; CHECK-64-P10-NEXT:    xxinsertw 34, 0, 8
; CHECK-64-P10-NEXT:    blr
;
; CHECK-32-P10-LABEL: testFloatImm1:
; CHECK-32-P10:       # %bb.0: # %entry
; CHECK-32-P10-NEXT:    xscvdpspn 0, 1
; CHECK-32-P10-NEXT:    xxinsertw 34, 0, 0
; CHECK-32-P10-NEXT:    xxinsertw 34, 0, 8
; CHECK-32-P10-NEXT:    blr
entry:
  %vecins = insertelement <4 x float> %a, float %b, i32 0
  %vecins1 = insertelement <4 x float> %vecins, float %b, i32 2
  ret <4 x float> %vecins1
}

define <4 x float> @testFloatImm2(<4 x float> %a, ptr %b) {
; CHECK-64-LABEL: testFloatImm2:
; CHECK-64:       # %bb.0: # %entry
; CHECK-64-NEXT:    lwz 4, 0(3)
; CHECK-64-NEXT:    lwz 3, 4(3)
; CHECK-64-NEXT:    mtfprwz 0, 4
; CHECK-64-NEXT:    xxinsertw 34, 0, 0
; CHECK-64-NEXT:    mtfprwz 0, 3
; CHECK-64-NEXT:    xxinsertw 34, 0, 8
; CHECK-64-NEXT:    blr
;
; CHECK-32-LABEL: testFloatImm2:
; CHECK-32:       # %bb.0: # %entry
; CHECK-32-NEXT:    lwz 4, 0(3)
; CHECK-32-NEXT:    lwz 3, 4(3)
; CHECK-32-NEXT:    mtfprwz 0, 4
; CHECK-32-NEXT:    xxinsertw 34, 0, 0
; CHECK-32-NEXT:    mtfprwz 0, 3
; CHECK-32-NEXT:    xxinsertw 34, 0, 8
; CHECK-32-NEXT:    blr
;
; CHECK-64-P10-LABEL: testFloatImm2:
; CHECK-64-P10:       # %bb.0: # %entry
; CHECK-64-P10-NEXT:    lwz 4, 0(3)
; CHECK-64-P10-NEXT:    lwz 3, 4(3)
; CHECK-64-P10-NEXT:    vinsw 2, 4, 0
; CHECK-64-P10-NEXT:    vinsw 2, 3, 8
; CHECK-64-P10-NEXT:    blr
;
; CHECK-32-P10-LABEL: testFloatImm2:
; CHECK-32-P10:       # %bb.0: # %entry
; CHECK-32-P10-NEXT:    lwz 4, 0(3)
; CHECK-32-P10-NEXT:    lwz 3, 4(3)
; CHECK-32-P10-NEXT:    vinsw 2, 4, 0
; CHECK-32-P10-NEXT:    vinsw 2, 3, 8
; CHECK-32-P10-NEXT:    blr
entry:
  %add.ptr1 = getelementptr inbounds i32, ptr %b, i64 1
  %0 = load float, ptr %b, align 4
  %vecins = insertelement <4 x float> %a, float %0, i32 0
  %1 = load float, ptr %add.ptr1, align 4
  %vecins2 = insertelement <4 x float> %vecins, float %1, i32 2
  ret <4 x float> %vecins2
}

define <4 x float> @testFloatImm3(<4 x float> %a, ptr %b) {
; CHECK-64-LABEL: testFloatImm3:
; CHECK-64:       # %bb.0: # %entry
; CHECK-64-NEXT:    lis 4, 4
; CHECK-64-NEXT:    lwzx 4, 3, 4
; CHECK-64-NEXT:    mtfprwz 0, 4
; CHECK-64-NEXT:    li 4, 1
; CHECK-64-NEXT:    rldic 4, 4, 38, 25
; CHECK-64-NEXT:    xxinsertw 34, 0, 0
; CHECK-64-NEXT:    lwzx 3, 3, 4
; CHECK-64-NEXT:    mtfprwz 0, 3
; CHECK-64-NEXT:    xxinsertw 34, 0, 8
; CHECK-64-NEXT:    blr
;
; CHECK-32-LABEL: testFloatImm3:
; CHECK-32:       # %bb.0: # %entry
; CHECK-32-NEXT:    lis 4, 4
; CHECK-32-NEXT:    lwzx 4, 3, 4
; CHECK-32-NEXT:    lwz 3, 0(3)
; CHECK-32-NEXT:    mtfprwz 0, 4
; CHECK-32-NEXT:    xxinsertw 34, 0, 0
; CHECK-32-NEXT:    mtfprwz 0, 3
; CHECK-32-NEXT:    xxinsertw 34, 0, 8
; CHECK-32-NEXT:    blr
;
; CHECK-64-P10-LABEL: testFloatImm3:
; CHECK-64-P10:       # %bb.0: # %entry
; CHECK-64-P10-NEXT:    plwz 4, 262144(3), 0
; CHECK-64-P10-NEXT:    vinsw 2, 4, 0
; CHECK-64-P10-NEXT:    li 4, 1
; CHECK-64-P10-NEXT:    rldic 4, 4, 38, 25
; CHECK-64-P10-NEXT:    lwzx 3, 3, 4
; CHECK-64-P10-NEXT:    vinsw 2, 3, 8
; CHECK-64-P10-NEXT:    blr
;
; CHECK-32-P10-LABEL: testFloatImm3:
; CHECK-32-P10:       # %bb.0: # %entry
; CHECK-32-P10-NEXT:    plwz 4, 262144(3), 0
; CHECK-32-P10-NEXT:    lwz 3, 0(3)
; CHECK-32-P10-NEXT:    vinsw 2, 4, 0
; CHECK-32-P10-NEXT:    vinsw 2, 3, 8
; CHECK-32-P10-NEXT:    blr
entry:
  %add.ptr = getelementptr inbounds i32, ptr %b, i64 65536
  %add.ptr1 = getelementptr inbounds i32, ptr %b, i64 68719476736
  %0 = load float, ptr %add.ptr, align 4
  %vecins = insertelement <4 x float> %a, float %0, i32 0
  %1 = load float, ptr %add.ptr1, align 4
  %vecins2 = insertelement <4 x float> %vecins, float %1, i32 2
  ret <4 x float> %vecins2
}

; Double indexed

define <2 x double> @testDouble1(<2 x double> %a, double %b, i32 zeroext %idx1) {
; CHECK-64-LABEL: testDouble1:
; CHECK-64:       # %bb.0: # %entry
; CHECK-64:         rlwinm 3, 4, 3, 28, 28
; CHECK-64-NEXT:    addi 4, 1, -16
; CHECK-64-NEXT:    stxv 34, -16(1)
; CHECK-64-NEXT:    stfdx 1, 4, 3
; CHECK-64-NEXT:    lxv 34, -16(1)
; CHECK-64-NEXT:    blr
;
; CHECK-32-LABEL: testDouble1:
; CHECK-32:       # %bb.0: # %entry
; CHECK-32-NEXT:    addi 4, 1, -16
; CHECK-32-NEXT:    rlwinm 3, 5, 3, 28, 28
; CHECK-32-NEXT:    stxv 34, -16(1)
; CHECK-32-NEXT:    stfdx 1, 4, 3
; CHECK-32-NEXT:    lxv 34, -16(1)
; CHECK-32-NEXT:    blr
;
; CHECK-64-P10-LABEL: testDouble1:
; CHECK-64-P10:       # %bb.0: # %entry
; CHECK-64-P10-NEXT:    extsw 4, 4
; CHECK-64-P10-NEXT:    mffprd 3, 1
; CHECK-64-P10-NEXT:    rlwinm 4, 4, 3, 0, 28
; CHECK-64-P10-NEXT:    vinsdlx 2, 4, 3
; CHECK-64-P10-NEXT:    blr
;
; CHECK-32-P10-LABEL: testDouble1:
; CHECK-32-P10:       # %bb.0: # %entry
; CHECK-32-P10-DAG:     addi 4, 1, -16
; CHECK-32-P10-DAG:     rlwinm 3, 5, 3, 28, 28
; CHECK-32-P10-NEXT:    stxv 34, -16(1)
; CHECK-32-P10-NEXT:    stfdx 1, 4, 3
; CHECK-32-P10-NEXT:    lxv 34, -16(1)
; CHECK-32-P10-NEXT:    blr
entry:
  %vecins = insertelement <2 x double> %a, double %b, i32 %idx1
  ret <2 x double> %vecins
}

define <2 x double> @testDouble2(<2 x double> %a, ptr %b, i32 zeroext %idx1, i32 zeroext %idx2) {
; CHECK-64-LABEL: testDouble2:
; CHECK-64:       # %bb.0: # %entry
; CHECK-64-NEXT:    ld 6, 0(3)
; CHECK-64-DAG:         rlwinm 4, 4, 3, 28, 28
; CHECK-64-DAG:    addi 7, 1, -32
; CHECK-64-NEXT:    stxv 34, -32(1)
; CHECK-64-NEXT:    stdx 6, 7, 4
; CHECK-64-NEXT:    li 4, 1
; CHECK-64-NEXT:    lxv 0, -32(1)
; CHECK-64-NEXT:    ldx 3, 3, 4
; CHECK-64-NEXT:    rlwinm 4, 5, 3, 28, 28
; CHECK-64-NEXT:    addi 5, 1, -16
; CHECK-64-NEXT:    stxv 0, -16(1)
; CHECK-64-NEXT:    stdx 3, 5, 4
; CHECK-64-NEXT:    lxv 34, -16(1)
; CHECK-64-NEXT:    blr
;
; CHECK-32-LABEL: testDouble2:
; CHECK-32:       # %bb.0: # %entry
; CHECK-32-NEXT:    lfd 0, 0(3)
; CHECK-32-NEXT:    addi 6, 1, -32
; CHECK-32-NEXT:    rlwinm 4, 4, 3, 28, 28
; CHECK-32-NEXT:    stxv 34, -32(1)
; CHECK-32-NEXT:    rlwinm 5, 5, 3, 28, 28
; CHECK-32-NEXT:    stfdx 0, 6, 4
; CHECK-32-NEXT:    lxv 0, -32(1)
; CHECK-32-NEXT:    lfd 1, 1(3)
; CHECK-32-NEXT:    addi 3, 1, -16
; CHECK-32-NEXT:    stxv 0, -16(1)
; CHECK-32-NEXT:    stfdx 1, 3, 5
; CHECK-32-NEXT:    lxv 34, -16(1)
; CHECK-32-NEXT:    blr
;
; CHECK-64-P10-LABEL: testDouble2:
; CHECK-64-P10:       # %bb.0: # %entry
; CHECK-64-P10-NEXT:    ld 6, 0(3)
; CHECK-64-P10-NEXT:    extsw 4, 4
; CHECK-64-P10-NEXT:    pld 3, 1(3), 0
; CHECK-64-P10-NEXT:    rlwinm 4, 4, 3, 0, 28
; CHECK-64-P10-NEXT:    vinsdlx 2, 4, 6
; CHECK-64-P10-NEXT:    extsw 4, 5
; CHECK-64-P10-NEXT:    rlwinm 4, 4, 3, 0, 28
; CHECK-64-P10-NEXT:    vinsdlx 2, 4, 3
; CHECK-64-P10-NEXT:    blr
;
; CHECK-32-P10-LABEL: testDouble2:
; CHECK-32-P10:       # %bb.0: # %entry
; CHECK-32-P10-NEXT:    lfd 0, 0(3)
; CHECK-32-P10-DAG:     addi 6, 1, -32
; CHECK-32-P10-DAG:     rlwinm 4, 4, 3, 28, 28
; CHECK-32-P10-NEXT:    stxv 34, -32(1)
; CHECK-32-P10-NEXT:    rlwinm 5, 5, 3, 28, 28
; CHECK-32-P10-NEXT:    stfdx 0, 6, 4
; CHECK-32-P10-NEXT:    lxv 0, -32(1)
; CHECK-32-P10-NEXT:    plfd 1, 1(3), 0
; CHECK-32-P10-NEXT:    addi 3, 1, -16
; CHECK-32-P10-NEXT:    stxv 0, -16(1)
; CHECK-32-P10-NEXT:    stfdx 1, 3, 5
; CHECK-32-P10-NEXT:    lxv 34, -16(1)
; CHECK-32-P10-NEXT:    blr
entry:
  %add.ptr1 = getelementptr inbounds i8, ptr %b, i64 1
  %0 = load double, ptr %b, align 8
  %vecins = insertelement <2 x double> %a, double %0, i32 %idx1
  %1 = load double, ptr %add.ptr1, align 8
  %vecins2 = insertelement <2 x double> %vecins, double %1, i32 %idx2
  ret <2 x double> %vecins2
}

define <2 x double> @testDouble3(<2 x double> %a, ptr %b, i32 zeroext %idx1, i32 zeroext %idx2) {
; CHECK-64-LABEL: testDouble3:
; CHECK-64:       # %bb.0: # %entry
; CHECK-64-NEXT:    lis 6, 1
; CHECK-64-DAG:     rlwinm 4, 4, 3, 28, 28
; CHECK-64-DAG:     addi 7, 1, -32
; CHECK-64-NEXT:    ldx 6, 3, 6
; CHECK-64-NEXT:    stxv 34, -32(1)
; CHECK-64-NEXT:    stdx 6, 7, 4
; CHECK-64-NEXT:    li 4, 1
; CHECK-64-NEXT:    lxv 0, -32(1)
; CHECK-64-NEXT:    rldic 4, 4, 36, 27
; CHECK-64-NEXT:    ldx 3, 3, 4
; CHECK-64-NEXT:    rlwinm 4, 5, 3, 28, 28
; CHECK-64-NEXT:    addi 5, 1, -16
; CHECK-64-NEXT:    stxv 0, -16(1)
; CHECK-64-NEXT:    stdx 3, 5, 4
; CHECK-64-NEXT:    lxv 34, -16(1)
; CHECK-64-NEXT:    blr
;
; CHECK-32-LABEL: testDouble3:
; CHECK-32:       # %bb.0: # %entry
; CHECK-32-NEXT:    lis 6, 1
; CHECK-32-NEXT:    rlwinm 4, 4, 3, 28, 28
; CHECK-32-NEXT:    rlwinm 5, 5, 3, 28, 28
; CHECK-32-NEXT:    lfdx 0, 3, 6
; CHECK-32-NEXT:    addi 6, 1, -32
; CHECK-32-NEXT:    stxv 34, -32(1)
; CHECK-32-NEXT:    stfdx 0, 6, 4
; CHECK-32-NEXT:    lxv 0, -32(1)
; CHECK-32-NEXT:    lfd 1, 0(3)
; CHECK-32-NEXT:    addi 3, 1, -16
; CHECK-32-NEXT:    stxv 0, -16(1)
; CHECK-32-NEXT:    stfdx 1, 3, 5
; CHECK-32-NEXT:    lxv 34, -16(1)
; CHECK-32-NEXT:    blr
;
; CHECK-64-P10-LABEL: testDouble3:
; CHECK-64-P10:       # %bb.0: # %entry
; CHECK-64-P10-NEXT:    pld 6, 65536(3), 0
; CHECK-64-P10-NEXT:    extsw 4, 4
; CHECK-64-P10-NEXT:    rlwinm 4, 4, 3, 0, 28
; CHECK-64-P10-NEXT:    vinsdlx 2, 4, 6
; CHECK-64-P10-NEXT:    li 4, 1
; CHECK-64-P10-NEXT:    rldic 4, 4, 36, 27
; CHECK-64-P10-NEXT:    ldx 3, 3, 4
; CHECK-64-P10-NEXT:    extsw 4, 5
; CHECK-64-P10-NEXT:    rlwinm 4, 4, 3, 0, 28
; CHECK-64-P10-NEXT:    vinsdlx 2, 4, 3
; CHECK-64-P10-NEXT:    blr
;
; CHECK-32-P10-LABEL: testDouble3:
; CHECK-32-P10:       # %bb.0: # %entry
; CHECK-32-P10-NEXT:    plfd 0, 65536(3), 0
; CHECK-32-P10-DAG:     addi 6, 1, -32
; CHECK-32-P10-DAG:     rlwinm 4, 4, 3, 28, 28
; CHECK-32-P10-NEXT:    stxv 34, -32(1)
; CHECK-32-P10-NEXT:    rlwinm 5, 5, 3, 28, 28
; CHECK-32-P10-NEXT:    stfdx 0, 6, 4
; CHECK-32-P10-NEXT:    lxv 0, -32(1)
; CHECK-32-P10-NEXT:    lfd 1, 0(3)
; CHECK-32-P10-NEXT:    addi 3, 1, -16
; CHECK-32-P10-NEXT:    stxv 0, -16(1)
; CHECK-32-P10-NEXT:    stfdx 1, 3, 5
; CHECK-32-P10-NEXT:    lxv 34, -16(1)
; CHECK-32-P10-NEXT:    blr
entry:
  %add.ptr = getelementptr inbounds i8, ptr %b, i64 65536
  %add.ptr1 = getelementptr inbounds i8, ptr %b, i64 68719476736
  %0 = load double, ptr %add.ptr, align 8
  %vecins = insertelement <2 x double> %a, double %0, i32 %idx1
  %1 = load double, ptr %add.ptr1, align 8
  %vecins2 = insertelement <2 x double> %vecins, double %1, i32 %idx2
  ret <2 x double> %vecins2
}

; Double immediate

define <2 x double> @testDoubleImm1(<2 x double> %a, double %b) {
; CHECK-64-LABEL: testDoubleImm1:
; CHECK-64:       # %bb.0: # %entry
; CHECK-64-NEXT:    # kill: def $f1 killed $f1 def $vsl1
; CHECK-64-NEXT:    xxpermdi 34, 1, 34, 1
; CHECK-64-NEXT:    blr
;
; CHECK-32-LABEL: testDoubleImm1:
; CHECK-32:       # %bb.0: # %entry
; CHECK-32-NEXT:    # kill: def $f1 killed $f1 def $vsl1
; CHECK-32-NEXT:    xxpermdi 34, 1, 34, 1
; CHECK-32-NEXT:    blr
;
; CHECK-64-P10-LABEL: testDoubleImm1:
; CHECK-64-P10:       # %bb.0: # %entry
; CHECK-64-P10-NEXT:    # kill: def $f1 killed $f1 def $vsl1
; CHECK-64-P10-NEXT:    xxpermdi 34, 1, 34, 1
; CHECK-64-P10-NEXT:    blr
;
; CHECK-32-P10-LABEL: testDoubleImm1:
; CHECK-32-P10:       # %bb.0: # %entry
; CHECK-32-P10-NEXT:    # kill: def $f1 killed $f1 def $vsl1
; CHECK-32-P10-NEXT:    xxpermdi 34, 1, 34, 1
; CHECK-32-P10-NEXT:    blr
entry:
  %vecins = insertelement <2 x double> %a, double %b, i32 0
  ret <2 x double> %vecins
}

define <2 x double> @testDoubleImm2(<2 x double> %a, ptr %b) {
; CHECK-64-LABEL: testDoubleImm2:
; CHECK-64:       # %bb.0: # %entry
; CHECK-64-NEXT:    lfd 0, 0(3)
; CHECK-64-NEXT:    xxpermdi 34, 0, 34, 1
; CHECK-64-NEXT:    blr
;
; CHECK-32-LABEL: testDoubleImm2:
; CHECK-32:       # %bb.0: # %entry
; CHECK-32-NEXT:    lfd 0, 0(3)
; CHECK-32-NEXT:    xxpermdi 34, 0, 34, 1
; CHECK-32-NEXT:    blr
;
; CHECK-64-P10-LABEL: testDoubleImm2:
; CHECK-64-P10:       # %bb.0: # %entry
; CHECK-64-P10-NEXT:    lfd 0, 0(3)
; CHECK-64-P10-NEXT:    xxpermdi 34, 0, 34, 1
; CHECK-64-P10-NEXT:    blr
;
; CHECK-32-P10-LABEL: testDoubleImm2:
; CHECK-32-P10:       # %bb.0: # %entry
; CHECK-32-P10-NEXT:    lfd 0, 0(3)
; CHECK-32-P10-NEXT:    xxpermdi 34, 0, 34, 1
; CHECK-32-P10-NEXT:    blr
entry:
  %0 = load double, ptr %b, align 8
  %vecins = insertelement <2 x double> %a, double %0, i32 0
  ret <2 x double> %vecins
}

define <2 x double> @testDoubleImm3(<2 x double> %a, ptr %b) {
; CHECK-64-LABEL: testDoubleImm3:
; CHECK-64:       # %bb.0: # %entry
; CHECK-64-NEXT:    lfd 0, 4(3)
; CHECK-64-NEXT:    xxpermdi 34, 0, 34, 1
; CHECK-64-NEXT:    blr
;
; CHECK-32-LABEL: testDoubleImm3:
; CHECK-32:       # %bb.0: # %entry
; CHECK-32-NEXT:    lfd 0, 4(3)
; CHECK-32-NEXT:    xxpermdi 34, 0, 34, 1
; CHECK-32-NEXT:    blr
;
; CHECK-64-P10-LABEL: testDoubleImm3:
; CHECK-64-P10:       # %bb.0: # %entry
; CHECK-64-P10-NEXT:    lfd 0, 4(3)
; CHECK-64-P10-NEXT:    xxpermdi 34, 0, 34, 1
; CHECK-64-P10-NEXT:    blr
;
; CHECK-32-P10-LABEL: testDoubleImm3:
; CHECK-32-P10:       # %bb.0: # %entry
; CHECK-32-P10-NEXT:    lfd 0, 4(3)
; CHECK-32-P10-NEXT:    xxpermdi 34, 0, 34, 1
; CHECK-32-P10-NEXT:    blr
entry:
  %add.ptr = getelementptr inbounds i32, ptr %b, i64 1
  %0 = load double, ptr %add.ptr, align 8
  %vecins = insertelement <2 x double> %a, double %0, i32 0
  ret <2 x double> %vecins
}

define <2 x double> @testDoubleImm4(<2 x double> %a, ptr %b) {
; CHECK-64-LABEL: testDoubleImm4:
; CHECK-64:       # %bb.0: # %entry
; CHECK-64-NEXT:    lis 4, 4
; CHECK-64-NEXT:    lfdx 0, 3, 4
; CHECK-64-NEXT:    xxpermdi 34, 0, 34, 1
; CHECK-64-NEXT:    blr
;
; CHECK-32-LABEL: testDoubleImm4:
; CHECK-32:       # %bb.0: # %entry
; CHECK-32-NEXT:    lis 4, 4
; CHECK-32-NEXT:    lfdx 0, 3, 4
; CHECK-32-NEXT:    xxpermdi 34, 0, 34, 1
; CHECK-32-NEXT:    blr
;
; CHECK-64-P10-LABEL: testDoubleImm4:
; CHECK-64-P10:       # %bb.0: # %entry
; CHECK-64-P10-NEXT:    plfd 0, 262144(3), 0
; CHECK-64-P10-NEXT:    xxpermdi 34, 0, 34, 1
; CHECK-64-P10-NEXT:    blr
;
; CHECK-32-P10-LABEL: testDoubleImm4:
; CHECK-32-P10:       # %bb.0: # %entry
; CHECK-32-P10-NEXT:    plfd 0, 262144(3), 0
; CHECK-32-P10-NEXT:    xxpermdi 34, 0, 34, 1
; CHECK-32-P10-NEXT:    blr
entry:
  %add.ptr = getelementptr inbounds i32, ptr %b, i64 65536
  %0 = load double, ptr %add.ptr, align 8
  %vecins = insertelement <2 x double> %a, double %0, i32 0
  ret <2 x double> %vecins
}

define <2 x double> @testDoubleImm5(<2 x double> %a, ptr %b) {
; CHECK-64-LABEL: testDoubleImm5:
; CHECK-64:       # %bb.0: # %entry
; CHECK-64-NEXT:    li 4, 1
; CHECK-64-NEXT:    rldic 4, 4, 38, 25
; CHECK-64-NEXT:    lfdx 0, 3, 4
; CHECK-64-NEXT:    xxpermdi 34, 0, 34, 1
; CHECK-64-NEXT:    blr
;
; CHECK-32-LABEL: testDoubleImm5:
; CHECK-32:       # %bb.0: # %entry
; CHECK-32-NEXT:    lfd 0, 0(3)
; CHECK-32-NEXT:    xxpermdi 34, 0, 34, 1
; CHECK-32-NEXT:    blr
;
; CHECK-64-P10-LABEL: testDoubleImm5:
; CHECK-64-P10:       # %bb.0: # %entry
; CHECK-64-P10-NEXT:    li 4, 1
; CHECK-64-P10-NEXT:    rldic 4, 4, 38, 25
; CHECK-64-P10-NEXT:    lfdx 0, 3, 4
; CHECK-64-P10-NEXT:    xxpermdi 34, 0, 34, 1
; CHECK-64-P10-NEXT:    blr
;
; CHECK-32-P10-LABEL: testDoubleImm5:
; CHECK-32-P10:       # %bb.0: # %entry
; CHECK-32-P10-NEXT:    lfd 0, 0(3)
; CHECK-32-P10-NEXT:    xxpermdi 34, 0, 34, 1
; CHECK-32-P10-NEXT:    blr
entry:
  %add.ptr = getelementptr inbounds i32, ptr %b, i64 68719476736
  %0 = load double, ptr %add.ptr, align 8
  %vecins = insertelement <2 x double> %a, double %0, i32 0
  ret <2 x double> %vecins
}

