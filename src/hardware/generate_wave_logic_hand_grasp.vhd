-- ============================================================================
-- PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - MANIPULATOR ARTICULATION INFRA
-- MODULE: HAND GRASP MULTIPLEXER CONTROL LOGIC (GENAPE_WAVE_LOGIC_HAND_GRASP.VHD)
-- CONFIGURATION TARGET: RESISTOR-FREE CONFORMAL JOINT STEERING SWITCHING
-- DESIGN STANDARDS: 16-STATE HEXADECIMAL LIGHT PULSE PARITY (0.0V - 1.0V)
-- ============================================================================

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Generate_Wave_Logic_Hand_Grasp is
    Port (
        -- Master Analog Chessboard Light Pulse Addresses (0.0V to 1.0V steps)
        Analog_Address_In      : in  STD_LOGIC_VECTOR(3 downto 0); 
        Lattice_Air_Gap_Open   : in  STD_LOGIC; -- Hardware fault isolation monitor bit
        
        -- Tactile Pressure Feedback Traces (Spikes high when physical threshold hit)
        Thumb_Proximal_Pressure: in  STD_LOGIC; -- Actuator stopper indicator node
        Index_Proximal_Pressure: in  STD_LOGIC; -- Actuator stopper indicator node
        Distal_Phase_Complete  : in  STD_LOGIC; -- Outer phalanges fully wrapped flag
        
        -- Target Digit Actuator Output Gate Channels (Runner B Core Rails)
        Proximal_Drive_Rail    : out STD_LOGIC; -- Main knuckles closure current loop
        Distal_Drive_Rail      : out STD_LOGIC; -- Fingertip curling/conformation current loop
        High_Torque_Tighten    : out STD_LOGIC; -- Secondary/Tertiary high-pressure trim line
        Trauma_Overflow_Shunt  : out STD_LOGIC  -- Overcurrent shield bus override
    );
end Generate_Wave_Logic_Hand_Grasp;

architecture Solid_State_Architecture of Generate_Wave_Logic_Hand_Grasp is
    -- Internal mapping states corresponding directly to the 16-State conversion matrix
    constant ADDR_RELAXED_IDLE : STD_LOGIC_VECTOR(3 downto 0) := "0000"; -- 0.0000V (State 00)
    constant ADDR_INITIAL_GRASP: STD_LOGIC_VECTOR(3 downto 0) := "0100"; -- 0.2500V (State 04)
    constant ADDR_SECOND_TRIM  : STD_LOGIC_VECTOR(3 downto 0) := "0101"; -- 0.3125V (State 05)
    constant ADDR_THIRD_TRIM   : STD_LOGIC_VECTOR(3 downto 0) := "0110"; -- 0.3750V (State 06)
    constant ADDR_MAX_RECOIL   : STD_LOGIC_VECTOR(3 downto 0) := "1110"; -- 0.8750V (State 14)
    constant ADDR_OVERLOAD     : STD_LOGIC_VECTOR(3 downto 0) := "1111"; -- 0.9375V (State 15)
begin

    -- Asynchronous combinational loop executing your aviation-style grasp cascade
    process(Analog_Address_In, Lattice_Air_Gap_Open, Thumb_Proximal_Pressure, Index_Proximal_Pressure, Distal_Phase_Complete)
    begin
        -- Establish absolute safe zero-current baselines by default
        Proximal_Drive_Rail   <= '0';
        Distal_Drive_Rail     <= '0';
        High_Torque_Tighten   <= '0';
        Trauma_Overflow_Shunt <= '0';

        if (Lattice_Air_Gap_Open = '1') then
            -- Snap-circuit gold bridge is physically fractured; isolate driver rails instantly
            null;
            
        else
            case Analog_Address_In is
                when ADDR_RELAXED_IDLE =>
                    -- State 00: Hand open, finger actuator tracks completely relaxed
                    null;
                    
                when ADDR_INITIAL_GRASP =>
                    -- State 04: Initial Unison Closure Phase
                    -- Drive proximal knuckles forward until they hit the physical object "stopper"
                    if (Thumb_Proximal_Pressure = '0' and Index_Proximal_Pressure = '0') then
                        Proximal_Drive_Rail <= '1';
                    else
                        -- Proximal thresholds hit! Lock knuckles and transfer current to distal outer loops
                        Proximal_Drive_Rail <= '0';
                        if (Distal_Phase_Complete = '0') then
                            Distal_Drive_Rail <= '1';
                        end if;
                    end if;
                    
                when ADDR_SECOND_TRIM =>
                    -- State 05: Second Adjustment. Inject baseline trim voltage to settle outer joints.
                    Distal_Drive_Rail   <= '1';
                    High_Torque_Tighten <= '1'; -- Low-amperage tightening hold active
                    
                when ADDR_THIRD_TRIM =>
                    -- State 06: Third Adjustment. Escalate current limit to firmly clamp irregular objects.
                    Distal_Drive_Rail   <= '1';
                    High_Torque_Tighten <= '1';
                    Proximal_Drive_Rail <= '1'; -- Re-energize main knuckles to secure load limits
                    
                when ADDR_MAX_RECOIL =>
                    -- Twin Buster Rifle Structural Mount Mode: Hardlocks finger plates down completely
                    Proximal_Drive_Rail <= '1';
                    Distal_Drive_Rail   <= '1';
                    High_Torque_Tighten <= '1'; -- Max mechanical clamping online
                    
                when ADDR_OVERLOAD =>
                    -- Traumatic weapon strike/limb wrench: Discharge surge away to shield nodes
                    Trauma_Overflow_Shunt <= '1';
                    
                when others =>
                    null;
            end case;
        end if;
    end process;

end Solid_State_Architecture;
