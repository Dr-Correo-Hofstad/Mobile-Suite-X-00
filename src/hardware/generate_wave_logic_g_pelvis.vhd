--------------------------------------------------------------------------------
-- File: generate_wave_logic_g_pelvis.vhd
-- Description: 16-State Hexadecimal Analog Multiplexer Controller 
--              for Internal Pelvic Swivel Drives.
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity generate_wave_logic_g_pelvis is
    port (
        -- Control Signals
        clk           : in  std_logic;                     -- System clock
        rst_n         : in  std_logic;                     -- Active-low asynchronous reset
        enable        : in  std_logic;                     -- Drive enable signal
        step_en       : in  std_logic;                     -- Pulse to advance to the next state
        
        -- Outputs
        mux_sel       : out std_logic_vector(3 downto 0);  -- 4-bit Hexadecimal MUX selection (16 states)
        drive_active  : out std_logic                      -- Status flag indicating the drive is running
    );
end entity generate_wave_logic_g_pelvis;

architecture rtl of generate_wave_logic_g_pelvis is

    -- Define an internal counter to track the 16 states (0x0 to 0xF)
    signal state_counter : unsigned(3 downto 0) := (others => '0');

begin

    -- Synchronous State & Counter Process
    process(clk, rst_n)
    begin
        if rst_n = '0' then
            state_counter <= (others => '0');
        elsif rising_edge(clk) then
            if enable = '1' then
                if step_en = '1' then
                    -- Automatically rolls over from 15 (1111) to 0 (0000)
                    state_counter <= state_counter + 1;
                end if;
            else
                state_counter <= (others => '0'); -- Reset to state 0 if disabled
            end if;
        end if;
    end process;

    -- Output Assignments
    mux_sel      <= std_logic_vector(state_counter);
    drive_active <= enable;

end architecture rtl;
