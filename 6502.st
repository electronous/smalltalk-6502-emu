| temp myfile fileContents nesmem addrfunarray opfunarray opbytearray loadaddr playaddr initaddr bankswitchval ntsctick totalsongs nesmstring retval memadj nesstate opcode startsong lastnote lastnotelen |
myfile := (FileStream fileNamed: 'dk.nsf').
myfile binary.
fileContents := myfile contents.
nesmstring := myfile next: 4.
myfile close.
Transcript cr; show: nesmstring.
loadaddr := fileContents unsignedShortAt: 9 bigEndian: false.
initaddr := fileContents unsignedShortAt: 11 bigEndian: false.
playaddr := fileContents unsignedShortAt: 13 bigEndian: false.
bankswitchval := fileContents at: 113.
(bankswitchval ~= 0) ifTrue: [ bankswitchval := 1/0. ].
ntsctick := fileContents unsignedShortAt: 111 bigEndian: false.
totalsongs := fileContents at: 7.
startsong := fileContents at: 8.
Transcript cr; show: 'Load address: '; show: loadaddr.
Transcript cr; show: 'Init address: '; show: initaddr.
Transcript cr; show: 'Play address: '; show: playaddr.
Transcript cr; show: 'NTSC ticks: '; show: ntsctick.
Transcript cr; show: 'Total songs: '; show: totalsongs.
Transcript cr; show: 'Starting song: '; show: startsong.
nesmem := ByteArray new: 65536.
temp := fileContents size.
temp := temp - 128.
1 to: temp do: [ :i | nesmem at: (i + loadaddr - 1) put: (fileContents at: (128 + i - 1)) ].
nesstate := {0 . 253 . 0 . 0 . 0 . 0 . nesmem}.
memadj := [ :x | x + 1 ].
opbytearray := #( 	#(1 12) #(8 35) #(1 1) #(1 1) #(1 1) #(3 35) #(3 4) #(1 1) #(1 37) #(2 35) #(1 57) #(1 1) #(1 1) #(5 35) #(5 4) #(1 1)
					#(10 11) #(9 35) #(1 1) #(1 1) #(1 1) #(4 35) #(4 4) #(1 1) #(1 15) #(7 35) #(1 1) #(1 1) #(1 1) #(6 35) #(6 4) #(1 1)
					#(5 30) #(8 3) #(1 1) #(1 1) #(3 8) #(3 3) #(3 40) #(1 1) #(1 39) #(2 3) #(1 59) #(1 1) #(5 8) #(5 3) #(5 40) #(1 1)
					#(10 9) #(9 3) #(1 1) #(1 1) #(1 1) #(4 3) #(4 40) #(1 1) #(1 45) #(7 3) #(1 1) #(1 1) #(1 1) #(6 3) #(6 40) #(1 1)
					#(1 42) #(8 25) #(1 1) #(1 1) #(1 1) #(3 25) #(3 34) #(1 1) #(1 36) #(2 25) #(1 58) #(1 1) #(5 29) #(5 25) #(5 34) #(1 1)
					#(10 13) #(9 25) #(1 1) #(1 1) #(1 1) #(4 25) #(4 34) #(1 1) #(1 17) #(7 25) #(1 1) #(1 1) #(1 1) #(6 25) #(6 34) #(1 1)
					#(1 43) #(8 2) #(1 1) #(1 1) #(1 1) #(3 2) #(3 41) #(1 1) #(1 38) #(2 2) #(1 60) #(1 1) #(6 29) #(5 2) #(5 41) #(1 1)
					#(10 14) #(9 2) #(1 1) #(1 1) #(1 1) #(4 2) #(4 41) #(1 1) #(1 47) #(7 2) #(1 1) #(1 1) #(1 1) #(6 2) #(6 41) #(1 1)
					#(1 1) #(8 48) #(1 1) #(1 1) #(3 50) #(3 48) #(3 49) #(1 1) #(1 24) #(1 1) #(1 54) #(1 1) #(5 50) #(5 48) #(5 49) #(1 1)
					#(10 5) #(9 48) #(1 1) #(1 1) #(4 50) #(4 48) #(12 49) #(1 1) #(1 56) #(7 48) #(1 55) #(1 1) #(1 1) #(6 48) #(7 49) #(1 1)
					#(2 33) #(8 31) #(2 32) #(1 1) #(3 33) #(3 31) #(3 32) #(1 1) #(1 52) #(2 31) #(1 51) #(1 1) #(5 33) #(5 31) #(5 32) #(1 1)
					#(10 6) #(9 31) #(1 1) #(1 1) #(4 33) #(4 31) #(12 32) #(1 1) #(1 18) #(7 31) #(1 53) #(1 1) #(6 33) #(6 31) #(7 32) #(1 1)
					#(2 21) #(8 19) #(1 1) #(1 1) #(1 21) #(3 19) #(3 22) #(1 1) #(1 28) #(2 19) #(1 23) #(1 1) #(5 21) #(5 19) #(5 22) #(1 1)
					#(10 10) #(9 19) #(1 1) #(1 1) #(1 1) #(4 19) #(4 22) #(1 1) #(1 16) #(7 19) #(1 1) #(1 1) #(1 1) #(6 19) #(6 22) #(1 1)
					#(2 20) #(8 44) #(1 1) #(1 1) #(1 20) #(3 44) #(3 26) #(1 1) #(1 27) #(2 44) #(1 1) #(1 1) #(5 20) #(5 44) #(5 26) #(1 1)
					#(10 7) #(9 44) #(1 1) #(1 1) #(1 1) #(4 44) #(4 26) #(1 1) #(1 46) #(7 44) #(1 1) #(1 1) #(1 1) #(6 44) #(6 26) #(1 1)
	).
