-- ============================================================================
-- PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - SOLID-STATE LOWER LIMB INFRA
-- MODULE: ANKLE DRIVE MULTIPLEXER WAVE DRIVER LOGIC (GENERATE_WAVE_LOGIC_ANKLE.VHD)
-- CONFIGURATION TARGET: RESISTOR-FREE CYCLOIDAL STEERING SWITCHING
-- DESIGN STANDARDS: 16-STATE HEXADECIMAL LIGHT PULSE PARITY (0.0V - 1.0V)
-- ============================================================================

library IEEE;
-- Standard physical math and data routing packages
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Generate_Wave_Logic_Ankle is
    Port (
        -- Master Analog Chessboard Light Pulse Addresses (0.0V to 1.0V steps)
        Analog_Address_In      : in  STD_LOGIC_VECTOR(3 downto 0); 
        Lattice_Air_Gap_Open   : in  STD_LOGIC; -- Hardware fault isolation monitor bit
        
        -- Target Ankle Actuator Selection Channels (Runner H and Runner F Cores)
        Ankle_Swivel_Drive     : out STD_LOGIC; -- H14/H15 Active Steering Ring
        Cushion_Shock_Coils    : out STD_LOGIC; -- F20/F21 Ankle Shield Maglev Coils
        Heel_Stabilizer_Yoke   : out STD_LOGIC; -- A5/A6 Silverado Recoil Balance Feet
        Trauma_Overflow_Shunt  : out STD_LOGIC  -- Core shield / Foot protection override
    );
end Generate_Wave_Logic_Ankle;

architecture Solid_State_Architecture of Generate_Wave_Logic_Ankle is
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
        Ankle_Swivel_Drive     <= '0';
        Cushion_Shock_Coils    <= '0';
        Heel_Stabilizer_Yoke   <= '0';
        Trauma_Overflow_Shunt  <= '0';

        if (Lattice_Air_Gap_Open = '1') then
            -- Snap-circuit gold bridge is physically fractured; absolute data insulation active
            Trauma_Overflow_Shunt <= '0'; -- Terminate lines to shield the UNIVAC IX
            
        else
            case Analog_Address_In is
                when ADDR_GROUND_IDLE =>
                    -- System Ground: All ankle drive components relaxed
                    null;
                    
                when ADDR_PRECISION =>
                    -- Fine-motor adjustment: Low-current trim pulse to active swivel loops
                    Ankle_Swivel_Drive     <= '1';
                    
                when ADDR_QUIESCENT =>
                    -- Standard static stance hold: Constant low-amperage retention voltage step
                    Heel_Stabilizer_Yoke   <= '1';
                    
                when ADDR_INTER_BAL =>
                    -- Dynamic rebalancing shift: Alters joint pre-load parameters during weight transitions
                    Ankle_Swivel_Drive     <= '1';
                    Heel_Stabilizer_Yoke   <= '1';
                    
                when ADDR_ACTIVE_RUN =>
                    -- High-velocity takeoff loop: Direct square-wave current ignition to propulsion motors
                    Ankle_Swivel_Drive     <= '1';
                    Cushion_Shock_Coils    <= '1'; -- Activates Kickstart regenerative shock absorption
                    Heel_Stabilizer_Yoke   <= '1';
                    
                when ADDR_MAX_WEAPON =>
                    -- Firing stance engagement: Absolute hard-lock to brace ankle frame lines against rifle forces
                    Ankle_Swivel_Drive     <= '1';
                    Heel_Stabilizer_Yoke   <= '1';
                    
                when ADDR_OVERLOAD =>
                    -- Traumatic landing impact drop: Forces open the high-voltage Zener crowbar shunt
                    Trauma_Overflow_Shunt  <= '1'; 
                    Cushion_Shock_Coils    <= '1'; -- Shunts surge immediately into Maglev barriers
                    Heel_Stabilizer_Yoke   <= '1';
                    
                when others =>
                    -- Catch-all for decommissioned registers or illegal 1.000V levels
                    null;
            end case;
        end if;
    end process;

end Solid_State_Architecture;
