library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity decision is

port ( reset : in std_logic;
       clk : in std_logic;
		 V0,V3,V1,V2 :in unsigned (3 downto 0); 
		 O1,O0 :in std_logic;
		 ea:out std_logic :='1' ;
		 GI,GD,eg:out std_logic
		 
		 );
end entity;		 


architecture rtl of decision is
   signal selec : std_logic_vector (3 downto 0);
	signal aux:std_logic_vector(1 downto 0);
begin
selec<= O1 & O0 & aux;
	process (reset,clk,selec,V0,V1,V2,V3)
		begin
  
		if reset= '0' then
			GI<='0'; GD<='0' ;ea<='1';eg<='0' ;
		elsif (rising_edge(clk)) then
			if ((V0< V1) and (V0< V2) and (V0< V3)) then
				aux<="00";
					elsif ((V1<= V0) and (V1<= V2) and (V1< V3)) then
					aux<="01";
						elsif ((V2<= V0) and (V2< V1) and (V2< V3)) then
						aux<="10";
							else
							aux<="11";
			end if;
--aux<="00";
			case selec is
				when "0000" | "0111" |"1001" |"1110" =>
					GI<='1'; GD<='1' ;ea<='0';eg<='1';
				when "0001" | "0100" |"1010" |"1111" =>
					GI<='1'; GD<='0' ;ea<='0';eg<='1' ;
				when "0010" | "0101" |"1011" |"1100" =>
					GI<='0'; GD<='0' ;ea<='1';eg<='0' ;
				when "0011" | "0110" |"1000" |"1101" =>
					GI<='0'; GD<='1' ;ea<='0';eg<='1' ;
			end case;
		end if;	
	end process; 
	end architecture;