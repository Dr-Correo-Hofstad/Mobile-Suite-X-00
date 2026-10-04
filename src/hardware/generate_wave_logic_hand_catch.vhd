-- ============================================================================
-- PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - MANIPULATOR ARTICULATION INFRA
-- MODULE: AUTOMATED PALMAR CATCH MULTIPLEXER LOGIC (GENERATE_WAVE_LOGIC_HAND_CATCH.VHD)
-- CONFIGURATION TARGET: CD74HC4067 ZERO-SOFTWARE CONTACT TRIGGER
-- DESIGN STANDARDS: 16-STATE HEXADECIMAL ANALOG MATRIX PARITY (0.0V - 1.0V)
-- ============================================================================

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Generate_Wave_Logic_Hand_Catch is
    Port (
        -- Master Analog Chessboard System Control Sync Lines
        clk                    : in  STD_LOGIC; -- 100 kHz baseline cycle clock
        rst_n                  : in  STD_LOGIC; -- Active-low hardware asynchronous reset
        Master_Grasp_Enable    : in  STD_LOGIC; -- Cockpit authorization gate bit
        
        -- Pure Mechanical Sensor Feedback Rails (No software polling loops)
        Palmar_Contact_Spike   : in  STD_LOGIC; -- Palm contact matrix compression flag
        Thumb_Prox_Stopper     : in  STD_LOGIC; -- Joint mechanical boundary limit hit
        Index_Prox_Stopper     : in  STD_LOGIC; -- Joint mechanical boundary limit hit
        
        -- Target Digit Actuator Output Gate Channels (Runner B Core Rails)
        Finger_Catch_Rail_Drv  : out STD_LOGIC; -- Automated unison hook closure current
        Distal_Wrap_Hold_Drv   : out STD_LOGIC; -- Conformal outer finger tracking loops
        Grip_Lock_Telemetry    : out STD_LOGIC  -- Safe capture feedback indicator signal
    );
end Generate_Wave_Logic_Hand_Catch;

architecture Automated_Catch_Architecture of Generate_Wave_Logic_Hand_Catch is
    -- Internal state latch to store the instant catch ignition vector
    signal catch_loop_active : std_logic := '0';
begin

    -- Instantaneous asynchronous process to ignite the capture loop upon palmar impact
    process(clk, rst_n)
    begin
        if (rst_n = '0') then
            catch_loop_active <= '0';
        elsif rising_edge(clk) then
            if (Master_Grasp_Enable = '1') then
                if (Palmar_Contact_Spike = '1') then
                    catch_loop_active <= '1'; -- Latch the catch sequence instantly
                end if;
            else
                catch_loop_active <= '0'; -- Reset latch when cockpit cuts power
            end if;
        end if;
    end process;

    -- Combinatorial Grasp Logic Matrix: Executes your aviation-derived multi-tier cascade
    process(catch_loop_active, Thumb_Prox_Stopper, Index_Prox_Stopper)
    begin
        -- Enforce absolute safe zero-current baselines by default
        Finger_Catch_Rail_Drv <= '0';
        Distal_Wrap_Hold_Drv  <= '0';
        Grip_Lock_Telemetry   <= '0';

        if (catch_loop_active = '1') then
            -- Phase 1: Palmar contact active! Drive fingers in unison to hook the target lines
            if (Thumb_Prox_Stopper = '0' and Index_Prox_Stopper = '0') then
                Finger_Catch_Rail_Drv <= '1';
            else
                -- Phase 2: Knuckle stoppers hit object boundary! Freeze proximal line, fire distal wrap
                Finger_Catch_Rail_Drv <= '0';
                Distal_Wrap_Hold_Drv  <= '1';
                Grip_Lock_Telemetry   <= '1'; -- Signal to cockpit matrix that grip is secured
            end if;
        end if;
    end process;

end Automated_Catch_Architecture;
