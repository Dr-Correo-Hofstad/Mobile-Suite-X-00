-- ============================================================================
-- PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - PILOT LIFE LINE INFRA
-- MODULE: ATX COMPUTATIONAL RAIL ADDRESS BUS MULTIPLEXER (GENERATE_WAVE_LOGIC_ATX_BUS.VHD)
-- CONFIGURATION TARGET: HORIZONTAL CONFIGURATION ABOVE CAPSULE MIDSECTION LINE
-- INFRASTRUCTURE RULES: RT-CERTIFIED 2OZ/3OZ COPPER TRACE PARITY / GUARD RINGS
-- DESIGN STANDARDS: 16-STATE HEXADECIMAL LIGHT PULSE PARITY (0.0V - 1.0V)
-- ============================================================================

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Generate_Wave_Logic_ATX_Bus is
    Port (
        -- Master Analog Chessboard Light Pulse Addresses (0.0V to 1.0V steps)
        Analog_Address_In      : in  STD_LOGIC_VECTOR(3 downto 0); 
        Lattice_Air_Gap_Open   : in  STD_LOGIC; -- Hardware fault isolation monitor bit
        
        -- Target ATX Rail Subsystem Control Channels (Horizontal Rail Cores)
        Left_Rail_Select_Drv   : out STD_LOGIC; -- Left side-by-side ATX motherboard frame channel
        Right_Rail_Select_Drv  : out STD_LOGIC; -- Right side-by-side ATX motherboard frame channel
        High_Speed_Data_Stream : out STD_LOGIC; -- Zero-lag targeting matrix telemetry router gate
        Trauma_Overflow_Shunt  : out STD_LOGIC  -- Core shield / Reflex bus override / Guard Ring
    );
end Generate_Wave_Logic_ATX_Bus;

architecture Solid_State_Architecture of Generate_Wave_Logic_ATX_Bus is
    -- Internal mapping states corresponding directly to the 16-State conversion matrix
    constant ADDR_STANDBY_IDLE : STD_LOGIC_VECTOR(3 downto 0) := "0000"; -- 0.0000V (State 00)
    constant ADDR_PRECISION    : STD_LOGIC_VECTOR(3 downto 0) := "0011"; -- 0.1875V (State 03)
    constant ADDR_QUIESCENT    : STD_LOGIC_VECTOR(3 downto 0) := "0100"; -- 0.2500V (State 04)
    constant ADDR_INTER_BAL    : STD_LOGIC_VECTOR(3 downto 0) := "0110"; -- 0.3750V (State 06)
    constant ADDR_ACTIVE_SWP   : STD_LOGIC_VECTOR(3 downto 0) := "1100"; -- 0.7500V (State 12)
    constant ADDR_RECOIL_BRACE : STD_LOGIC_VECTOR(3 downto 0) := "1110"; -- 0.8750V (State 14)
    constant ADDR_OVERLOAD     : STD_LOGIC_VECTOR(3 downto 0) := "1111"; -- 0.9375V (State 15)
begin

    -- Deterministic asynchronous multiplexing loop operating with near-zero gate lag
    process(Analog_Address_In, Lattice_Air_Gap_Open)
    begin
        -- Enforce a zero-current baseline across all channels by default
        Left_Rail_Select_Drv   <= '0';
        Right_Rail_Select_Drv  <= '0';
        High_Speed_Data_Stream <= '0';
        Trauma_Overflow_Shunt  <= '0';

        if (Lattice_Air_Gap_Open = '1') then
            -- Snap-circuit gold bridge is physically fractured; absolute data insulation active
            Left_Rail_Select_Drv  <= '1'; -- Emergency hardwired loop back track configuration active
            Right_Rail_Select_Drv <= '1';
            Trauma_Overflow_Shunt <= '1'; -- Engage localized overcurrent shunt protections
            
        else
            case Analog_Address_In is
                when ADDR_STANDBY_IDLE =>
                    -- System Ground: All computational data lanes relaxed to ambient registers
                    null;
                    
                when ADDR_PRECISION =>
                    -- Precision Trim Level: Micro-adjust voltage rail settling parameters across the tabs
                    Left_Rail_Select_Drv  <= '1';
                    
                when ADDR_QUIESCENT =>
                    -- State 04: Nominal Quiescent Operational Stance. Baseline coordinate tracking active.
                    Left_Rail_Select_Drv  <= '1';
                    Right_Rail_Select_Drv <= '1';
                    
                when ADDR_INTER_BAL =>
                    -- Dynamic rebalancing shift: Adjust internal slide addressing and coupler paths
                    Left_Rail_Select_Drv  <= '1';
                    Right_Rail_Select_Drv <= '1';
                    High_Speed_Data_Stream <= '1'; -- Low-current standby verification active
                    
                when ADDR_ACTIVE_SWP =>
                    -- State 12: High-Velocity Targeting Matrix Sweep. Direct sensor stream prioritization.
                    Left_Rail_Select_Drv   <= '1';
                    Right_Rail_Select_Drv  <= '1';
                    High_Speed_Data_Stream <= '1'; -- Maximum high-speed pipeline gate trigger online
                    
                when ADDR_RECOIL_BRACE =>
                    -- Twin Buster Rifle Firing Brace: Hardlocks computational address registers against shudder
                    Left_Rail_Select_Drv   <= '1';
                    Right_Rail_Select_Drv  <= '1';
                    
                when ADDR_OVERLOAD =>
                    -- State 15: Critical rail trauma/back-EMF breach. Trigger active Guard Ring crowbar shunt.
                    Trauma_Overflow_Shunt  <= '1'; -- Forces open the high-voltage Zener shunt loop
                    Left_Rail_Select_Drv   <= '1'; -- Emergency hardwired layout containment hold
                    Right_Rail_Select_Drv  <= '1';
                    
                when others =>
                    -- Catch-all for decommissioned registers or illegal level bounds
                    null;
            end case;
        end if;
    end process;

end Solid_State_Architecture;
