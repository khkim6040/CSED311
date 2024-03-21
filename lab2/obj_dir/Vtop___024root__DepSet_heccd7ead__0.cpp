// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vtop.h for the primary calling header

#include "Vtop__pch.h"
#include "Vtop___024root.h"

void Vtop___024root___eval_act(Vtop___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___eval_act\n"); );
}

VL_INLINE_OPT void Vtop___024root___nba_sequent__TOP__0(Vtop___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___nba_sequent__TOP__0\n"); );
    // Init
    CData/*4:0*/ __Vdlyvdim0__top__DOT__cpu__DOT__reg_file__DOT__rf__v0;
    __Vdlyvdim0__top__DOT__cpu__DOT__reg_file__DOT__rf__v0 = 0;
    IData/*31:0*/ __Vdlyvval__top__DOT__cpu__DOT__reg_file__DOT__rf__v0;
    __Vdlyvval__top__DOT__cpu__DOT__reg_file__DOT__rf__v0 = 0;
    CData/*0:0*/ __Vdlyvset__top__DOT__cpu__DOT__reg_file__DOT__rf__v0;
    __Vdlyvset__top__DOT__cpu__DOT__reg_file__DOT__rf__v0 = 0;
    SData/*13:0*/ __Vdlyvdim0__top__DOT__cpu__DOT__dmem__DOT__mem__v0;
    __Vdlyvdim0__top__DOT__cpu__DOT__dmem__DOT__mem__v0 = 0;
    IData/*31:0*/ __Vdlyvval__top__DOT__cpu__DOT__dmem__DOT__mem__v0;
    __Vdlyvval__top__DOT__cpu__DOT__dmem__DOT__mem__v0 = 0;
    CData/*0:0*/ __Vdlyvset__top__DOT__cpu__DOT__dmem__DOT__mem__v0;
    __Vdlyvset__top__DOT__cpu__DOT__dmem__DOT__mem__v0 = 0;
    VlWide<6>/*191:0*/ __Vtemp_3;
    // Body
    __Vdlyvset__top__DOT__cpu__DOT__dmem__DOT__mem__v0 = 0U;
    __Vdlyvset__top__DOT__cpu__DOT__reg_file__DOT__rf__v0 = 0U;
    if (vlSelf->reset) {
        vlSelf->top__DOT__cpu__DOT__reg_file__DOT__i = 0x20U;
        vlSelf->top__DOT__cpu__DOT__dmem__DOT__i = 0U;
        while (VL_GTS_III(32, 0x4000U, vlSelf->top__DOT__cpu__DOT__dmem__DOT__i)) {
            vlSelf->top__DOT__cpu__DOT__dmem__DOT__mem[(0x3fffU 
                                                        & vlSelf->top__DOT__cpu__DOT__dmem__DOT__i)] = 0U;
            vlSelf->top__DOT__cpu__DOT__dmem__DOT__i 
                = ((IData)(1U) + vlSelf->top__DOT__cpu__DOT__dmem__DOT__i);
        }
    } else {
        vlSelf->top__DOT__cpu__DOT__reg_file__DOT__i = 0U;
        vlSelf->top__DOT__cpu__DOT__dmem__DOT__i = 0U;
    }
    if ((0x23U != (0x7fU & vlSelf->top__DOT__cpu__DOT__dout))) {
        vlSelf->top__DOT__cpu__DOT__dmem__DOT__i = 0U;
    }
    if (VL_UNLIKELY(vlSelf->reset)) {
        vlSelf->top__DOT__cpu__DOT__imem__DOT__i = 0U;
        while (VL_GTS_III(32, 0x400U, vlSelf->top__DOT__cpu__DOT__imem__DOT__i)) {
            vlSelf->top__DOT__cpu__DOT__imem__DOT__mem[(0x3ffU 
                                                        & vlSelf->top__DOT__cpu__DOT__imem__DOT__i)] = 0U;
            vlSelf->top__DOT__cpu__DOT__imem__DOT__i 
                = ((IData)(1U) + vlSelf->top__DOT__cpu__DOT__imem__DOT__i);
        }
        __Vtemp_3[0U] = 0x2e747874U;
        __Vtemp_3[1U] = 0x5f6d656dU;
        __Vtemp_3[2U] = 0x6c6f6f70U;
        __Vtemp_3[3U] = 0x5f74622fU;
        __Vtemp_3[4U] = 0x64656e74U;
        __Vtemp_3[5U] = 0x737475U;
        VL_READMEM_N(true, 32, 1024, 0, VL_CVT_PACK_STR_NW(6, __Vtemp_3)
                     ,  &(vlSelf->top__DOT__cpu__DOT__imem__DOT__mem)
                     , 0, ~0ULL);
    } else {
        vlSelf->top__DOT__cpu__DOT__imem__DOT__i = 0U;
    }
    if ((1U & (~ (((IData)(vlSelf->top__DOT__cpu__DOT__write_enable) 
                   & (~ (IData)(vlSelf->reset))) & 
                  (0U != (0x1fU & (vlSelf->top__DOT__cpu__DOT__dout 
                                   >> 7U))))))) {
        vlSelf->top__DOT__cpu__DOT__reg_file__DOT__i = 0U;
    }
    if ((0x23U == (0x7fU & vlSelf->top__DOT__cpu__DOT__dout))) {
        __Vdlyvval__top__DOT__cpu__DOT__dmem__DOT__mem__v0 
            = vlSelf->top__DOT__cpu__DOT__rs2_dout;
        __Vdlyvset__top__DOT__cpu__DOT__dmem__DOT__mem__v0 = 1U;
        __Vdlyvdim0__top__DOT__cpu__DOT__dmem__DOT__mem__v0 
            = (0x3fffU & (vlSelf->top__DOT__cpu__DOT__alu_result 
                          >> 2U));
    }
    if ((((IData)(vlSelf->top__DOT__cpu__DOT__write_enable) 
          & (~ (IData)(vlSelf->reset))) & (0U != (0x1fU 
                                                  & (vlSelf->top__DOT__cpu__DOT__dout 
                                                     >> 7U))))) {
        __Vdlyvval__top__DOT__cpu__DOT__reg_file__DOT__rf__v0 
            = (((0x6fU == (0x7fU & vlSelf->top__DOT__cpu__DOT__dout)) 
                | (0x67U == (0x7fU & vlSelf->top__DOT__cpu__DOT__dout)))
                ? ((IData)(4U) + vlSelf->top__DOT__cpu__DOT__current_pc)
                : ((3U == (0x7fU & vlSelf->top__DOT__cpu__DOT__dout))
                    ? ((3U == (0x7fU & vlSelf->top__DOT__cpu__DOT__dout))
                        ? vlSelf->top__DOT__cpu__DOT__dmem__DOT__mem
                       [(0x3fffU & (vlSelf->top__DOT__cpu__DOT__alu_result 
                                    >> 2U))] : 0U) : vlSelf->top__DOT__cpu__DOT__alu_result));
        __Vdlyvset__top__DOT__cpu__DOT__reg_file__DOT__rf__v0 = 1U;
        __Vdlyvdim0__top__DOT__cpu__DOT__reg_file__DOT__rf__v0 
            = (0x1fU & (vlSelf->top__DOT__cpu__DOT__dout 
                        >> 7U));
    }
    if (vlSelf->reset) {
        vlSelf->top__DOT__cpu__DOT__reg_file__DOT__rf[0U] = 0U;
        vlSelf->top__DOT__cpu__DOT__reg_file__DOT__rf[1U] = 0U;
        vlSelf->top__DOT__cpu__DOT__reg_file__DOT__rf[2U] = 0U;
        vlSelf->top__DOT__cpu__DOT__reg_file__DOT__rf[3U] = 0U;
        vlSelf->top__DOT__cpu__DOT__reg_file__DOT__rf[4U] = 0U;
        vlSelf->top__DOT__cpu__DOT__reg_file__DOT__rf[5U] = 0U;
        vlSelf->top__DOT__cpu__DOT__reg_file__DOT__rf[6U] = 0U;
        vlSelf->top__DOT__cpu__DOT__reg_file__DOT__rf[7U] = 0U;
        vlSelf->top__DOT__cpu__DOT__reg_file__DOT__rf[8U] = 0U;
        vlSelf->top__DOT__cpu__DOT__reg_file__DOT__rf[9U] = 0U;
        vlSelf->top__DOT__cpu__DOT__reg_file__DOT__rf[0xaU] = 0U;
        vlSelf->top__DOT__cpu__DOT__reg_file__DOT__rf[0xbU] = 0U;
        vlSelf->top__DOT__cpu__DOT__reg_file__DOT__rf[0xcU] = 0U;
        vlSelf->top__DOT__cpu__DOT__reg_file__DOT__rf[0xdU] = 0U;
        vlSelf->top__DOT__cpu__DOT__reg_file__DOT__rf[0xeU] = 0U;
        vlSelf->top__DOT__cpu__DOT__reg_file__DOT__rf[0xfU] = 0U;
        vlSelf->top__DOT__cpu__DOT__reg_file__DOT__rf[0x10U] = 0U;
        vlSelf->top__DOT__cpu__DOT__reg_file__DOT__rf[0x11U] = 0U;
        vlSelf->top__DOT__cpu__DOT__reg_file__DOT__rf[0x12U] = 0U;
        vlSelf->top__DOT__cpu__DOT__reg_file__DOT__rf[0x13U] = 0U;
        vlSelf->top__DOT__cpu__DOT__reg_file__DOT__rf[0x14U] = 0U;
        vlSelf->top__DOT__cpu__DOT__reg_file__DOT__rf[0x15U] = 0U;
        vlSelf->top__DOT__cpu__DOT__reg_file__DOT__rf[0x16U] = 0U;
        vlSelf->top__DOT__cpu__DOT__reg_file__DOT__rf[0x17U] = 0U;
        vlSelf->top__DOT__cpu__DOT__reg_file__DOT__rf[0x18U] = 0U;
        vlSelf->top__DOT__cpu__DOT__reg_file__DOT__rf[0x19U] = 0U;
        vlSelf->top__DOT__cpu__DOT__reg_file__DOT__rf[0x1aU] = 0U;
        vlSelf->top__DOT__cpu__DOT__reg_file__DOT__rf[0x1bU] = 0U;
        vlSelf->top__DOT__cpu__DOT__reg_file__DOT__rf[0x1cU] = 0U;
        vlSelf->top__DOT__cpu__DOT__reg_file__DOT__rf[0x1dU] = 0U;
        vlSelf->top__DOT__cpu__DOT__reg_file__DOT__rf[0x1eU] = 0U;
        vlSelf->top__DOT__cpu__DOT__reg_file__DOT__rf[0x1fU] = 0U;
        vlSelf->top__DOT__cpu__DOT__reg_file__DOT__rf[2U] = 0x2ffcU;
        vlSelf->top__DOT__cpu__DOT__current_pc = 0U;
    } else {
        vlSelf->top__DOT__cpu__DOT__current_pc = ((0x67U 
                                                   == 
                                                   (0x7fU 
                                                    & vlSelf->top__DOT__cpu__DOT__dout))
                                                   ? vlSelf->top__DOT__cpu__DOT__alu_result
                                                   : vlSelf->top__DOT__cpu__DOT__PCSrc1_out);
    }
    if (__Vdlyvset__top__DOT__cpu__DOT__dmem__DOT__mem__v0) {
        vlSelf->top__DOT__cpu__DOT__dmem__DOT__mem[__Vdlyvdim0__top__DOT__cpu__DOT__dmem__DOT__mem__v0] 
            = __Vdlyvval__top__DOT__cpu__DOT__dmem__DOT__mem__v0;
    }
    if (__Vdlyvset__top__DOT__cpu__DOT__reg_file__DOT__rf__v0) {
        vlSelf->top__DOT__cpu__DOT__reg_file__DOT__rf[__Vdlyvdim0__top__DOT__cpu__DOT__reg_file__DOT__rf__v0] 
            = __Vdlyvval__top__DOT__cpu__DOT__reg_file__DOT__rf__v0;
    }
    vlSelf->print_reg[0U] = vlSelf->top__DOT__cpu__DOT__reg_file__DOT__rf
        [0U];
    vlSelf->print_reg[1U] = vlSelf->top__DOT__cpu__DOT__reg_file__DOT__rf
        [1U];
    vlSelf->print_reg[2U] = vlSelf->top__DOT__cpu__DOT__reg_file__DOT__rf
        [2U];
    vlSelf->print_reg[3U] = vlSelf->top__DOT__cpu__DOT__reg_file__DOT__rf
        [3U];
    vlSelf->print_reg[4U] = vlSelf->top__DOT__cpu__DOT__reg_file__DOT__rf
        [4U];
    vlSelf->print_reg[5U] = vlSelf->top__DOT__cpu__DOT__reg_file__DOT__rf
        [5U];
    vlSelf->print_reg[6U] = vlSelf->top__DOT__cpu__DOT__reg_file__DOT__rf
        [6U];
    vlSelf->print_reg[7U] = vlSelf->top__DOT__cpu__DOT__reg_file__DOT__rf
        [7U];
    vlSelf->print_reg[8U] = vlSelf->top__DOT__cpu__DOT__reg_file__DOT__rf
        [8U];
    vlSelf->print_reg[9U] = vlSelf->top__DOT__cpu__DOT__reg_file__DOT__rf
        [9U];
    vlSelf->print_reg[0xaU] = vlSelf->top__DOT__cpu__DOT__reg_file__DOT__rf
        [0xaU];
    vlSelf->print_reg[0xbU] = vlSelf->top__DOT__cpu__DOT__reg_file__DOT__rf
        [0xbU];
    vlSelf->print_reg[0xcU] = vlSelf->top__DOT__cpu__DOT__reg_file__DOT__rf
        [0xcU];
    vlSelf->print_reg[0xdU] = vlSelf->top__DOT__cpu__DOT__reg_file__DOT__rf
        [0xdU];
    vlSelf->print_reg[0xeU] = vlSelf->top__DOT__cpu__DOT__reg_file__DOT__rf
        [0xeU];
    vlSelf->print_reg[0xfU] = vlSelf->top__DOT__cpu__DOT__reg_file__DOT__rf
        [0xfU];
    vlSelf->print_reg[0x10U] = vlSelf->top__DOT__cpu__DOT__reg_file__DOT__rf
        [0x10U];
    vlSelf->print_reg[0x11U] = vlSelf->top__DOT__cpu__DOT__reg_file__DOT__rf
        [0x11U];
    vlSelf->print_reg[0x12U] = vlSelf->top__DOT__cpu__DOT__reg_file__DOT__rf
        [0x12U];
    vlSelf->print_reg[0x13U] = vlSelf->top__DOT__cpu__DOT__reg_file__DOT__rf
        [0x13U];
    vlSelf->print_reg[0x14U] = vlSelf->top__DOT__cpu__DOT__reg_file__DOT__rf
        [0x14U];
    vlSelf->print_reg[0x15U] = vlSelf->top__DOT__cpu__DOT__reg_file__DOT__rf
        [0x15U];
    vlSelf->print_reg[0x16U] = vlSelf->top__DOT__cpu__DOT__reg_file__DOT__rf
        [0x16U];
    vlSelf->print_reg[0x17U] = vlSelf->top__DOT__cpu__DOT__reg_file__DOT__rf
        [0x17U];
    vlSelf->print_reg[0x18U] = vlSelf->top__DOT__cpu__DOT__reg_file__DOT__rf
        [0x18U];
    vlSelf->print_reg[0x19U] = vlSelf->top__DOT__cpu__DOT__reg_file__DOT__rf
        [0x19U];
    vlSelf->print_reg[0x1aU] = vlSelf->top__DOT__cpu__DOT__reg_file__DOT__rf
        [0x1aU];
    vlSelf->print_reg[0x1bU] = vlSelf->top__DOT__cpu__DOT__reg_file__DOT__rf
        [0x1bU];
    vlSelf->print_reg[0x1cU] = vlSelf->top__DOT__cpu__DOT__reg_file__DOT__rf
        [0x1cU];
    vlSelf->print_reg[0x1dU] = vlSelf->top__DOT__cpu__DOT__reg_file__DOT__rf
        [0x1dU];
    vlSelf->print_reg[0x1eU] = vlSelf->top__DOT__cpu__DOT__reg_file__DOT__rf
        [0x1eU];
    vlSelf->print_reg[0x1fU] = vlSelf->top__DOT__cpu__DOT__reg_file__DOT__rf
        [0x1fU];
    vlSelf->top__DOT__cpu__DOT__dout = vlSelf->top__DOT__cpu__DOT__imem__DOT__mem
        [(0x3ffU & (vlSelf->top__DOT__cpu__DOT__current_pc 
                    >> 2U))];
    vlSelf->top__DOT__cpu__DOT__write_enable = ((0x23U 
                                                 != 
                                                 (0x7fU 
                                                  & vlSelf->top__DOT__cpu__DOT__dout)) 
                                                & (0x63U 
                                                   != 
                                                   (0x7fU 
                                                    & vlSelf->top__DOT__cpu__DOT__dout)));
    vlSelf->is_halted = ((0x73U == (0x7fU & vlSelf->top__DOT__cpu__DOT__dout)) 
                         & (0xaU == vlSelf->top__DOT__cpu__DOT__reg_file__DOT__rf
                            [0x11U]));
    vlSelf->top__DOT__cpu__DOT__rs1_dout = vlSelf->top__DOT__cpu__DOT__reg_file__DOT__rf
        [(0x1fU & (vlSelf->top__DOT__cpu__DOT__dout 
                   >> 0xfU))];
    vlSelf->top__DOT__cpu__DOT__rs2_dout = vlSelf->top__DOT__cpu__DOT__reg_file__DOT__rf
        [(0x1fU & (vlSelf->top__DOT__cpu__DOT__dout 
                   >> 0x14U))];
    vlSelf->top__DOT__cpu__DOT__alu_ctrl_unit__DOT__funct7 
        = (1U & (vlSelf->top__DOT__cpu__DOT__dout >> 0x1eU));
    vlSelf->top__DOT__cpu__DOT__alu_ctrl_unit__DOT__funct3 
        = (7U & (vlSelf->top__DOT__cpu__DOT__dout >> 0xcU));
    vlSelf->top__DOT__cpu__DOT__alu_ctrl_unit__DOT__opcode 
        = (0x7fU & vlSelf->top__DOT__cpu__DOT__dout);
    vlSelf->top__DOT__cpu__DOT__alu_op = ((0x40U & (IData)(vlSelf->top__DOT__cpu__DOT__alu_ctrl_unit__DOT__opcode))
                                           ? ((0x20U 
                                               & (IData)(vlSelf->top__DOT__cpu__DOT__alu_ctrl_unit__DOT__opcode))
                                               ? ((0x10U 
                                                   & (IData)(vlSelf->top__DOT__cpu__DOT__alu_ctrl_unit__DOT__opcode))
                                                   ? 0U
                                                   : 
                                                  ((8U 
                                                    & (IData)(vlSelf->top__DOT__cpu__DOT__alu_ctrl_unit__DOT__opcode))
                                                    ? 0U
                                                    : 
                                                   ((4U 
                                                     & (IData)(vlSelf->top__DOT__cpu__DOT__alu_ctrl_unit__DOT__opcode))
                                                     ? 
                                                    ((2U 
                                                      & (IData)(vlSelf->top__DOT__cpu__DOT__alu_ctrl_unit__DOT__opcode))
                                                      ? 
                                                     ((1U 
                                                       & (IData)(vlSelf->top__DOT__cpu__DOT__alu_ctrl_unit__DOT__opcode))
                                                       ? (IData)(vlSelf->top__DOT__cpu__DOT__alu_ctrl_unit__DOT__opcode)
                                                       : 0U)
                                                      : 0U)
                                                     : 
                                                    ((2U 
                                                      & (IData)(vlSelf->top__DOT__cpu__DOT__alu_ctrl_unit__DOT__opcode))
                                                      ? 
                                                     ((1U 
                                                       & (IData)(vlSelf->top__DOT__cpu__DOT__alu_ctrl_unit__DOT__opcode))
                                                       ? 
                                                      (((IData)(vlSelf->top__DOT__cpu__DOT__alu_ctrl_unit__DOT__funct3) 
                                                        << 7U) 
                                                       | (IData)(vlSelf->top__DOT__cpu__DOT__alu_ctrl_unit__DOT__opcode))
                                                       : 0U)
                                                      : 0U))))
                                               : 0U)
                                           : ((0x20U 
                                               & (IData)(vlSelf->top__DOT__cpu__DOT__alu_ctrl_unit__DOT__opcode))
                                               ? ((0x10U 
                                                   & (IData)(vlSelf->top__DOT__cpu__DOT__alu_ctrl_unit__DOT__opcode))
                                                   ? 
                                                  ((8U 
                                                    & (IData)(vlSelf->top__DOT__cpu__DOT__alu_ctrl_unit__DOT__opcode))
                                                    ? 0U
                                                    : 
                                                   ((4U 
                                                     & (IData)(vlSelf->top__DOT__cpu__DOT__alu_ctrl_unit__DOT__opcode))
                                                     ? 0U
                                                     : 
                                                    ((2U 
                                                      & (IData)(vlSelf->top__DOT__cpu__DOT__alu_ctrl_unit__DOT__opcode))
                                                      ? 
                                                     ((1U 
                                                       & (IData)(vlSelf->top__DOT__cpu__DOT__alu_ctrl_unit__DOT__opcode))
                                                       ? 
                                                      (((IData)(vlSelf->top__DOT__cpu__DOT__alu_ctrl_unit__DOT__funct7) 
                                                        << 0xaU) 
                                                       | (((IData)(vlSelf->top__DOT__cpu__DOT__alu_ctrl_unit__DOT__funct3) 
                                                           << 7U) 
                                                          | (IData)(vlSelf->top__DOT__cpu__DOT__alu_ctrl_unit__DOT__opcode)))
                                                       : 0U)
                                                      : 0U)))
                                                   : 
                                                  ((8U 
                                                    & (IData)(vlSelf->top__DOT__cpu__DOT__alu_ctrl_unit__DOT__opcode))
                                                    ? 0U
                                                    : 
                                                   ((4U 
                                                     & (IData)(vlSelf->top__DOT__cpu__DOT__alu_ctrl_unit__DOT__opcode))
                                                     ? 0U
                                                     : 
                                                    ((2U 
                                                      & (IData)(vlSelf->top__DOT__cpu__DOT__alu_ctrl_unit__DOT__opcode))
                                                      ? 
                                                     ((1U 
                                                       & (IData)(vlSelf->top__DOT__cpu__DOT__alu_ctrl_unit__DOT__opcode))
                                                       ? 
                                                      (0x100U 
                                                       | (IData)(vlSelf->top__DOT__cpu__DOT__alu_ctrl_unit__DOT__opcode))
                                                       : 0U)
                                                      : 0U))))
                                               : ((0x10U 
                                                   & (IData)(vlSelf->top__DOT__cpu__DOT__alu_ctrl_unit__DOT__opcode))
                                                   ? 
                                                  ((8U 
                                                    & (IData)(vlSelf->top__DOT__cpu__DOT__alu_ctrl_unit__DOT__opcode))
                                                    ? 0U
                                                    : 
                                                   ((4U 
                                                     & (IData)(vlSelf->top__DOT__cpu__DOT__alu_ctrl_unit__DOT__opcode))
                                                     ? 0U
                                                     : 
                                                    ((2U 
                                                      & (IData)(vlSelf->top__DOT__cpu__DOT__alu_ctrl_unit__DOT__opcode))
                                                      ? 
                                                     ((1U 
                                                       & (IData)(vlSelf->top__DOT__cpu__DOT__alu_ctrl_unit__DOT__opcode))
                                                       ? 
                                                      (((IData)(vlSelf->top__DOT__cpu__DOT__alu_ctrl_unit__DOT__funct3) 
                                                        << 7U) 
                                                       | (IData)(vlSelf->top__DOT__cpu__DOT__alu_ctrl_unit__DOT__opcode))
                                                       : 0U)
                                                      : 0U)))
                                                   : 
                                                  ((8U 
                                                    & (IData)(vlSelf->top__DOT__cpu__DOT__alu_ctrl_unit__DOT__opcode))
                                                    ? 0U
                                                    : 
                                                   ((4U 
                                                     & (IData)(vlSelf->top__DOT__cpu__DOT__alu_ctrl_unit__DOT__opcode))
                                                     ? 0U
                                                     : 
                                                    ((2U 
                                                      & (IData)(vlSelf->top__DOT__cpu__DOT__alu_ctrl_unit__DOT__opcode))
                                                      ? 
                                                     ((1U 
                                                       & (IData)(vlSelf->top__DOT__cpu__DOT__alu_ctrl_unit__DOT__opcode))
                                                       ? 
                                                      (0x100U 
                                                       | (IData)(vlSelf->top__DOT__cpu__DOT__alu_ctrl_unit__DOT__opcode))
                                                       : 0U)
                                                      : 0U))))));
    vlSelf->top__DOT__cpu__DOT__imm_gen_out = ((0x33U 
                                                == 
                                                (0x7fU 
                                                 & vlSelf->top__DOT__cpu__DOT__dout))
                                                ? 0U
                                                : (
                                                   ((0x13U 
                                                     == 
                                                     (0x7fU 
                                                      & vlSelf->top__DOT__cpu__DOT__dout)) 
                                                    | ((3U 
                                                        == 
                                                        (0x7fU 
                                                         & vlSelf->top__DOT__cpu__DOT__dout)) 
                                                       | (0x67U 
                                                          == 
                                                          (0x7fU 
                                                           & vlSelf->top__DOT__cpu__DOT__dout))))
                                                    ? 
                                                   (((- (IData)(
                                                                (vlSelf->top__DOT__cpu__DOT__dout 
                                                                 >> 0x1fU))) 
                                                     << 0xcU) 
                                                    | (vlSelf->top__DOT__cpu__DOT__dout 
                                                       >> 0x14U))
                                                    : 
                                                   ((0x23U 
                                                     == 
                                                     (0x7fU 
                                                      & vlSelf->top__DOT__cpu__DOT__dout))
                                                     ? 
                                                    (((- (IData)(
                                                                 (vlSelf->top__DOT__cpu__DOT__dout 
                                                                  >> 0x1fU))) 
                                                      << 0xcU) 
                                                     | ((0xfe0U 
                                                         & (vlSelf->top__DOT__cpu__DOT__dout 
                                                            >> 0x14U)) 
                                                        | (0x1fU 
                                                           & (vlSelf->top__DOT__cpu__DOT__dout 
                                                              >> 7U))))
                                                     : 
                                                    ((0x63U 
                                                      == 
                                                      (0x7fU 
                                                       & vlSelf->top__DOT__cpu__DOT__dout))
                                                      ? 
                                                     (((- (IData)(
                                                                  (vlSelf->top__DOT__cpu__DOT__dout 
                                                                   >> 0x1fU))) 
                                                       << 0xdU) 
                                                      | ((0x1000U 
                                                          & (vlSelf->top__DOT__cpu__DOT__dout 
                                                             >> 0x13U)) 
                                                         | ((0x800U 
                                                             & (vlSelf->top__DOT__cpu__DOT__dout 
                                                                << 4U)) 
                                                            | ((0x7e0U 
                                                                & (vlSelf->top__DOT__cpu__DOT__dout 
                                                                   >> 0x14U)) 
                                                               | (0x1eU 
                                                                  & (vlSelf->top__DOT__cpu__DOT__dout 
                                                                     >> 7U))))))
                                                      : 
                                                     ((0x6fU 
                                                       == 
                                                       (0x7fU 
                                                        & vlSelf->top__DOT__cpu__DOT__dout))
                                                       ? 
                                                      (((- (IData)(
                                                                   (vlSelf->top__DOT__cpu__DOT__dout 
                                                                    >> 0x1fU))) 
                                                        << 0x15U) 
                                                       | ((0x100000U 
                                                           & (vlSelf->top__DOT__cpu__DOT__dout 
                                                              >> 0xbU)) 
                                                          | ((0xff000U 
                                                              & vlSelf->top__DOT__cpu__DOT__dout) 
                                                             | ((0x800U 
                                                                 & (vlSelf->top__DOT__cpu__DOT__dout 
                                                                    >> 9U)) 
                                                                | (0x7feU 
                                                                   & (vlSelf->top__DOT__cpu__DOT__dout 
                                                                      >> 0x14U))))))
                                                       : 0U)))));
    vlSelf->top__DOT__cpu__DOT__ALUSrc_out = (((0x33U 
                                                != 
                                                (0x7fU 
                                                 & vlSelf->top__DOT__cpu__DOT__dout)) 
                                               & (0x63U 
                                                  != 
                                                  (0x7fU 
                                                   & vlSelf->top__DOT__cpu__DOT__dout)))
                                               ? vlSelf->top__DOT__cpu__DOT__imm_gen_out
                                               : vlSelf->top__DOT__cpu__DOT__rs2_dout);
    vlSelf->top__DOT__cpu__DOT__alu_result = ((0x40U 
                                               & (IData)(vlSelf->top__DOT__cpu__DOT__alu_op))
                                               ? ((0x20U 
                                                   & (IData)(vlSelf->top__DOT__cpu__DOT__alu_op))
                                                   ? 
                                                  ((0x10U 
                                                    & (IData)(vlSelf->top__DOT__cpu__DOT__alu_op))
                                                    ? 0U
                                                    : 
                                                   ((8U 
                                                     & (IData)(vlSelf->top__DOT__cpu__DOT__alu_op))
                                                     ? 0U
                                                     : 
                                                    ((4U 
                                                      & (IData)(vlSelf->top__DOT__cpu__DOT__alu_op))
                                                      ? 
                                                     ((2U 
                                                       & (IData)(vlSelf->top__DOT__cpu__DOT__alu_op))
                                                       ? 
                                                      ((1U 
                                                        & (IData)(vlSelf->top__DOT__cpu__DOT__alu_op))
                                                        ? 
                                                       (vlSelf->top__DOT__cpu__DOT__rs1_dout 
                                                        + vlSelf->top__DOT__cpu__DOT__ALUSrc_out)
                                                        : 0U)
                                                       : 0U)
                                                      : 0U)))
                                                   : 0U)
                                               : ((0x20U 
                                                   & (IData)(vlSelf->top__DOT__cpu__DOT__alu_op))
                                                   ? 
                                                  ((0x10U 
                                                    & (IData)(vlSelf->top__DOT__cpu__DOT__alu_op))
                                                    ? 
                                                   ((8U 
                                                     & (IData)(vlSelf->top__DOT__cpu__DOT__alu_op))
                                                     ? 0U
                                                     : 
                                                    ((4U 
                                                      & (IData)(vlSelf->top__DOT__cpu__DOT__alu_op))
                                                      ? 0U
                                                      : 
                                                     ((2U 
                                                       & (IData)(vlSelf->top__DOT__cpu__DOT__alu_op))
                                                       ? 
                                                      ((1U 
                                                        & (IData)(vlSelf->top__DOT__cpu__DOT__alu_op))
                                                        ? 
                                                       ((0x400U 
                                                         & (IData)(vlSelf->top__DOT__cpu__DOT__alu_op))
                                                         ? 
                                                        ((0U 
                                                          == 
                                                          (7U 
                                                           & ((IData)(vlSelf->top__DOT__cpu__DOT__alu_op) 
                                                              >> 7U)))
                                                          ? 
                                                         (vlSelf->top__DOT__cpu__DOT__rs1_dout 
                                                          - vlSelf->top__DOT__cpu__DOT__ALUSrc_out)
                                                          : 0U)
                                                         : 
                                                        ((0x200U 
                                                          & (IData)(vlSelf->top__DOT__cpu__DOT__alu_op))
                                                          ? 
                                                         ((0x100U 
                                                           & (IData)(vlSelf->top__DOT__cpu__DOT__alu_op))
                                                           ? 
                                                          ((0x80U 
                                                            & (IData)(vlSelf->top__DOT__cpu__DOT__alu_op))
                                                            ? 
                                                           (vlSelf->top__DOT__cpu__DOT__rs1_dout 
                                                            & vlSelf->top__DOT__cpu__DOT__ALUSrc_out)
                                                            : 
                                                           (vlSelf->top__DOT__cpu__DOT__rs1_dout 
                                                            | vlSelf->top__DOT__cpu__DOT__ALUSrc_out))
                                                           : 
                                                          ((0x80U 
                                                            & (IData)(vlSelf->top__DOT__cpu__DOT__alu_op))
                                                            ? 
                                                           (vlSelf->top__DOT__cpu__DOT__rs1_dout 
                                                            >> 
                                                            (0x1fU 
                                                             & vlSelf->top__DOT__cpu__DOT__ALUSrc_out))
                                                            : 
                                                           (vlSelf->top__DOT__cpu__DOT__rs1_dout 
                                                            ^ vlSelf->top__DOT__cpu__DOT__ALUSrc_out)))
                                                          : 
                                                         ((0x100U 
                                                           & (IData)(vlSelf->top__DOT__cpu__DOT__alu_op))
                                                           ? 0U
                                                           : 
                                                          ((0x80U 
                                                            & (IData)(vlSelf->top__DOT__cpu__DOT__alu_op))
                                                            ? 
                                                           (vlSelf->top__DOT__cpu__DOT__rs1_dout 
                                                            << 
                                                            (0x1fU 
                                                             & vlSelf->top__DOT__cpu__DOT__ALUSrc_out))
                                                            : 
                                                           (vlSelf->top__DOT__cpu__DOT__rs1_dout 
                                                            + vlSelf->top__DOT__cpu__DOT__ALUSrc_out)))))
                                                        : 0U)
                                                       : 0U)))
                                                    : 
                                                   ((8U 
                                                     & (IData)(vlSelf->top__DOT__cpu__DOT__alu_op))
                                                     ? 0U
                                                     : 
                                                    ((4U 
                                                      & (IData)(vlSelf->top__DOT__cpu__DOT__alu_op))
                                                      ? 0U
                                                      : 
                                                     ((2U 
                                                       & (IData)(vlSelf->top__DOT__cpu__DOT__alu_op))
                                                       ? 
                                                      ((1U 
                                                        & (IData)(vlSelf->top__DOT__cpu__DOT__alu_op))
                                                        ? 
                                                       ((2U 
                                                         == 
                                                         (7U 
                                                          & ((IData)(vlSelf->top__DOT__cpu__DOT__alu_op) 
                                                             >> 7U)))
                                                         ? 
                                                        (vlSelf->top__DOT__cpu__DOT__rs1_dout 
                                                         + vlSelf->top__DOT__cpu__DOT__ALUSrc_out)
                                                         : 0U)
                                                        : 0U)
                                                       : 0U))))
                                                   : 
                                                  ((0x10U 
                                                    & (IData)(vlSelf->top__DOT__cpu__DOT__alu_op))
                                                    ? 
                                                   ((8U 
                                                     & (IData)(vlSelf->top__DOT__cpu__DOT__alu_op))
                                                     ? 0U
                                                     : 
                                                    ((4U 
                                                      & (IData)(vlSelf->top__DOT__cpu__DOT__alu_op))
                                                      ? 0U
                                                      : 
                                                     ((2U 
                                                       & (IData)(vlSelf->top__DOT__cpu__DOT__alu_op))
                                                       ? 
                                                      ((1U 
                                                        & (IData)(vlSelf->top__DOT__cpu__DOT__alu_op))
                                                        ? 
                                                       ((0x400U 
                                                         & (IData)(vlSelf->top__DOT__cpu__DOT__alu_op))
                                                         ? 0U
                                                         : 
                                                        ((0x200U 
                                                          & (IData)(vlSelf->top__DOT__cpu__DOT__alu_op))
                                                          ? 
                                                         ((0x100U 
                                                           & (IData)(vlSelf->top__DOT__cpu__DOT__alu_op))
                                                           ? 
                                                          ((0x80U 
                                                            & (IData)(vlSelf->top__DOT__cpu__DOT__alu_op))
                                                            ? 
                                                           (vlSelf->top__DOT__cpu__DOT__rs1_dout 
                                                            & vlSelf->top__DOT__cpu__DOT__ALUSrc_out)
                                                            : 
                                                           (vlSelf->top__DOT__cpu__DOT__rs1_dout 
                                                            | vlSelf->top__DOT__cpu__DOT__ALUSrc_out))
                                                           : 
                                                          ((0x80U 
                                                            & (IData)(vlSelf->top__DOT__cpu__DOT__alu_op))
                                                            ? 
                                                           (vlSelf->top__DOT__cpu__DOT__rs1_dout 
                                                            >> 
                                                            (0x1fU 
                                                             & vlSelf->top__DOT__cpu__DOT__ALUSrc_out))
                                                            : 
                                                           (vlSelf->top__DOT__cpu__DOT__rs1_dout 
                                                            ^ vlSelf->top__DOT__cpu__DOT__ALUSrc_out)))
                                                          : 
                                                         ((0x100U 
                                                           & (IData)(vlSelf->top__DOT__cpu__DOT__alu_op))
                                                           ? 0U
                                                           : 
                                                          ((0x80U 
                                                            & (IData)(vlSelf->top__DOT__cpu__DOT__alu_op))
                                                            ? 
                                                           (vlSelf->top__DOT__cpu__DOT__rs1_dout 
                                                            << 
                                                            (0x1fU 
                                                             & vlSelf->top__DOT__cpu__DOT__ALUSrc_out))
                                                            : 
                                                           (vlSelf->top__DOT__cpu__DOT__rs1_dout 
                                                            + vlSelf->top__DOT__cpu__DOT__ALUSrc_out)))))
                                                        : 0U)
                                                       : 0U)))
                                                    : 
                                                   ((8U 
                                                     & (IData)(vlSelf->top__DOT__cpu__DOT__alu_op))
                                                     ? 0U
                                                     : 
                                                    ((4U 
                                                      & (IData)(vlSelf->top__DOT__cpu__DOT__alu_op))
                                                      ? 0U
                                                      : 
                                                     ((2U 
                                                       & (IData)(vlSelf->top__DOT__cpu__DOT__alu_op))
                                                       ? 
                                                      ((1U 
                                                        & (IData)(vlSelf->top__DOT__cpu__DOT__alu_op))
                                                        ? 
                                                       ((2U 
                                                         == 
                                                         (7U 
                                                          & ((IData)(vlSelf->top__DOT__cpu__DOT__alu_op) 
                                                             >> 7U)))
                                                         ? 
                                                        (vlSelf->top__DOT__cpu__DOT__rs1_dout 
                                                         + vlSelf->top__DOT__cpu__DOT__ALUSrc_out)
                                                         : 0U)
                                                        : 0U)
                                                       : 0U))))));
    vlSelf->top__DOT__cpu__DOT__PCSrc1_out = (((((1U 
                                                  & ((IData)(vlSelf->top__DOT__cpu__DOT__alu_op) 
                                                     >> 6U)) 
                                                 && ((1U 
                                                      & ((IData)(vlSelf->top__DOT__cpu__DOT__alu_op) 
                                                         >> 5U)) 
                                                     && ((1U 
                                                          & (~ 
                                                             ((IData)(vlSelf->top__DOT__cpu__DOT__alu_op) 
                                                              >> 4U))) 
                                                         && ((1U 
                                                              & (~ 
                                                                 ((IData)(vlSelf->top__DOT__cpu__DOT__alu_op) 
                                                                  >> 3U))) 
                                                             && ((1U 
                                                                  & (~ 
                                                                     ((IData)(vlSelf->top__DOT__cpu__DOT__alu_op) 
                                                                      >> 2U))) 
                                                                 && ((1U 
                                                                      & ((IData)(vlSelf->top__DOT__cpu__DOT__alu_op) 
                                                                         >> 1U)) 
                                                                     && ((1U 
                                                                          & (IData)(vlSelf->top__DOT__cpu__DOT__alu_op)) 
                                                                         && ((1U 
                                                                              & (~ 
                                                                                ((IData)(vlSelf->top__DOT__cpu__DOT__alu_op) 
                                                                                >> 0xaU))) 
                                                                             && ((0x200U 
                                                                                & (IData)(vlSelf->top__DOT__cpu__DOT__alu_op))
                                                                                 ? 
                                                                                ((1U 
                                                                                & (~ 
                                                                                ((IData)(vlSelf->top__DOT__cpu__DOT__alu_op) 
                                                                                >> 8U))) 
                                                                                && ((0x80U 
                                                                                & (IData)(vlSelf->top__DOT__cpu__DOT__alu_op))
                                                                                 ? 
                                                                                (vlSelf->top__DOT__cpu__DOT__rs1_dout 
                                                                                >= vlSelf->top__DOT__cpu__DOT__ALUSrc_out)
                                                                                 : 
                                                                                (vlSelf->top__DOT__cpu__DOT__rs1_dout 
                                                                                < vlSelf->top__DOT__cpu__DOT__ALUSrc_out)))
                                                                                 : 
                                                                                ((1U 
                                                                                & (~ 
                                                                                ((IData)(vlSelf->top__DOT__cpu__DOT__alu_op) 
                                                                                >> 8U))) 
                                                                                && ((0x80U 
                                                                                & (IData)(vlSelf->top__DOT__cpu__DOT__alu_op))
                                                                                 ? 
                                                                                (vlSelf->top__DOT__cpu__DOT__rs1_dout 
                                                                                != vlSelf->top__DOT__cpu__DOT__ALUSrc_out)
                                                                                 : 
                                                                                (vlSelf->top__DOT__cpu__DOT__rs1_dout 
                                                                                == vlSelf->top__DOT__cpu__DOT__ALUSrc_out)))))))))))) 
                                                & (0x63U 
                                                   == 
                                                   (0x7fU 
                                                    & vlSelf->top__DOT__cpu__DOT__dout))) 
                                               | (0x6fU 
                                                  == 
                                                  (0x7fU 
                                                   & vlSelf->top__DOT__cpu__DOT__dout)))
                                               ? (vlSelf->top__DOT__cpu__DOT__current_pc 
                                                  + vlSelf->top__DOT__cpu__DOT__imm_gen_out)
                                               : ((IData)(4U) 
                                                  + vlSelf->top__DOT__cpu__DOT__current_pc));
}