addrfunarray := { 	[ 0 ] . 
					[ temp := nesstate at: 1.
					  nesstate at: 1 put: temp + 1.
					  memadj value: temp ]  .
					[ temp := nesstate at: 1.
					  nesstate at: 1 put: temp + 1.
					  memadj value: ((nesstate at: 7) at: (memadj value: temp)) ] .
					[ temp := nesstate at: 1.
					  nesstate at: 1 put: temp + 1.
					  temp := (nesstate at: 7) at: (memadj value: temp).
					  temp := temp + (nesstate at: 5).
					  memadj value: (temp \\ 256)  ] .
					[ temp := nesstate at: 1.
					  nesstate at: 1 put: temp + 2.
					  memadj value: ((nesstate at: 7) unsignedShortAt: (memadj value: temp) bigEndian: false) ] .
					[ temp := nesstate at: 1.
					  nesstate at: 1 put: temp + 2.
					  temp := (nesstate at: 7) unsignedShortAt: (memadj value: temp) bigEndian: false.
					  temp := temp + (nesstate at: 5).
					  memadj value: (temp \\ 65536) ] .
					[ temp := nesstate at: 1.
					  nesstate at: 1 put: temp + 2.
					  temp := (nesstate at: 7) unsignedShortAt: (memadj value: temp) bigEndian: false.
					  temp := temp + (nesstate at: 6).
					  memadj value: (temp \\ 65536) ] .
					[ temp := nesstate at: 1.
					  nesstate at: 1 put: temp + 1.
					  temp := (nesstate at: 7) at: (memadj value: temp).
					  temp := temp + (nesstate at: 5).
					  temp := temp \\ 256.
					  memadj value: ((nesstate at: 7) unsignedShortAt: (memadj value: temp) bigEndian: false) ] .
					[ temp := nesstate at: 1.
					  nesstate at: 1 put: temp + 1.
					  temp := (nesstate at: 7) at: (memadj value: temp).
					  temp := temp \\ 256.
					  temp := memadj value: ((nesstate at: 7) unsignedShortAt: (memadj value: temp) bigEndian: false).
					  temp := temp + (nesstate at: 6).
					  memadj value: (temp \\ 65536) ] .
					[ temp := nesstate at: 1.
					  nesstate at: 1 put: temp + 1.
					  (((nesstate at: 7) at: (memadj value: temp)) > 127) 
						ifTrue: 
							[ temp := temp + ((nesstate at: 7) at: (memadj value: temp)) - 256 ]
						ifFalse:
							[ temp := temp + ((nesstate at: 7) at: (memadj value: temp)) ].
					  memadj value: temp ] .
					[ temp := nesstate at: 1.
					  nesstate at: 1 put: temp + 1.
					  temp := ((nesstate at: 7) unsignedShortAt: (memadj value: temp) bigEndian: false).
					  temp := ((nesstate at: 7) unsignedShortAt: (memadj value: temp) bigEndian: false).
					  ((temp \\ 256) = 255)
						ifTrue:
							[ temp := 1/0 ].
					  memadj value: temp ] .
					[ temp := nesstate at: 1.
					  nesstate at: 1 put: temp + 1.
					  temp := (nesstate at: 7) at: (memadj value: temp).
					  temp := temp + (nesstate at: 6).
					  memadj value: (temp \\ 256)  ] 
					}.
