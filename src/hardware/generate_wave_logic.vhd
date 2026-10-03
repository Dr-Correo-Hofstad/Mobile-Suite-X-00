-- ============================================================================
-- PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - SOLID-STATE MANIPULATOR INFRA
-- MODULE: HAND MULTIPLEXER WAVE DRIVER LOGIC (GENERATE_WAVE_LOGIC.VHD)
-- CONFIGURATION TARGET: RESISTOR-FREE MICRO-CYCLOIDAL FINGER JOINT SWITCHING
-- DESIGN STANDARDS: 16-STATE HEXADECIMAL LIGHT PULSE PARITY (0.0V - 1.0V)
-- ============================================================================

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Generate_Wave_Logic is
    Port (
        -- Master Analog Chessboard Light Pulse Addresses (0.0V to 1.0V steps)
        Analog_Address_In      : in  STD_LOGIC_VECTOR(3 downto 0); 
        Lattice_Air_Gap_Open   : in  STD_LOGIC; -- Hardware fault isolation monitor bit
        
        -- Target Manipulator Actuator Selection Channels (Fingers J1 through J8)
        Proximal_Knuckle_Drive : out STD_LOGIC; -- J1/J2 Core Clamping Loop
        Middle_Phalanx_Drive   : out STD_LOGIC; -- J3/J4 Rotational Torque Strut
        Distal_Shield_Shunt    : out STD_LOGIC; -- J7/J8 Sub-Armor Capacitor Gate
        Unsuppressed_Error     : out STD_LOGIC  -- Core status warning rail
    );
end Generate_Wave_Logic;

architecture Solid_State_Architecture of Generate_Wave_Logic is
    -- Internal mapping states corresponding directly to the 16-State conversion matrix
    constant ADDR_GROUND_IDLE : STD_LOGIC_VECTOR(3 downto 0) := "0000"; -- 0.0000V (State 00)
    constant ADDR_PRECISION   : STD_LOGIC_VECTOR(3 downto 0) := "0011"; -- 0.1875V (State 03)
    constant ADDR_QUIESCENT   : STD_LOGIC_VECTOR(3 downto 0) := "0100"; -- 0.2500V (State 04)
    constant ADDR_INTER_BAL   : STD_LOGIC_VECTOR(3 downto 0) := "0110"; -- 0.3750V (State 06)
    constant ADDR_ACTIVE_RUN  : STD_LOGIC_VECTOR(3 downto 0) := "1100"; -- 0.7500V (State 12)
    constant ADDR_MAX_WEAPON  : STD_LOGIC_VECTOR(3 downto 0) := "1110"; -- 0.8750V (State 14)
    constant ADDR_OVERLOAD    : STD_LOGIC_VECTOR(3 downto 0) := "1111"; -- 0.9375V (State 15)
begin

    -- Deterministic asynchronous multiplexing loop operating with near-zero gate lag
    process(Analog_Address_In, Lattice_Air_Gap_Open)
    begin
        -- Enforce a zero-current baseline across all channels by default
        Proximal_Knuckle_Drive <= '0';
        Middle_Phalanx_Drive   <= '0';
        Distal_Shield_Shunt    <= '0';
        Unsuppressed_Error     <= '0';

        if (Lattice_Air_Gap_Open = '1') then
            -- Snap-circuit gold bridge is physically fractured; absolute data insulation active
            Unsuppressed_Error <= '1'; -- Signal line completely isolated to shield the UNIVAC IX
            
        else
            case Analog_Address_In is
                when ADDR_GROUND_IDLE =>
                    -- System Ground: All finger micro-actuators relaxed
                    null;
                    
                when ADDR_PRECISION =>
                    -- Fine-motor adjustment: Low-current trim pulse to proximal joints
                    Proximal_Knuckle_Drive <= '1';
                    
                when ADDR_QUIESCENT =>
                    -- Standard grip hold: Constant low-amperage retention voltage step
                    Proximal_Knuckle_Drive <= '1';
                    Middle_Phalanx_Drive   <= '1';
                    
                when ADDR_INTER_BAL =>
                    -- Dynamic rebalancing shift: Alters joint pre-load parameters
                    Middle_Phalanx_Drive   <= '1';
                    
                when ADDR_ACTIVE_RUN =>
                    -- High-velocity weapon clamp loop: Direct square-wave current ignition
                    Proximal_Knuckle_Drive <= '1';
                    Middle_Phalanx_Drive   <= '1';
                    Distal_Shield_Shunt    <= '1'; -- Opens sub-armor capacitor intake paths
                    
                when ADDR_MAX_WEAPON =>
                    -- Firing stance engagement: Absolute hard-lock to absorb buster rifle recoil
                    Proximal_Knuckle_Drive <= '1';
                    Middle_Phalanx_Drive   <= '1';
                    Distal_Shield_Shunt    <= '1';
                    
                when ADDR_OVERLOAD =>
                    -- Traumatic impact / Ballistic shove state: Funnels surge straight to shield
                    Distal_Shield_Shunt    <= '1'; -- Forces open the high-voltage Zener crowbar
                    Unsuppressed_Error     <= '1';
                    
                when others =>
                    -- Catch-all for decommissioned registers or illegal 1.000V levels
                    Unsuppressed_Error     <= '1';
            end case;
        end if;
    end process;

end Solid_State_Architecture;
