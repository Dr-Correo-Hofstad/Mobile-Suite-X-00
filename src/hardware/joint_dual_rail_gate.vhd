-- ============================================================================
-- PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - SOLID-STATE ROBOTICS CORE
-- SUB-MODULE: DUAL-RAIL ASYMMETRIC DIODE GATE LINK (JOINT_DUAL_RAIL_GATE.VHD)
-- CONFIG TARGET: RESISTOR-FREE CASCADING PROPULSION & PROTECTION SWITCHING
-- PARITY RULES: 16-STATE HEXADECIMAL ANALOG MATRIX BUS LOGIC (0.0V - 1.0V)
-- ============================================================================

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Joint_Dual_Rail_Gate is
    Port (
        Analog_Bus_In         : in  STD_LOGIC_VECTOR(3 downto 0); -- 16-State Hex input bus
        Piezo_Harvest_Pulse   : in  STD_LOGIC;                    -- Shock absorber current trigger
        Capacitor_Saturation  : in  STD_LOGIC;                    -- Overflow monitoring bit
        
        Absorption_Rail_Gate  : out STD_LOGIC;                    -- Inbound capacitor charge loop
        Exertion_Actuator_Gate: out STD_LOGIC;                    -- Outbound motor discharge loop
        Cascade_Overflow_Shunt: out STD_LOGIC                     -- Core shield / Life support override
    );
end Joint_Dual_Rail_Gate;

architecture Hardware_Chassis_Logic of Joint_Dual_Rail_Gate is
    -- Signal parameter bounds mapping directly to the hexadecimal voltage steps
    constant STATE_IDLE    : STD_LOGIC_VECTOR(3 downto 0) := "0000"; -- 0.0000V Base
    constant STATE_TAKEOFF : STD_LOGIC_VECTOR(3 downto 0) := "1100"; -- 0.7500V Exertion (State 12)
    constant STATE_OVERRIDE: STD_LOGIC_VECTOR(3 downto 0) := "1111"; -- 0.9375V Max Load (State 15)
begin

    -- Deterministic asynchronous routing loop running with near-zero delay
    process(Analog_Bus_In, Piezo_Harvest_Pulse, Capacitor_Saturation)
    begin
        -- Default solid-state gate configurations (Passive paths of least resistance)
        Absorption_Rail_Gate   <= '0';
        Exertion_Actuator_Gate <= '0';
        Cascade_Overflow_Shunt <= '0';
        
        if (Piezo_Harvest_Pulse = '1') then
            if (Capacitor_Saturation = '0') then
                -- Local capacitor path has low initial impedance; swallow the incoming shock
                Absorption_Rail_Gate <= '1';
            else
                -- Capacitor path chokes; open the crowbar gate to shunt energy up the spine
                Cascade_Overflow_Shunt <= '1';
            end if;
            
        elsif (Analog_Bus_In = STATE_TAKEOFF) then
            -- Active locomotion step commanded; discharge the capacitors straight to the GM motor
            Exertion_Actuator_Gate <= '1';
            
        elsif (Analog_Bus_In = STATE_OVERRIDE) then
            -- Traumatic ballistic override detected; dump all power loops into the deflector shield
            Cascade_Overflow_Shunt <= '1';
            Exertion_Actuator_Gate <= '1';
        end if;
    end process;

end Hardware_Chassis_Logic;
