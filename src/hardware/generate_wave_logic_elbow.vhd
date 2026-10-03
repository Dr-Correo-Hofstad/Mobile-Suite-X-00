-- ============================================================================
-- PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - SOLID-STATE ARM INFRA
-- MODULE: ELBOW MULTIPLEXER WAVE DRIVER LOGIC (GENERATE_WAVE_LOGIC_ELBOW.VHD)
-- CONFIGURATION TARGET: RESISTOR-FREE CYCLOIDAL ELBOW SWITCHING
-- DESIGN STANDARDS: 16-STATE HEXADECIMAL LIGHT PULSE PARITY (0.0V - 1.0V)
-- ============================================================================

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Generate_Wave_Logic_Elbow is
    Port (
        -- Master Analog Chessboard Light Pulse Addresses (0.0V to 1.0V steps)
        Analog_Address_In      : in  STD_LOGIC_VECTOR(3 downto 0); 
        Lattice_Air_Gap_Open   : in  STD_LOGIC; -- Hardware fault isolation monitor bit
        
        -- Target Elbow Actuator Selection Channels (Runner B and Runner F Cores)
        Elbow_Socket_Drive     : out STD_LOGIC; -- B13/B14 Dual-Axis Cycloidal Ring
        Forearm_Slider_Engage  : out STD_LOGIC; -- C6/C7 Forearm Slideway Actuators
        Elbow_Guard_Lock       : out STD_LOGIC; -- F23/F24 Defensive Panel Clamp
        Trauma_Overflow_Shunt  : out STD_LOGIC  -- Core shield / Reflex bus override
    );
end Generate_Wave_Logic_Elbow;

architecture Solid_State_Architecture of Generate_Wave_Logic_Elbow is
    -- Internal mapping states corresponding directly to the 16-State conversion matrix
    constant ADDR_GROUND_IDLE : STD_LOGIC_VECTOR(3 downto 0) := "0000"; -- 0.0000V (State 00)
    constant ADDR_PRECISION   : STD_LOGIC_VECTOR(3 downto 0) := "0011"; -- 0.1875V (State 03)
    constant ADDR_QUIESCENT   : STD_LOGIC_VECTOR(3 downto 0) := "0100"; -- 0.2500V (State 04)
    constant ADDR_INTER_BAL   : STD_LOGIC_VECTOR(3 downto 0) := "0110"; -- 0.3750V (State 06)
    constant ADDR_ACTIVE_SWP  : STD_LOGIC_VECTOR(3 downto 0) := "1100"; -- 0.7500V (State 12)
    constant ADDR_RECOIL_LOCK : STD_LOGIC_VECTOR(3 downto 0) := "1110"; -- 0.8750V (State 14)
    constant ADDR_OVERLOAD    : STD_LOGIC_VECTOR(3 downto 0) := "1111"; -- 0.9375V (State 15)
begin

    -- Deterministic asynchronous multiplexing loop operating with near-zero gate lag
    process(Analog_Address_In, Lattice_Air_Gap_Open)
    begin
        -- Enforce a zero-current baseline across all channels by default
        Elbow_Socket_Drive     <= '0';
        Forearm_Slider_Engage  <= '0';
        Elbow_Guard_Lock       <= '0';
        Trauma_Overflow_Shunt  <= '0';

        if (Lattice_Air_Gap_Open = '1') then
            -- Snap-circuit gold bridge is physically fractured; absolute data insulation active
            Trauma_Overflow_Shunt <= '0'; -- Terminate lines to shield the UNIVAC IX
            
        else
            case Analog_Address_In is
                when ADDR_GROUND_IDLE =>
                    -- System Ground: All joint actuators relaxed
                    null;
                    
                when ADDR_PRECISION =>
                    -- Fine-motor adjustment: Low-current trim pulse to forearm tracking slides
                    Forearm_Slider_Engage  <= '1';
                    
                when ADDR_QUIESCENT =>
                    -- Standard stance hold: Constant low-amperage retention voltage step across the socket
                    Elbow_Socket_Drive     <= '1';
                    Elbow_Guard_Lock       <= '1';
                    
                when ADDR_INTER_BAL =>
                    -- Dynamic rebalancing shift: Elbow tracks micro-adjust arm joint parameters
                    Elbow_Socket_Drive     <= '1';
                    Forearm_Slider_Engage  <= '1';
                    
                when ADDR_ACTIVE_SWP =>
                    -- High-velocity battle sweeping: Direct square-wave current ignition to cycloidal coils
                    Elbow_Socket_Drive     <= '1';
                    Forearm_Slider_Engage  <= '1';
                    Elbow_Guard_Lock       <= '1';
                    
                when ADDR_RECOIL_LOCK =>
                    -- Weapon Firing Hard-Lock: Rigids elbow frame lines against Twin Buster Rifle recoil
                    Elbow_Socket_Drive     <= '1';
                    Elbow_Guard_Lock       <= '1'; -- Maximum panel clamping pressure active
                    
                when ADDR_OVERLOAD =>
                    -- Traumatic elbow guard impact: Forces open the high-voltage Zener crowbar shunt
                    Trauma_Overflow_Shunt  <= '1'; 
                    Elbow_Socket_Drive     <= '1'; -- Maintains minimum joint position hold
                    
                when others =>
                    -- Catch-all for decommissioned registers or illegal 1.000V levels
                    null;
            end case;
        end if;
    end process;

end Solid_State_Architecture;
