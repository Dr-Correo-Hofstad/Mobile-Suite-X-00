-- ============================================================================
-- PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - PILOT OPERATIONS INFRA
-- MODULE: CHEST HATCH MULTIPLEXER WAVE DRIVER LOGIC (GENERATE_WAVE_LOGIC_C_HATCH.VHD)
-- CONFIGURATION TARGET: RESISTOR-FREE SLIDING HATCH LOCK SWITCHING
-- DESIGN STANDARDS: 16-STATE HEXADECIMAL LIGHT PULSE PARITY (0.0V - 1.0V)
-- ============================================================================

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Generate_Wave_Logic_C_Hatch is
    Port (
        -- Master Analog Chessboard Light Pulse Addresses (0.0V to 1.0V steps)
        Analog_Address_In      : in  STD_LOGIC_VECTOR(3 downto 0); 
        Lattice_Air_Gap_Open   : in  STD_LOGIC; -- Hardware fault isolation monitor bit
        
        -- Target Chest Hatch Actuator Selection Channels (Runner C Cores)
        Hatch_Frame_Slider     : out STD_LOGIC; -- C1/C2 Cockpit Access Slider Rails
        Breastplate_Split_Gate : out STD_LOGIC; -- C3/C4 Parabolic Opening Flaps
        Tongue_Groove_Lock     : out STD_LOGIC; -- Hardwired high-pressure latch seals
        Trauma_Overflow_Shunt  : out STD_LOGIC  -- Core shield / Reflex bus override
    );
end Generate_Wave_Logic_C_Hatch;

architecture Solid_State_Architecture of Generate_Wave_Logic_C_Hatch is
    -- Internal mapping states corresponding directly to the 16-State conversion matrix
    constant ADDR_GROUND_IDLE : STD_LOGIC_VECTOR(3 downto 0) := "0000"; -- 0.0000V (State 00)
    constant ADDR_PRECISION   : STD_LOGIC_VECTOR(3 downto 0) := "0011"; -- 0.1875V (State 03)
    constant ADDR_QUIESCENT   : STD_LOGIC_VECTOR(3 downto 0) := "0100"; -- 0.2500V (State 04)
    constant ADDR_INTER_BAL   : STD_LOGIC_VECTOR(3 downto 0) := "0110"; -- 0.3750V (State 06)
    constant ADDR_ACTIVE_DOCK : STD_LOGIC_VECTOR(3 downto 0) := "1100"; -- 0.7500V (State 12)
    constant ADDR_FLT_LOCK    : STD_LOGIC_VECTOR(3 downto 0) := "1110"; -- 0.8750V (State 14)
    constant ADDR_OVERLOAD    : STD_LOGIC_VECTOR(3 downto 0) := "1111"; -- 0.9375V (State 15)
begin

    -- Deterministic asynchronous multiplexing loop operating with near-zero gate lag
    process(Analog_Address_In, Lattice_Air_Gap_Open)
    begin
        -- Enforce a zero-current baseline across all channels by default
        Hatch_Frame_Slider     <= '0';
        Breastplate_Split_Gate <= '0';
        Tongue_Groove_Lock     <= '0';
        Trauma_Overflow_Shunt  <= '0';

        if (Lattice_Air_Gap_Open = '1') then
            -- Snap-circuit gold bridge is physically fractured; absolute data insulation active
            Trauma_Overflow_Shunt <= '0'; -- Terminate lines to shield the UNIVAC IX
            
        else
            case Analog_Address_In is
                when ADDR_GROUND_IDLE =>
                    -- System Ground: All hatch and breastplate actuators relaxed
                    null;
                    
                when ADDR_PRECISION =>
                    -- Fine-motor adjustment: Low-current trim pulse to alignment guide tracks
                    Hatch_Frame_Slider     <= '1';
                    
                when ADDR_QUIESCENT =>
                    -- Standard hangar stance: Constant low-amperage holding pressure
                    Hatch_Frame_Slider     <= '1';
                    Tongue_Groove_Lock     <= '1';
                    
                when ADDR_INTER_BAL =>
                    -- Dynamic rebalancing shift: Hatch tracks micro-adjust structural parameters
                    Hatch_Frame_Slider     <= '1';
                    Breastplate_Split_Gate <= '1';
                    
                when ADDR_ACTIVE_DOCK =>
                    -- Active Pod Docking / Egress cycle: Full split-opening current ignition
                    Hatch_Frame_Slider     <= '1';
                    Breastplate_Split_Gate <= '1';
                    
                when ADDR_FLT_LOCK =>
                    -- Flight Stance Hermetic Hard-Lock: Seals chest against entry friction
                    Tongue_Groove_Lock     <= '1'; -- Maximum mechanical clamping active
                    
                when ADDR_OVERLOAD =>
                    -- Traumatic breastplate impact: Forces open the high-voltage Zener crowbar shunt
                    Trauma_Overflow_Shunt  <= '1'; 
                    Tongue_Groove_Lock     <= '1'; -- Emergency hardwired backup seal seal hold
                    
                when others =>
                    -- Catch-all for decommissioned registers or illegal 1.000V levels
                    null;
            end case;
        end if;
    end process;

end Solid_State_Architecture;
