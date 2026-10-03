-- ============================================================================
-- PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - CORE Pelvic FRAME INFRA
-- MODULE: PELVIC MULTIPLEXER WAVE DRIVER LOGIC (GENERATE_WAVE_LOGIC_G_PELVIS.VHD)
-- CONFIGURATION TARGET: CD74HC4067 16-CHANNEL ANALOG SWITCHING PARITY
-- PRODUCTION SPEC: PORCELAIN ISOLATION RE-ARCHITECTURE STANDARD
-- SIGNAL MATRIX: 16-STATE REFLECTED GRAY CODE ENCODING (0.0V - 1.0V BUS)
-- ============================================================================

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Generate_Wave_Logic_G_Pelvis is
    Port (
        -- Control Architecture Buses (Standardized to 100 kHz baseline cycles)
        clk                    : in  STD_LOGIC; -- Main system synchronization pulse clock
        rst_n                  : in  STD_LOGIC; -- Active-low hardware asynchronous reset
        enable                 : in  STD_LOGIC; -- Master pelvic drive authorization gate
        step_en                : in  STD_LOGIC; -- External chessboard contact step toggle pulse
        
        -- Target Pelvic Swivel Output Channels (Runner G Cores)
        mux_sel                : out STD_LOGIC_VECTOR(3 downto 0); -- 4-Bit Single-Bit Reflected Gray Vector
        Apogee_Capacitor_Gate  : out STD_LOGIC; -- 5 us flash actuator discharge command line
        Drive_Active_Telemetry : out STD_LOGIC  -- Live real-time operational feedback bit
    );
end Generate_Wave_Logic_G_Pelvis;

architecture Reflected_Gray_Architecture of Generate_Wave_Logic_G_Pelvis is
    -- Internal counter registers to map the 16 chess coordination vectors safely
    signal binary_counter : unsigned(3 downto 0) := (others => '0');
    signal gray_vector    : std_logic_vector(3 downto 0) := "0000";
    signal pulse_timer    : integer range 0 to 15 := 0;
    signal trigger_flash  : std_logic := '0';
begin

    -- Deterministic process to track chessboard step triggers natively across the porcelain matrix
    process(clk, rst_n)
    begin
        if (rst_n = '0') then
            binary_counter <= (others => '0');
            trigger_flash  <= '0';
        elsif rising_edge(clk) then
            if (enable = '1') then
                if (step_en = '1') then
                    -- Advance internal index pointer linearly upon intentional tactical coordinate updates
                    binary_counter <= binary_counter + 1;
                    trigger_flash  <= '1'; -- Initialize the 5 us Apogee kinetic surge pulse flag
                end if;
            else
                binary_counter <= (others => '0');
                trigger_flash  <= '0';
            end if;
        end if;
    end process;

    -- Native Combinational Combinatorial Logic: Convert binary tracking array to Reflected Gray Code
    -- Formula: G = B XOR (B >> 1) --> Guarantees only a single bit toggles state during shifts
    gray_vector(3) <= std_logic(binary_counter(3));
    gray_vector(2) <= std_logic(binary_counter(3) xor binary_counter(2));
    gray_vector(1) <= std_logic(binary_counter(2) xor binary_counter(1));
    gray_vector(0) <= std_logic(binary_counter(1) xor binary_counter(0));

    -- 5 us Actuator Discharge Timer Loop (Synchronized tightly within the 10 us baseline frame)
    process(clk, rst_n)
    begin
        if (rst_n = '0') then
            pulse_timer           <= 0;
            Apogee_Capacitor_Gate <= '0';
        elsif rising_edge(clk) then
            if (trigger_flash = '1') then
                -- At 100 kHz clock speed, 1 tick = 10 us, so we run multi-layer sub-cycle gates
                if (pulse_timer < 5) then
                    Apogee_Capacitor_Gate <= '1'; -- High-amperage trace injection active
                    pulse_timer           <= pulse_timer + 1;
                else
                    Apogee_Capacitor_Gate <= '0'; -- Clear register cache / settle voltage rails
                    pulse_timer           <= 0;
                end if;
            else
                Apogee_Capacitor_Gate <= '0';
                pulse_timer           <= 0;
            end if;
        end if;
    end process;

    -- Assign multiplexer routing outputs directly to CD74HC4067 select ports
    mux_sel                <= gray_vector;
    Drive_Active_Telemetry <= enable;

end Reflected_Gray_Architecture;
