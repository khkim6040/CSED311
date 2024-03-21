// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vtop.h for the primary calling header

#include "Vtop__pch.h"
#include "Vtop___024root.h"

VL_ATTR_COLD void Vtop___024root___eval_static(Vtop___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___eval_static\n"); );
}

VL_ATTR_COLD void Vtop___024root___eval_initial(Vtop___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___eval_initial\n"); );
    // Body
    vlSelf->__Vtrigprevexpr___TOP__clk__0 = vlSelf->clk;
}

VL_ATTR_COLD void Vtop___024root___eval_final(Vtop___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___eval_final\n"); );
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vtop___024root___dump_triggers__stl(Vtop___024root* vlSelf);
#endif  // VL_DEBUG
VL_ATTR_COLD bool Vtop___024root___eval_phase__stl(Vtop___024root* vlSelf);

VL_ATTR_COLD void Vtop___024root___eval_settle(Vtop___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___eval_settle\n"); );
    // Init
    IData/*31:0*/ __VstlIterCount;
    CData/*0:0*/ __VstlContinue;
    // Body
    __VstlIterCount = 0U;
    vlSelf->__VstlFirstIteration = 1U;
    __VstlContinue = 1U;
    while (__VstlContinue) {
        if (VL_UNLIKELY((0x64U < __VstlIterCount))) {
#ifdef VL_DEBUG
            Vtop___024root___dump_triggers__stl(vlSelf);
#endif
            VL_FATAL_MT("top.v", 2, "", "Settle region did not converge.");
        }
        __VstlIterCount = ((IData)(1U) + __VstlIterCount);
        __VstlContinue = 0U;
        if (Vtop___024root___eval_phase__stl(vlSelf)) {
            __VstlContinue = 1U;
        }
        vlSelf->__VstlFirstIteration = 0U;
    }
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vtop___024root___dump_triggers__stl(Vtop___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___dump_triggers__stl\n"); );
    // Body
    if ((1U & (~ (IData)(vlSelf->__VstlTriggered.any())))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if ((1ULL & vlSelf->__VstlTriggered.word(0U))) {
        VL_DBG_MSGF("         'stl' region trigger index 0 is active: Internal 'stl' trigger - first iteration\n");
    }
}
#endif  // VL_DEBUG

VL_ATTR_COLD void Vtop___024root___stl_sequent__TOP__0(Vtop___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___stl_sequent__TOP__0\n"); );
    // Body
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

VL_ATTR_COLD void Vtop___024root___eval_stl(Vtop___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___eval_stl\n"); );
    // Body
    if ((1ULL & vlSelf->__VstlTriggered.word(0U))) {
        Vtop___024root___stl_sequent__TOP__0(vlSelf);
        vlSelf->__Vm_traceActivity[1U] = 1U;
        vlSelf->__Vm_traceActivity[0U] = 1U;
    }
}

VL_ATTR_COLD void Vtop___024root___eval_triggers__stl(Vtop___024root* vlSelf);

VL_ATTR_COLD bool Vtop___024root___eval_phase__stl(Vtop___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___eval_phase__stl\n"); );
    // Init
    CData/*0:0*/ __VstlExecute;
    // Body
    Vtop___024root___eval_triggers__stl(vlSelf);
    __VstlExecute = vlSelf->__VstlTriggered.any();
    if (__VstlExecute) {
        Vtop___024root___eval_stl(vlSelf);
    }
    return (__VstlExecute);
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vtop___024root___dump_triggers__act(Vtop___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___dump_triggers__act\n"); );
    // Body
    if ((1U & (~ (IData)(vlSelf->__VactTriggered.any())))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if ((1ULL & vlSelf->__VactTriggered.word(0U))) {
        VL_DBG_MSGF("         'act' region trigger index 0 is active: @(posedge clk)\n");
    }
}
#endif  // VL_DEBUG

#ifdef VL_DEBUG
VL_ATTR_COLD void Vtop___024root___dump_triggers__nba(Vtop___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___dump_triggers__nba\n"); );
    // Body
    if ((1U & (~ (IData)(vlSelf->__VnbaTriggered.any())))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if ((1ULL & vlSelf->__VnbaTriggered.word(0U))) {
        VL_DBG_MSGF("         'nba' region trigger index 0 is active: @(posedge clk)\n");
    }
}
#endif  // VL_DEBUG

VL_ATTR_COLD void Vtop___024root___ctor_var_reset(Vtop___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___ctor_var_reset\n"); );
    // Body
    vlSelf->reset = VL_RAND_RESET_I(1);
    vlSelf->clk = VL_RAND_RESET_I(1);
    vlSelf->is_halted = VL_RAND_RESET_I(1);
    for (int __Vi0 = 0; __Vi0 < 32; ++__Vi0) {
        vlSelf->print_reg[__Vi0] = VL_RAND_RESET_I(32);
    }
    vlSelf->top__DOT__cpu__DOT__alu_op = VL_RAND_RESET_I(11);
    vlSelf->top__DOT__cpu__DOT__dout = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__cpu__DOT__write_enable = VL_RAND_RESET_I(1);
    vlSelf->top__DOT__cpu__DOT__PCSrc1_out = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__cpu__DOT__rs1_dout = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__cpu__DOT__rs2_dout = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__cpu__DOT__imm_gen_out = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__cpu__DOT__alu_result = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__cpu__DOT__ALUSrc_out = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__cpu__DOT__current_pc = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__cpu__DOT__imem__DOT__i = VL_RAND_RESET_I(32);
    for (int __Vi0 = 0; __Vi0 < 1024; ++__Vi0) {
        vlSelf->top__DOT__cpu__DOT__imem__DOT__mem[__Vi0] = VL_RAND_RESET_I(32);
    }
    vlSelf->top__DOT__cpu__DOT__reg_file__DOT__i = VL_RAND_RESET_I(32);
    for (int __Vi0 = 0; __Vi0 < 32; ++__Vi0) {
        vlSelf->top__DOT__cpu__DOT__reg_file__DOT__rf[__Vi0] = VL_RAND_RESET_I(32);
    }
    vlSelf->top__DOT__cpu__DOT__alu_ctrl_unit__DOT__funct7 = VL_RAND_RESET_I(1);
    vlSelf->top__DOT__cpu__DOT__alu_ctrl_unit__DOT__funct3 = VL_RAND_RESET_I(3);
    vlSelf->top__DOT__cpu__DOT__alu_ctrl_unit__DOT__opcode = VL_RAND_RESET_I(7);
    vlSelf->top__DOT__cpu__DOT__dmem__DOT__i = VL_RAND_RESET_I(32);
    for (int __Vi0 = 0; __Vi0 < 16384; ++__Vi0) {
        vlSelf->top__DOT__cpu__DOT__dmem__DOT__mem[__Vi0] = VL_RAND_RESET_I(32);
    }
    vlSelf->__Vtrigprevexpr___TOP__clk__0 = VL_RAND_RESET_I(1);
    for (int __Vi0 = 0; __Vi0 < 2; ++__Vi0) {
        vlSelf->__Vm_traceActivity[__Vi0] = 0;
    }
}