void Vtop___024root___eval_nba(Vtop___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___eval_nba\n"); );
    // Body
    if ((1ULL & vlSelf->__VnbaTriggered.word(0U))) {
        Vtop___024root___nba_sequent__TOP__0(vlSelf);
        vlSelf->__Vm_traceActivity[1U] = 1U;
    }
}

void Vtop___024root___eval_triggers__act(Vtop___024root* vlSelf);

bool Vtop___024root___eval_phase__act(Vtop___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___eval_phase__act\n"); );
    // Init
    VlTriggerVec<1> __VpreTriggered;
    CData/*0:0*/ __VactExecute;
    // Body
    Vtop___024root___eval_triggers__act(vlSelf);
    __VactExecute = vlSelf->__VactTriggered.any();
    if (__VactExecute) {
        __VpreTriggered.andNot(vlSelf->__VactTriggered, vlSelf->__VnbaTriggered);
        vlSelf->__VnbaTriggered.thisOr(vlSelf->__VactTriggered);
        Vtop___024root___eval_act(vlSelf);
    }
    return (__VactExecute);
}

bool Vtop___024root___eval_phase__nba(Vtop___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___eval_phase__nba\n"); );
    // Init
    CData/*0:0*/ __VnbaExecute;
    // Body
    __VnbaExecute = vlSelf->__VnbaTriggered.any();
    if (__VnbaExecute) {
        Vtop___024root___eval_nba(vlSelf);
        vlSelf->__VnbaTriggered.clear();
    }
    return (__VnbaExecute);
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vtop___024root___dump_triggers__nba(Vtop___024root* vlSelf);
#endif  // VL_DEBUG
#ifdef VL_DEBUG
VL_ATTR_COLD void Vtop___024root___dump_triggers__act(Vtop___024root* vlSelf);
#endif  // VL_DEBUG

void Vtop___024root___eval(Vtop___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___eval\n"); );
    // Init
    IData/*31:0*/ __VnbaIterCount;
    CData/*0:0*/ __VnbaContinue;
    // Body
    __VnbaIterCount = 0U;
    __VnbaContinue = 1U;
    while (__VnbaContinue) {
        if (VL_UNLIKELY((0x64U < __VnbaIterCount))) {
#ifdef VL_DEBUG
            Vtop___024root___dump_triggers__nba(vlSelf);
#endif
            VL_FATAL_MT("top.v", 2, "", "NBA region did not converge.");
        }
        __VnbaIterCount = ((IData)(1U) + __VnbaIterCount);
        __VnbaContinue = 0U;
        vlSelf->__VactIterCount = 0U;
        vlSelf->__VactContinue = 1U;
        while (vlSelf->__VactContinue) {
            if (VL_UNLIKELY((0x64U < vlSelf->__VactIterCount))) {
#ifdef VL_DEBUG
                Vtop___024root___dump_triggers__act(vlSelf);
#endif
                VL_FATAL_MT("top.v", 2, "", "Active region did not converge.");
            }
            vlSelf->__VactIterCount = ((IData)(1U) 
                                       + vlSelf->__VactIterCount);
            vlSelf->__VactContinue = 0U;
            if (Vtop___024root___eval_phase__act(vlSelf)) {
                vlSelf->__VactContinue = 1U;
            }
        }
        if (Vtop___024root___eval_phase__nba(vlSelf)) {
            __VnbaContinue = 1U;
        }
    }
}

#ifdef VL_DEBUG
void Vtop___024root___eval_debug_assertions(Vtop___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___eval_debug_assertions\n"); );
    // Body
    if (VL_UNLIKELY((vlSelf->reset & 0xfeU))) {
        Verilated::overWidthError("reset");}
    if (VL_UNLIKELY((vlSelf->clk & 0xfeU))) {
        Verilated::overWidthError("clk");}
}
#endif  // VL_DEBUG
