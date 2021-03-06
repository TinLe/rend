// Copyright 2016 Netflix, Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

// This function is borrowed from the Go standard library
// Copyright (c) 2009 The Go Authors. All rights reserved.
// See the NOTICE file for more details.
TEXT ·Now(SB), 7, $16
	MOVQ runtime·__vdso_clock_gettime_sym(SB), AX
	MOVL $1, DI                                   // CLOCK_MONOTONIC
	LEAQ 0(SP), SI
	CALL AX
	MOVQ 0(SP), AX                                // sec
	MOVQ 8(SP), CX                                // nsec

	// sec is in AX, nsec in DX
	// return nsec in AX
	IMULQ $1000000000, AX
	ADDQ  CX, AX
	MOVQ  AX, ret+0(FP)
	RET
