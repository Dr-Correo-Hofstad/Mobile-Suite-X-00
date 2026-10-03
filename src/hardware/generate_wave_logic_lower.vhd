-- ============================================================================
-- PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - SOLID-STATE LOWER LIMB INFRA
-- MODULE: KNEE & PELVIC MULTIPLEXER WAVE DRIVER LOGIC (GENERATE_WAVE_LOGIC_LOWER.VHD)
-- CONFIGURATION TARGET: RESISTOR-FREE MICRO-CYCLOIDAL ACTUATOR SWITCHING
-- DESIGN STANDARDS: 16-STATE HEXADECIMAL LIGHT PULSE PARITY (0.0V - 1.0V)
-- ============================================================================

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Generate_Wave_Logic_Lower is
    Port (
        -- Master Analog Chessboard Light Pulse Addresses (0.0V to 1.0V steps)
        Analog_Address_In      : in  STD_LOGIC_VECTOR(3 downto 0); 
        Lattice_Air_Gap_Open   : in  STD_LOGIC; -- Hardware fault isolation monitor bit
        
        -- Target Lower Actuator Selection Channels (Runner F and Runner H Cores)
        Knee_Lock_Actuator     : out STD_LOGIC; -- F1/F2 Maglev Cushion Barrier
        Thigh_Axial_Thrust     : out STD_LOGIC; -- B24/B25 Locomotion Drive Loop
        Ankle_Swivel_Actuator  : out STD_LOGIC; -- H14/H15 Active Steering Track
        Pelvic_Clamping_Yoke   : out STD_LOGIC; -- A3/A4 Heavy Torsional Support
        Trauma_Overflow_Shunt  : out STD_LOGIC  -- Core shield / Life support override
    );
end Generate_Wave_Logic_Lower;

architecture Solid_State_Architecture of Generate_Wave_Logic_Lower is
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
        Knee_Lock_Actuator     <= '0';
        Thigh_Axial_Thrust     <= '0';
        Ankle_Swivel_Actuator  <= '0';
        Pelvic_Clamping_Yoke   <= '0';
        Trauma_Overflow_Shunt  <= '0';

        if (Lattice_Air_Gap_Open = '1') then
            -- Snap-circuit gold bridge is physically fractured; absolute data insulation active
            Trauma_Overflow_Shunt <= '0'; -- Terminate lines to shield the UNIVAC IX
            
        else
            case Analog_Address_In is
                when ADDR_GROUND_IDLE =>
                    -- System Ground: All joint micro-actuators relaxed
                    null;
                    
                when ADDR_PRECISION =>
                    -- Fine-motor adjustment: Low-current trim pulse to ankle swivels
                    Ankle_Swivel_Actuator <= '1';
                    
                when ADDR_QUIESCENT =>
                    -- Standard stance hold: Constant low-amperage retention voltage step
                    Knee_Lock_Actuator    <= '1';
                    Pelvic_Clamping_Yoke  <= '1';
                    
                when ADDR_INTER_BAL =>
                    -- Dynamic rebalancing shift: Alters joint pre-load parameters
                    Knee_Lock_Actuator    <= '1';
                    Ankle_Swivel_Actuator <= '1';
                    
                when ADDR_ACTIVE_RUN =>
                    -- High-velocity running takeoff loop: Direct square-wave current ignition
                    Knee_Lock_Actuator    <= '1';
                    Thigh_Axial_Thrust    <= '1';
                    Ankle_Swivel_Actuator <= '1';
                    Pelvic_Clamping_Yoke  <= '1';
                    
                when ADDR_MAX_WEAPON =>
                    -- Firing stance engagement: Absolute hard-lock to absorb buster rifle recoil
                    Knee_Lock_Actuator    <= '1';
                    Ankle_Swivel_Actuator <= '1';
                    Pelvic_Clamping_Yoke  <= '1';
                    
                when ADDR_OVERLOAD =>
                    -- Traumatic landing impact / Ballistic shove state: Funnels surge straight to shield
                    Trauma_Overflow_Shunt <= '1'; -- Forces open the high-voltage Zener crowbar
                    Knee_Lock_Actuator    <= '1';
                    Pelvic_Clamping_Yoke  <= '1';
                    
                when others =>
                    -- Catch-all for decommissioned registers or illegal 1.000V levels
                    null;
            end case;
        end if;
    end process;

end Solid_State_Architecture;
