-- ============================================================================
-- PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - SOLID-STATE SENSOR INFRA
-- MODULE: HEAD MULTIPLEXER WAVE DRIVER LOGIC (GENERATE_WAVE_LOGIC_HEAD.VHD)
-- CONFIGURATION TARGET: RESISTOR-FREE MICRO-ACTUATOR SENSOR ARRAY SWITCHING
-- DESIGN STANDARDS: 16-STATE HEXADECIMAL LIGHT PULSE PARITY (0.0V - 1.0V)
-- ============================================================================

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Generate_Wave_Logic_Head is
    Port (
        -- Master Analog Chessboard Light Pulse Addresses (0.0V to 1.0V steps)
        Analog_Address_In      : in  STD_LOGIC_VECTOR(3 downto 0); 
        Lattice_Air_Gap_Open   : in  STD_LOGIC; -- Hardware fault isolation monitor bit
        
        -- Target Head Sensor Selection Channels (Runner A and Runner B Cores)
        Main_Camera_Bracket    : out STD_LOGIC; -- A1 Primary Optical Targeting Frame
        Viewport_Eye_Housings  : out STD_LOGIC; -- A11/A12 Binocular Camera Beds
        Neck_Universal_Spline  : out STD_LOGIC; -- B23 Dual-Axis Panning Knuckle
        Antenna_Waveguide_Gate : out STD_LOGIC; -- B21 Long-Range SatCom Waveguide Vane
        Trauma_Overflow_Shunt  : out STD_LOGIC  -- Core shield / Visor protection override
    );
end Generate_Wave_Logic_Head;

architecture Solid_State_Architecture of Generate_Wave_Logic_Head is
    -- Internal mapping states corresponding directly to the 16-State conversion matrix
    constant ADDR_GROUND_IDLE : STD_LOGIC_VECTOR(3 downto 0) := "0000"; -- 0.0000V (State 00)
    constant ADDR_PRECISION   : STD_LOGIC_VECTOR(3 downto 0) := "0011"; -- 0.1875V (State 03)
    constant ADDR_QUIESCENT   : STD_LOGIC_VECTOR(3 downto 0) := "0100"; -- 0.2500V (State 04)
    constant ADDR_INTER_BAL   : STD_LOGIC_VECTOR(3 downto 0) := "0110"; -- 0.3750V (State 06)
    constant ADDR_ACTIVE_TRK  : STD_LOGIC_VECTOR(3 downto 0) := "1100"; -- 0.7500V (State 12)
    constant ADDR_ZERO_SYSTEM : STD_LOGIC_VECTOR(3 downto 0) := "1110"; -- 0.8750V (State 14)
    constant ADDR_OVERLOAD    : STD_LOGIC_VECTOR(3 downto 0) := "1111"; -- 0.9375V (State 15)
begin

    -- Deterministic asynchronous multiplexing loop operating with near-zero gate lag
    process(Analog_Address_In, Lattice_Air_Gap_Open)
    begin
        -- Enforce a zero-current baseline across all channels by default
        Main_Camera_Bracket    <= '0';
        Viewport_Eye_Housings  <= '0';
        Neck_Universal_Spline  <= '0';
        Antenna_Waveguide_Gate <= '0';
        Trauma_Overflow_Shunt  <= '0';

        if (Lattice_Air_Gap_Open = '1') then
            -- Snap-circuit gold bridge is physically fractured; absolute data insulation active
            Trauma_Overflow_Shunt <= '0'; -- Terminate lines to shield the UNIVAC IX
            
        else
            case Analog_Address_In is
                when ADDR_GROUND_IDLE =>
                    -- System Ground: All sensor actuators relaxed
                    null;
                    
                when ADDR_PRECISION =>
                    -- Fine-motor adjustment: Low-current precision calibration pulse to eye cameras
                    Viewport_Eye_Housings  <= '1';
                    
                when ADDR_QUIESCENT =>
                    -- Standard horizon track: Constant low-amperage retention voltage step across the neck
                    Main_Camera_Bracket    <= '1';
                    Neck_Universal_Spline  <= '1';
                    
                when ADDR_INTER_BAL =>
                    -- Dynamic rebalancing shift: Head tracking loop counter-adjusts neck positioning
                    Neck_Universal_Spline  <= '1';
                    Antenna_Waveguide_Gate <= '1';
                    
                when ADDR_ACTIVE_TRK =>
                    -- High-velocity battle tracking: Full sweep current ignition across all sensor mounts
                    Main_Camera_Bracket    <= '1';
                    Viewport_Eye_Housings  <= '1';
                    Neck_Universal_Spline  <= '1';
                    Antenna_Waveguide_Gate <= '1';
                    
                when ADDR_ZERO_SYSTEM =>
                    -- ZERO System Intercept: Maximum sensor array focus and overclocked antennae throughput
                    Main_Camera_Bracket    <= '1';
                    Viewport_Eye_Housings  <= '1';
                    Neck_Universal_Spline  <= '1';
                    Antenna_Waveguide_Gate <= '1';
                    
                when ADDR_OVERLOAD =>
                    -- Traumatic front visor impact: Forces open the high-voltage Zener crowbar shunt
                    Trauma_Overflow_Shunt  <= '1'; 
                    Neck_Universal_Spline  <= '1'; -- Maintains minimum pan loop alignment
                    
                when others =>
                    -- Catch-all for decommissioned registers or illegal 1.000V levels
                    null;
            end case;
        end if;
    end process;

end Solid_State_Architecture;
