-- ============================================================================
-- PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - AVIONICS INTERFACE INFRA
-- MODULE: LOWER WING MULTIPLEXER WAVE DRIVER LOGIC (GENERATE_WAVE_LOGIC_E_LOWER.VHD)
-- CONFIGURATION TARGET: RESISTOR-FREE CYCLOIDAL WING FOLDING LINK SWITCHING
-- DESIGN STANDARDS: 16-STATE HEXADECIMAL LIGHT PULSE PARITY (0.0V - 1.0V)
-- ============================================================================

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Generate_Wave_Logic_E_Lower is
    Port (
        -- Master Analog Chessboard Light Pulse Addresses (0.0V to 1.0V steps)
        Analog_Address_In      : in  STD_LOGIC_VECTOR(3 downto 0); 
        Lattice_Air_Gap_Open   : in  STD_LOGIC; -- Hardware fault isolation monitor bit
        
        -- Target Lower Wing Actuator Selection Channels (Runner E Cores)
        Lower_Stabilizer_Sweep : out STD_LOGIC; -- E11/E12 Folding Linkage Coils
        Folding_Gear_Rail_Lock : out STD_LOGIC; -- Automated trailing hinge retention yokes
        Inductive_Coupler_Gate : out STD_LOGIC; -- Cross-segment wireless communication pads
        Trauma_Overflow_Shunt  : out STD_LOGIC  -- Core shield / Reflex bus override
    );
end Generate_Wave_Logic_E_Lower;

architecture Solid_State_Architecture of Generate_Wave_Logic_E_Lower is
    -- Internal mapping states corresponding directly to the 16-State conversion matrix
    constant ADDR_GROUND_IDLE : STD_LOGIC_VECTOR(3 downto 0) := "0000"; -- 0.0000V (State 00)
    constant ADDR_PRECISION   : STD_LOGIC_VECTOR(3 downto 0) := "0011"; -- 0.1875V (State 03)
    constant ADDR_QUIESCENT   : STD_LOGIC_VECTOR(3 downto 0) := "0100"; -- 0.2500V (State 04)
    constant ADDR_INTER_BAL   : STD_LOGIC_VECTOR(3 downto 0) := "0110"; -- 0.3750V (State 06)
    constant ADDR_ACTIVE_SWP  : STD_LOGIC_VECTOR(3 downto 0) := "1100"; -- 0.7500V (State 12)
    constant ADDR_ENTRY_SHRD  : STD_LOGIC_VECTOR(3 downto 0) := "1110"; -- 0.8750V (State 14)
    constant ADDR_OVERLOAD    : STD_LOGIC_VECTOR(3 downto 0) := "1111"; -- 0.9375V (State 15)
begin

    -- Deterministic asynchronous multiplexing loop operating with near-zero gate lag
    process(Analog_Address_In, Lattice_Air_Gap_Open)
    begin
        -- Enforce a zero-current baseline across all channels by default
        Lower_Stabilizer_Sweep <= '0';
        Folding_Gear_Rail_Lock <= '0';
        Inductive_Coupler_Gate <= '0';
        Trauma_Overflow_Shunt  <= '0';

        if (Lattice_Air_Gap_Open = '1') then
            -- Snap-circuit gold bridge is physically fractured; absolute data insulation active
            Trauma_Overflow_Shunt <= '0'; -- Terminate lines to shield the UNIVAC IX
            
        else
            case Analog_Address_In is
                when ADDR_GROUND_IDLE =>
                    -- System Ground: All lower folding tracks relaxed
                    null;
                    
                when ADDR_PRECISION =>
                    -- Fine-motor adjustment: Low-current trim pulse to inductive data-transfer pads
                    Inductive_Coupler_Gate <= '1';
                    
                when ADDR_QUIESCENT =>
                    -- Standard Cruise Profile: Constant low-amperage retention voltage step
                    Folding_Gear_Rail_Lock <= '1';
                    Inductive_Coupler_Gate <= '1';
                    
                when ADDR_INTER_BAL =>
                    -- Dynamic rebalancing shift: Folding tracks micro-adjust structural parameters
                    Folding_Gear_Rail_Lock <= '1';
                    Lower_Stabilizer_Sweep <= '1';
                    
                when ADDR_ACTIVE_SWP =>
                    -- Active Supersonic Geometric Transition Loop: Full tracking slide current ignition
                    Lower_Stabilizer_Sweep <= '1';
                    Folding_Gear_Rail_Lock <= '1';
                    
                when ADDR_ENTRY_SHRD =>
                    -- Atmospheric Entry Mode: Clamps lower wing stabilizers tightly over cockpit
                    Lower_Stabilizer_Sweep <= '1'; -- Maximum mechanical clamping active
                    Folding_Gear_Rail_Lock <= '1'; 
                    Inductive_Coupler_Gate <= '1'; -- Activates sub-armor aeroelastic barrel caps
                    
                when ADDR_OVERLOAD =>
                    -- Traumatic folding joint impact: Forces open the high-voltage Zener crowbar shunt
                    Trauma_Overflow_Shunt  <= '1'; 
                    Folding_Gear_Rail_Lock <= '1'; -- Emergency hardwired backup lock hold
                    
                when others =>
                    -- Catch-all for decommissioned registers or illegal 1.000V levels
                    null;
            end case;
        end if;
    end process;

end Solid_State_Architecture;