opfunarray := {		[ :addr | false ] .
					[ :addr | temp := (nesstate at: 7) at: addr.
							temp := temp + (nesstate at: 4).
							(((nesstate at: 2) bitAt: 1) = 1) ifTrue: [temp := temp + 1].
							nesstate at: 3 put: ((nesstate at: 3) bitAt: 1 put: (temp bitAt: 9)).
							nesstate at: 3 put: ((nesstate at: 3) bitAt: 7 put: ((((((nesstate at: 4) bitXor: ((nesstate at: 7) at: addr)) bitAnd: 128) = 0) and: [(((nesstate at: 4) bitXor: temp) bitAnd: 128) ~= 0]) asBit)).
							nesstate at: 3 put: ((nesstate at: 3) bitAt: 8 put: (temp bitAt: 8)).
							temp := temp bitAnd: 255.
							nesstate at: 3 put: ((nesstate at: 3) bitAt: 2 put: ((temp = 0) asBit)).							
							nesstate at: 4 put: temp.
							false ] .
					[ :addr | temp := (nesstate at: 7) at: addr.
							temp := temp bitAnd: (nesstate at: 4).
							nesstate at: 3 put: ((nesstate at: 3) bitAt: 2 put: ((temp = 0) asBit)).
							nesstate at: 3 put: ((nesstate at: 3) bitAt: 8 put: (temp bitAt: 8)).
							nesstate at: 4 put: temp.
							false ] .
					[ :addr | temp := (nesstate at: 7) at: addr.
							temp := temp bitShift: 1.
							nesstate at: 3 put: ((nesstate at: 3) bitAt: 1 put: (temp bitAt: 9)).
							nesstate at: 3 put: ((nesstate at: 3) bitAt: 2 put: ((temp = 0) asBit)).
							nesstate at: 3 put: ((nesstate at: 3) bitAt: 8 put: (temp bitAt: 8)).
							(nesstate at: 7) at: addr put: (temp bitAnd: 255).
							false 
							] .
					[ :addr | (((nesstate at: 3) bitAt: 1) = 0) ifTrue: [nesstate at: 1 put: addr].
							false ] .
					[ :addr | (((nesstate at: 3) bitAt: 1) = 1) ifTrue: [nesstate at: 1 put: addr].
							false ] .
					[ :addr | (((nesstate at: 3) bitAt: 2) = 1) ifTrue: [nesstate at: 1 put: addr].
							false ] .
					[ :addr |	temp := (nesstate at: 7) at: addr.
							nesstate at: 3 put: ((nesstate at: 3) bitAt: 7 put: (temp bitAt: 7)).
							nesstate at: 3 put: ((nesstate at: 3) bitAt: 8 put: (temp bitAt: 8)).
							temp := temp bitAnd: (nesstate at: 4).
							nesstate at: 3 put: ((nesstate at: 3) bitAt: 2 put: ((temp = 0) asBit)).
							false ] .
					[ :addr | 
							(((nesstate at: 3) bitAt: 8) = 1) ifTrue: [nesstate at: 1 put: addr].
							false ] .
					[ :addr | (((nesstate at: 3) bitAt: 2) = 0) ifTrue: [nesstate at: 1 put: addr].
							false ] .
					[ :addr | (((nesstate at: 3) bitAt: 8) = 0) ifTrue: [nesstate at: 1 put: addr].
							false ] .
					[ :addr | temp := 1/0.
							false ] .
					[ :addr | (((nesstate at: 3) bitAt: 7) = 0) ifTrue: [nesstate at: 1 put: addr].
							false ] .
					[ :addr | (((nesstate at: 3) bitAt: 7) = 1) ifTrue: [nesstate at: 1 put: addr].
							false ] .
					[ :addr | nesstate at: 3 put: ((nesstate at: 3) bitAt: 1 put: 0).
							false ] .
					[ :addr | false ] .
					[ :addr | nesstate at: 3 put: ((nesstate at: 3) bitAt: 3 put: 0).
							false ] .
					[ :addr | nesstate at: 3 put: ((nesstate at: 3) bitAt: 7 put: 0).
							false ] .
					[ :addr | temp := (nesstate at: 7) at: addr.
							temp := (nesstate at: 4) - temp.
							(temp < 0) 
								ifTrue: 
									[ nesstate at: 3 put: ((nesstate at: 3) bitAt: 1 put: 0).
									  nesstate at: 3 put: ((nesstate at: 3) bitAt: 2 put: 0).
									  nesstate at: 3 put: ((nesstate at: 3) bitAt: 8 put: 1) ].
							(temp = 0)
								ifTrue:
									[ nesstate at: 3 put: ((nesstate at: 3) bitAt: 1 put: 1).
									  nesstate at: 3 put: ((nesstate at: 3) bitAt: 2 put: 1).
									  nesstate at: 3 put: ((nesstate at: 3) bitAt: 8 put: 0) ].
							(temp > 0)
								ifTrue: 
									[ nesstate at: 3 put: ((nesstate at: 3) bitAt: 1 put: 1).
									  nesstate at: 3 put: ((nesstate at: 3) bitAt: 2 put: 0).
									  nesstate at: 3 put: ((nesstate at: 3) bitAt: 8 put: 0) ].
							false ] .
					[ :addr | temp := (nesstate at: 7) at: addr.
							temp := (nesstate at: 5) - temp.
							(temp < 0) 
								ifTrue: 
									[ nesstate at: 3 put: ((nesstate at: 3) bitAt: 1 put: 0).
									  nesstate at: 3 put: ((nesstate at: 3) bitAt: 2 put: 0).
									  nesstate at: 3 put: ((nesstate at: 3) bitAt: 8 put: 1) ].
							(temp = 0)
								ifTrue:
									[ nesstate at: 3 put: ((nesstate at: 3) bitAt: 1 put: 1).
									  nesstate at: 3 put: ((nesstate at: 3) bitAt: 2 put: 1).
									  nesstate at: 3 put: ((nesstate at: 3) bitAt: 8 put: 0) ].
							(temp > 0)
								ifTrue: 
									[ nesstate at: 3 put: ((nesstate at: 3) bitAt: 1 put: 1).
									  nesstate at: 3 put: ((nesstate at: 3) bitAt: 2 put: 0).
									  nesstate at: 3 put: ((nesstate at: 3) bitAt: 8 put: 0) ].
							false ] .
					[ :addr | temp := (nesstate at: 7) at: addr.
							temp := (nesstate at: 6) - temp.
							(temp < 0) 
								ifTrue: 
									[ nesstate at: 3 put: ((nesstate at: 3) bitAt: 1 put: 0).
									  nesstate at: 3 put: ((nesstate at: 3) bitAt: 2 put: 0).
									  nesstate at: 3 put: ((nesstate at: 3) bitAt: 8 put: 1) ].
							(temp = 0)
								ifTrue:
									[ nesstate at: 3 put: ((nesstate at: 3) bitAt: 1 put: 1).
									  nesstate at: 3 put: ((nesstate at: 3) bitAt: 2 put: 1).
									  nesstate at: 3 put: ((nesstate at: 3) bitAt: 8 put: 0) ].
							(temp > 0)
								ifTrue: 
									[ nesstate at: 3 put: ((nesstate at: 3) bitAt: 1 put: 1).
									  nesstate at: 3 put: ((nesstate at: 3) bitAt: 2 put: 0).
									  nesstate at: 3 put: ((nesstate at: 3) bitAt: 8 put: 0) ].
							false ] .
					[ :addr | temp := (nesstate at: 7) at: addr.
							temp := (temp - 1) bitAnd: 255.
							nesstate at: 3 put: ((nesstate at: 3) bitAt: 2 put: ((temp = 0) asBit)).
							nesstate at: 3 put: ((nesstate at: 3) bitAt: 8 put: (temp bitAt: 8)).
							(nesstate at: 7) at: addr put: temp.
							"Transcript cr; show: (((nesstate at: 7) at: addr) radix: 16)."
							false ] .
					[ :addr | temp := nesstate at: 5.
							temp := (temp - 1) bitAnd: 255.
							nesstate at: 3 put: ((nesstate at: 3) bitAt: 2 put: ((temp = 0) asBit)).
							nesstate at: 3 put: ((nesstate at: 3) bitAt: 8 put: (temp bitAt: 8)).
							nesstate at: 5 put: temp.
							false ] .
					[ :addr | temp := nesstate at: 6.
							temp := (temp - 1) bitAnd: 255.
							nesstate at: 3 put: ((nesstate at: 3) bitAt: 2 put: ((temp = 0) asBit)).
							nesstate at: 3 put: ((nesstate at: 3) bitAt: 8 put: (temp bitAt: 8)).
							nesstate at: 6 put: temp.
							false ] .
					[ :addr | temp := (nesstate at: 7) at: addr.
							temp := temp bitXor: (nesstate at: 4).
							nesstate at: 3 put: ((nesstate at: 3) bitAt: 2 put: ((temp = 0) asBit)).
							nesstate at: 3 put: ((nesstate at: 3) bitAt: 8 put: (temp bitAt: 8)).
							nesstate at: 4 put: temp.
							false ] .
					[ :addr | temp := (nesstate at: 7) at: addr.
							temp := (temp + 1) bitAnd: 255.
							nesstate at: 3 put: ((nesstate at: 3) bitAt: 2 put: ((temp = 0) asBit)).
							nesstate at: 3 put: ((nesstate at: 3) bitAt: 8 put: (temp bitAt: 8)).
							(nesstate at: 7) at: addr put: temp.
							false ] .
					[ :addr | temp := nesstate at: 5.
							temp := (temp + 1) bitAnd: 255.
							nesstate at: 3 put: ((nesstate at: 3) bitAt: 2 put: ((temp = 0) asBit)).
							nesstate at: 3 put: ((nesstate at: 3) bitAt: 8 put: (temp bitAt: 8)).
							nesstate at: 5 put: temp.
							false ] .
					[ :addr | temp := nesstate at: 6.
							temp := (temp + 1) bitAnd: 255.
							nesstate at: 3 put: ((nesstate at: 3) bitAt: 2 put: ((temp = 0) asBit)).
							nesstate at: 3 put: ((nesstate at: 3) bitAt: 8 put: (temp bitAt: 8)).
							nesstate at: 6 put: temp.
							false ] .
					[ :addr | nesstate at: 1 put: (addr - 1).
							false ] .
					[ :addr | temp := (addr - 1).
							addr := (nesstate at: 2) + 256.
							(nesstate at: 7) at: (memadj value: addr) put: ((nesstate at: 1) bitShift: -8).
							addr := addr - 256.
							addr := (addr - 1) bitAnd: 255.
							addr := addr + 256.
							(nesstate at: 7) at: (memadj value: addr) put: ((nesstate at: 1) bitAnd: 255).
							addr := addr - 256.
							addr := (addr - 1) bitAnd: 255.
							nesstate at: 2 put: addr.
							"Transcript show: ' '; show: (temp radix: 16)."
							nesstate at: 1 put: temp.
							false ] .
					[ :addr | 
							temp := (nesstate at: 7) at: addr.
							nesstate at: 3 put: ((nesstate at: 3) bitAt: 2 put: ((temp = 0) asBit)).
							nesstate at: 3 put: ((nesstate at: 3) bitAt: 8 put: (temp bitAt: 8)).
							nesstate at: 4 put: temp.
							false ] .
					[ :addr | temp := (nesstate at: 7) at: addr.
							nesstate at: 3 put: ((nesstate at: 3) bitAt: 2 put: ((temp = 0) asBit)).
							nesstate at: 3 put: ((nesstate at: 3) bitAt: 8 put: (temp bitAt: 8)).
							nesstate at: 5 put: temp.
							false ] .
					[ :addr | temp := (nesstate at: 7) at: addr.
							nesstate at: 3 put: ((nesstate at: 3) bitAt: 2 put: ((temp = 0) asBit)).
							nesstate at: 3 put: ((nesstate at: 3) bitAt: 8 put: (temp bitAt: 8)).
							nesstate at: 6 put: temp.
							false ] .
					[ :addr | temp := (nesstate at: 7) at: addr.
							nesstate at: 3 put: ((nesstate at: 3) bitAt: 1 put: (temp bitAt: 1)).
							temp := temp bitShift: -1.
							nesstate at: 3 put: ((nesstate at: 3) bitAt: 2 put: ((temp = 0) asBit)).
							nesstate at: 3 put: ((nesstate at: 3) bitAt: 8 put: (temp bitAt: 8)).
							(nesstate at: 7) at: addr put: temp.
							false ] .
					[ :addr | temp := (nesstate at: 7) at: addr.
							temp := temp bitOr: (nesstate at: 4).
							nesstate at: 3 put: ((nesstate at: 3) bitAt: 2 put: ((temp = 0) asBit)).
							nesstate at: 3 put: ((nesstate at: 3) bitAt: 8 put: (temp bitAt: 8)).
							nesstate at: 4 put: temp.
							false ] .
					[ :addr | addr := (nesstate at: 2) + 256.
							(nesstate at: 7) at: (memadj value: addr) put: (nesstate at: 4).
							addr := addr - 256.
							addr := (addr - 1) bitAnd: 255.
							nesstate at: 2 put: addr.
							false ] .
					[ :addr | addr := (nesstate at: 2) + 256.
							(nesstate at: 7) at: (memadj value: addr) put: (nesstate at: 3).
							addr := addr - 256.
							addr := (addr - 1) bitAnd: 255.
							nesstate at: 2 put: addr.
							false ] .
					[ :addr | addr := nesstate at: 2.
							addr := (addr + 1) bitAnd: 255.
							addr := addr + 256.
							temp := (nesstate at: 7) at: (memadj value: addr).
							nesstate at: 3 put: ((nesstate at: 3) bitAt: 2 put: ((temp = 0) asBit)).
							nesstate at: 3 put: ((nesstate at: 3) bitAt: 8 put: (temp bitAt: 8)).
							nesstate at: 4 put: temp.
							addr := addr - 256.
							nesstate at: 2 put: addr.
							false ] .
					[ :addr | addr := nesstate at: 2.
							addr := (addr + 1) bitAnd: 255.
							addr := addr + 256.
							nesstate at: 3 put: ((nesstate at: 7) at: (memadj value: addr)).
							addr := addr - 256.
							nesstate at: 2 put: addr.
							false ] .
					[ :addr | temp := (nesstate at: 7) at: addr.
							temp := temp bitShift: 1.
							(((nesstate at: 3) bitAt: 1) = 1) ifTrue: [ temp := temp bitOr: 1 ].
							nesstate at: 3 put: ((nesstate at: 3) bitAt: 1 put: (temp bitAt: 9)).
							nesstate at: 3 put: ((nesstate at: 3) bitAt: 2 put: ((temp = 0) asBit)).
							nesstate at: 3 put: ((nesstate at: 3) bitAt: 8 put: (temp bitAt: 8)).
							((nesstate at: 7) at: addr) put: (temp bitAnd: 255).
							false ] .	
					[ :addr | temp := (nesstate at: 7) at: addr.
							(((nesstate at: 3) bitAt: 1) = 1) ifTrue: [ temp := temp bitOr: 256 ].					
							nesstate at: 3 put: ((nesstate at: 3) bitAt: 1 put: (temp bitAt: 1)).
							temp := temp bitShift: -1.
							nesstate at: 3 put: ((nesstate at: 3) bitAt: 2 put: ((temp = 0) asBit)).
							nesstate at: 3 put: ((nesstate at: 3) bitAt: 8 put: (temp bitAt: 8)).
							(nesstate at: 7) at: addr put: temp.
							false ] .
					[ :addr | temp := 1/0.
							false ] .
					[ :addr | addr := nesstate at: 2.
							addr := (addr + 1) bitAnd: 255.
							addr := addr + 256.
							temp := (nesstate at: 7) at: (memadj value: addr).
							addr := addr - 256.
							addr := (addr + 1) bitAnd: 255.
							addr := addr + 256.
							temp := temp bitOr: (((nesstate at: 7) at: (memadj value: addr)) bitShift: 8).
							addr := addr - 256.
							nesstate at: 2 put: addr.
							nesstate at: 1 put: temp.
							temp := (temp = 0).
							temp ] .
					[ :addr | temp := (nesstate at: 7) at: addr.
							temp := (nesstate at: 4) - temp.
							(((nesstate at: 2) bitAt: 1) = 0) ifTrue: [temp := temp - 1].
							nesstate at: 3 put: ((nesstate at: 3) bitAt: 1 put: (((temp bitAt: 9) = false) asBit)).
							nesstate at: 3 put: ((nesstate at: 3) bitAt: 7 put: ((((((nesstate at: 4) bitXor: ((nesstate at: 7) at: addr)) bitAnd: 128) ~= 0) and: [(((nesstate at: 4) bitXor: temp) bitAnd: 128) ~= 0]) asBit)).
							nesstate at: 3 put: ((nesstate at: 3) bitAt: 8 put: (temp bitAt: 8)).
							temp := temp bitAnd: 255.
							nesstate at: 3 put: ((nesstate at: 3) bitAt: 2 put: ((temp = 0) asBit)).							
							nesstate at: 4 put: temp.
							false ] .
					[ :addr | nesstate at: 3 put: ((nesstate at: 3) bitAt: 1 put: 1).
							false ] .
					[ :addr | false ] .
					[ :addr | nesstate at: 3 put: ((nesstate at: 3) bitAt: 3 put: 1).
							false ] .
					[ :addr | temp := nesstate at: 4.
							(nesstate at: 7) at: addr put: temp.
							false ] .
					[ :addr | temp := nesstate at: 5.
							(nesstate at: 7) at: addr put: temp.
							false ] .
					[ :addr | temp := nesstate at: 6.
							(nesstate at: 7) at: addr put: temp.
							false ] .
					[ :addr | temp := nesstate at: 4.
							nesstate at: 5 put: temp.
							nesstate at: 3 put: ((nesstate at: 3) bitAt: 2 put: ((temp = 0) asBit)).
							nesstate at: 3 put: ((nesstate at: 3) bitAt: 8 put: (temp bitAt: 8)).	
							false ] .
					[ :addr | temp := nesstate at: 4.
							nesstate at: 6 put: temp.
							nesstate at: 3 put: ((nesstate at: 3) bitAt: 2 put: ((temp = 0) asBit)).
							nesstate at: 3 put: ((nesstate at: 3) bitAt: 8 put: (temp bitAt: 8)).	
							false ] .				
					[ :addr | temp := nesstate at: 2.
							nesstate at: 5 put: temp.
							nesstate at: 3 put: ((nesstate at: 3) bitAt: 2 put: ((temp = 0) asBit)).
							nesstate at: 3 put: ((nesstate at: 3) bitAt: 8 put: (temp bitAt: 8)).	
							false ] .
					[ :addr | temp := nesstate at: 5.
							nesstate at: 4 put: temp.
							nesstate at: 3 put: ((nesstate at: 3) bitAt: 2 put: ((temp = 0) asBit)).
							nesstate at: 3 put: ((nesstate at: 3) bitAt: 8 put: (temp bitAt: 8)).	
							false ] .
					[ :addr | temp := nesstate at: 5.
							nesstate at: 3 put: temp.
							false ] .
					[ :addr | temp := nesstate at: 6.
							nesstate at: 4 put: temp.
							nesstate at: 3 put: ((nesstate at: 3) bitAt: 2 put: ((temp = 0) asBit)).
							nesstate at: 3 put: ((nesstate at: 3) bitAt: 8 put: (temp bitAt: 8)).	
							false ] .
					[ :addr | temp := nesstate at: 4.
							temp := temp bitShift: 1.
							nesstate at: 3 put: ((nesstate at: 3) bitAt: 1 put: (temp bitAt: 9)).
							nesstate at: 3 put: ((nesstate at: 3) bitAt: 2 put: ((temp = 0) asBit)).
							nesstate at: 3 put: ((nesstate at: 3) bitAt: 8 put: (temp bitAt: 8)).
							nesstate at: 4 put: (temp bitAnd: 255).
							false ] .
					[ :addr | temp := nesstate at: 4.
							nesstate at: 3 put: ((nesstate at: 3) bitAt: 1 put: (temp bitAt: 1)).
							temp := temp bitShift: -1.
							nesstate at: 3 put: ((nesstate at: 3) bitAt: 2 put: ((temp = 0) asBit)).
							nesstate at: 3 put: ((nesstate at: 3) bitAt: 8 put: (temp bitAt: 8)).
							nesstate at: 4 put: temp.
							false ] .
					[ :addr | temp := nesstate at: 4.
							temp := temp bitShift: 1.
							(((nesstate at: 3) bitAt: 1) = 1) ifTrue: [ temp := temp bitOr: 1 ].
							nesstate at: 3 put: ((nesstate at: 3) bitAt: 1 put: (temp bitAt: 9)).
							nesstate at: 3 put: ((nesstate at: 3) bitAt: 2 put: ((temp = 0) asBit)).
							nesstate at: 3 put: ((nesstate at: 3) bitAt: 8 put: (temp bitAt: 8)).
							nesstate at: 4 put: (temp bitAnd: 255).
							false ] .
					[ :addr | temp := nesstate at: 4.
							(((nesstate at: 3) bitAt: 1) = 1) ifTrue: [ temp := temp bitOr: 256 ].					
							nesstate at: 3 put: ((nesstate at: 3) bitAt: 1 put: (temp bitAt: 1)).
							temp := temp bitShift: -1.
							nesstate at: 3 put: ((nesstate at: 3) bitAt: 2 put: ((temp = 0) asBit)).
							nesstate at: 3 put: ((nesstate at: 3) bitAt: 8 put: (temp bitAt: 8)).
							nesstate at: 4 put: temp.
							false ]											
						} .
