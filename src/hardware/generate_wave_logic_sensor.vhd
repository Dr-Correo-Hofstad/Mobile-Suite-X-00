-- ============================================================================
-- PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - PILOT LIFE SUPPORT INFRA
-- MODULE: ECLSS MULTIPLEXER WAVE DRIVER LOGIC (GENERATE_WAVE_LOGIC_SENSOR.VHD)
-- CONFIGURATION TARGET: RESISTOR-FREE ENVIRONMENTAL TRACK SWITCHING
-- DESIGN STANDARDS: 16-STATE HEXADECIMAL LIGHT PULSE PARITY (0.0V - 1.0V)
-- ============================================================================

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Generate_Wave_Logic_Sensor is
    Port (
        -- Master Analog Chessboard Light Pulse Addresses (0.0V to 1.0V steps)
        Analog_Address_In      : in  STD_LOGIC_VECTOR(3 downto 0); 
        Lattice_Air_Gap_Open   : in  STD_LOGIC; -- Hardware fault isolation monitor bit
        
        -- Target ECLSS Subsystem Control Channels (Upper/Lower Pod Zones)
        Oxygen_Scrubber_Drive  : out STD_LOGIC; -- Antigravity-spec chemical scrubbers
        Pressure_Valves_Engage : out STD_LOGIC; -- Automated hermetic manifold valves
        Exhaust_Blower_Coils   : out STD_LOGIC; -- Centrifugal active thermal coolers
        Trauma_Overdrive_Bus   : out STD_LOGIC  -- Emergency high-voltage reflex rail
    );
end Generate_Wave_Logic_Sensor;

architecture Solid_State_Architecture of Generate_Wave_Logic_Sensor is
    -- Internal mapping states corresponding directly to the 16-State conversion matrix
    constant ADDR_GROUND_IDLE : STD_LOGIC_VECTOR(3 downto 0) := "0000"; -- 0.0000V (State 00)
    constant ADDR_PRECISION   : STD_LOGIC_VECTOR(3 downto 0) := "0011"; -- 0.1875V (State 03)
    constant ADDR_QUIESCENT   : STD_LOGIC_VECTOR(3 downto 0) := "0100"; -- 0.2500V (State 04)
    constant ADDR_INTER_BAL   : STD_LOGIC_VECTOR(3 downto 0) := "0110"; -- 0.3750V (State 06)
    constant ADDR_THERM_PEAK  : STD_LOGIC_VECTOR(3 downto 0) := "1101"; -- 0.8125V (State 13)
    constant ADDR_MAX_WEAPON  : STD_LOGIC_VECTOR(3 downto 0) := "1110"; -- 0.8750V (State 14)
    constant ADDR_OVERLOAD    : STD_LOGIC_VECTOR(3 downto 0) := "1111"; -- 0.9375V (State 15)
begin

    -- Deterministic asynchronous multiplexing loop operating with near-zero gate lag
    process(Analog_Address_In, Lattice_Air_Gap_Open)
    begin
        -- Enforce a zero-current baseline across all channels by default
        Oxygen_Scrubber_Drive  <= '0';
        Pressure_Valves_Engage <= '0';
        Exhaust_Blower_Coils   <= '0';
        Trauma_Overdrive_Bus   <= '0';

        if (Lattice_Air_Gap_Open = '1') then
            -- Snap-circuit gold bridge is physically fractured; isolate to preserve backup cells
            Pressure_Valves_Engage <= '1'; -- Emergency hardwired seal lock down active
            
        else
            case Analog_Address_In is
                when ADDR_GROUND_IDLE =>
                    -- System Ground: Minimum low-draw recirculation idling active
                    Pressure_Valves_Engage <= '1';
                    
                when ADDR_PRECISION =>
                    -- Precision Trim Level: Micro-adjust internal cabin pressure offsets
                    Pressure_Valves_Engage <= '1';
                    
                when ADDR_QUIESCENT =>
                    -- Standard Habitable Mode: Normal environmental tracking active
                    Oxygen_Scrubber_Drive  <= '1';
                    Pressure_Valves_Engage <= '1';
                    
                when ADDR_INTER_BAL =>
                    -- Dynamic rebalancing shift: Adjust internal circulation airflow profiles
                    Oxygen_Scrubber_Drive  <= '1';
                    Pressure_Valves_Engage <= '1';
                    Exhaust_Blower_Coils   <= '1';
                    
                when ADDR_THERM_PEAK =>
                    -- High-Output Thermal Exhaust: Overclock blowers to bleed off core surge heat
                    Oxygen_Scrubber_Drive  <= '1';
                    Pressure_Valves_Engage <= '1';
                    Exhaust_Blower_Coils   <= '1'; -- Full-power cooling extraction loop active
                    
                when ADDR_MAX_WEAPON =>
                    -- Weapon Firing Stance: Secure valves to handle twin buster rifle forces
                    Oxygen_Scrubber_Drive  <= '1';
                    Pressure_Valves_Engage <= '1';
                    
                when ADDR_OVERLOAD =>
                    -- Trauma Shock Mode: Direct high-voltage bypass to emergency survival systems
                    Trauma_Overdrive_Bus   <= '1'; -- Forces open the main reflex bus loop
                    Oxygen_Scrubber_Drive  <= '1'; -- Cranks oxygen scrubbers to absolute max output
                    Pressure_Valves_Engage <= '1'; -- Sealed hull fracture containment hold
                    
                when others =>
                    -- Catch-all for decommissioned registers or illegal 1.000V levels
                    null;
            end case;
        end if;
    end process;

end Solid_State_Architecture;
