// Title         : vending_machine_def.v
// Author      : Jae-Eon Jo (Jojaeeon@postech.ac.kr) 
//					Dongup Kwon (nankdu7@postech.ac.kr)

// Macro constants (prefix k & CamelCase)
`define kTotalBits 32
  
`define kItemBits 8
`define kNumItems 4

`define kCoinBits 8
`define kNumCoins 3

`define kWaitTime 10

// i_trigger_return 이 들어왔을 때 3 cycle을 기다린 후 거스르기 시작하기 위해 사용되는 상수
`define kTriggerWaitCycle 3 