"Run initialize program"
retval := false.
"Set NTSC"
nesstate at: 5 put: 0.
"Set Song Number"
nesstate at: 4 put: 4.
"Set Init PC"
nesstate at: 1 put: initaddr.
"Set SP"
nesstate at: 2 put: 253.
"Set Volume register"
(nesstate at: 7) at: 16406 put: 15.
[ retval = false ] whileTrue:
	[ 	
		temp := (nesstate at: 7) at: (memadj value: (nesstate at: 1)).
		nesstate at: 1 put: ((nesstate at: 1) + 1).
		opcode := opbytearray at: (temp + 1).
		retval := (addrfunarray at: (opcode at: 1)) value.
		retval := (opfunarray at: (opcode at: 2)) value: retval
		  ].
"Run main program"

(nesstate at: 7) at: 16406 put: 15.
lastnote := 0.
lastnotelen := 0.
1 to: 600 do: [ :i | 
	retval := false.
	"Set NTSC"
	nesstate at: 1 put: playaddr.
	"Set SP"
	nesstate at: 2 put: 253.
	[ retval = false ] whileTrue:
		[ 	
		temp := (nesstate at: 7) at: (memadj value: (nesstate at: 1)).
		nesstate at: 1 put: ((nesstate at: 1) + 1).
		opcode := opbytearray at: (temp + 1).
		"Transcript cr; show: opcode; show: (((nesstate at: 1) - 1) radix: 16)."
		retval := (addrfunarray at: (opcode at: 1)) value.
		"Transcript show: ' '; show: ((retval - 1) radix: 16)."
		"((retval > 16384) and: [retval < 16420]) ifTrue: [ Transcript show: ' '; show: ((retval - 1) radix: 16) ]."
		retval := (opfunarray at: (opcode at: 2)) value: retval
		  ]. 
	temp := (nesstate at: 7) at: 16395.
	(temp = lastnote) 
		ifTrue: 
			[ lastnotelen := lastnotelen + 1 ] 
		ifFalse: 
			[ Transcript show: 'dur: '; show: (lastnotelen * 1/60.0); show: 's.'.
			  lastnote := temp.
			  lastnotelen := 0.
			  Transcript cr; show: 'Note: '; show: (1790000/((lastnote + 1) * 32.0)); show: ' hz; start: '; show: (i * 1/60.0); show: 's; ' ].
	"1 to: 32 do: [ :j | Transcript show: (((nesstate at: 7) at: (16384 + j)) radix: 16); show: ' ' ]."
].
Transcript show: 'dur: '; show: (lastnotelen * 1/60.0); show: 's.'.
Transcript cr; show: 'Done.'.

