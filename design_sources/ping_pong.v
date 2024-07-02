`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.04.2023 13:06:57
// Design Name: 
// Module Name: ping_pong
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module score_sevenseg(rpi_clk,score,ss);
    input [3:0]score;
    input rpi_clk;
    output reg [6:0]ss;
    always @(posedge rpi_clk) begin
        case (score)
            4'b0000 : ss=7'b0000001;
            4'b0001 : ss=7'b1001111;
            4'b0010 : ss=7'b0010010;
            4'b0011 : ss=7'b0000110;
            4'b0100 : ss=7'b1001100;
            4'b0101 : ss=7'b0100100;
            4'b0110 : ss=7'b0100000;
            4'b0111 : ss=7'b0001111;
            4'b1000 : ss=7'b0000000;
            4'b1001 : ss=7'b0000100;
        endcase
    end

endmodule

module ping_pong(start,whofirst,clk,a,b,l,la,lb,div_clock,ss,enabler);
    input start, whofirst,a,b,clk;
    output reg [11:0]l=12'b000000000000;
    output reg la ,lb;
    output reg div_clock;
    output [6:0]ss;
    reg [1:0]speed=2'b11;
    
    reg [3:0]scorea0,scoreb0,scorea1,scoreb1,rpi_score;
    reg left;
    reg [27:0]count = 0;
    reg fastclock;
    
    always @(posedge clk) begin
        count = count+1;
        fastclock = count[17];
        if (speed==2'b11) div_clock=count[23];
        else if (speed==2'b10) div_clock=count[24];
        else if (speed==2'b01) div_clock=count[25];
        else div_clock=count[25];
    end
    
    reg chance;
    reg gamepause=0;
    reg wona=0;
    reg wonb=0;
    always @(posedge div_clock) begin
        if (start==1) begin
            if (wona==1) begin
                l=12'b111111000000;
            end
            else if (wonb==1) begin
                l=12'b000000111111;
            end
            else begin
                la=0;
                lb=0;
                if (gamepause==1) begin
                    if (chance==0) begin
                        l = 12'b000000000010;
                        if (b==1) gamepause=0;
                    end
                    else begin
                        l = 12'b010000000000;
                        if (a==1) gamepause=0;
                    end
                    speed=2'b11;
                end
                else if (left==1) begin
                    if      (l==12'b000000000001) l=12'b000000000010; 
                    else if (l==12'b000000000010) l=12'b000000000100;
                    else if (l==12'b000000000100) l=12'b000000001000;
                    else if (l==12'b000000001000) l=12'b000000010000;
                    else if (l==12'b000000010000) l=12'b000000100000;
                    else if (l==12'b000000100000) l=12'b000001000000;
                    else if (l==12'b000001000000) l=12'b000010000000;
                    else if (l==12'b000010000000) l=12'b000100000000;
                    else if (l==12'b000100000000) l=12'b001000000000;
                    else if (l==12'b001000000000) begin
                        if (a==1) begin
//                            if (scorea0 == 4'b1001) begin
//                                scorea0 = 4'b0000;
//                                scorea1 = scorea1+1;
//                            end
//                            else scorea0 = scorea0+1;
                            left=0;
                            la=1;
                            if (speed==2'b00) begin 
                                speed=2'b11;
//                                chance=0;
//                                gamepause=1;
//                                if (scoreb0 == 4'b1001) begin
//                                    scoreb0 = 4'b0000;
//                                    scoreb1 = scoreb1+1;
//                                end
//                                else scoreb0 = scoreb0+1;
                            end
                            else speed = speed - 1;
                        end
                        else begin
                            l=12'b010000000000;
//                            scoreb0 =scoreb0+1;
                        end
                    end
                    else if (l==12'b010000000000) begin
                        if (a==1) begin
//                            if (scorea0 == 4'b1000) begin
//                                scorea0 = 4'b0000;
//                                scorea1 = scorea1+1;
//                            end
//                            else if (scorea0 == 4'b1001) begin
//                                scorea0 = 4'b0001;
//                                scorea1 = scorea1+1;
//                            end
//                            else scorea0 = scorea0+2;
                            left=0;
                            la=1;
                            speed=2'b11;
                        end
                        else begin
                            l=12'b100000000000;
//                            scoreb0 =scoreb0+1;
                        end
                    end
                    else if (l==12'b100000000000) begin
                        if (a==1) begin
//                            if (scorea0 == 4'b1001) begin
//                                scorea0 = 4'b0000;
//                                scorea1 = scorea1+1;
//                            end
//                            else scorea0 = scorea0+1;
                            left=0;
                            la=1;
                            if (speed==2'b00) begin 
                                speed=2'b11;
//                                chance=0;
//                                gamepause=1;
//                                if (scoreb0 == 4'b1001) begin
//                                    scoreb0 = 4'b0000;
//                                    scoreb1 = scoreb1+1;
//                                end
//                                else scoreb0 = scoreb0+1;
                            end
                            else begin 
                                speed = speed - 1;
                            end
                        end
                        else begin
                            chance=0;
                            gamepause=1;
                            l=12'b00000000001;
                            left=1;
                            if (scoreb0 == 4'b1001) begin
                                scoreb0 = 4'b0000;
                                scoreb1 = scoreb1+1;
                            end
                            else scoreb0 = scoreb0+1;
                        end
                    end
                    else begin
                        chance=0;
                        gamepause=1;
                        if (scoreb0==4'b1001) begin
                            scoreb0 = 4'b0000;
                            scoreb1 = scoreb1+1;
                        end
                        else scoreb0 = scoreb0+1;
                    end
                end
                else if (left==0) begin
                    if      (l==12'b100000000000) l=12'b010000000000;
                    else if (l==12'b010000000000) l=12'b001000000000;
                    else if (l==12'b001000000000) l=12'b000100000000;
                    else if (l==12'b000100000000) l=12'b000010000000;
                    else if (l==12'b000010000000) l=12'b000001000000;
                    else if (l==12'b000001000000) l=12'b000000100000;
                    else if (l==12'b000000100000) l=12'b000000010000;
                    else if (l==12'b000000010000) l=12'b000000001000;
                    else if (l==12'b000000001000) l=12'b000000000100;
                    else if (l==12'b000000000100) begin
                        if (b==1) begin
//                            if (scoreb0 == 4'b1001) begin
//                                scoreb0 = 4'b0000;
//                                scoreb1 = scoreb1+1;
//                            end
//                            else scoreb0 = scoreb0+1;
                            left=1;
                            lb=1;
                            if (speed==2'b00) begin
                                speed=2'b11;
//                                chance=1;
//                                gamepause=1;
//                                if (scorea0 == 4'b1001) begin
//                                    scorea0 = 4'b0000;
//                                    scorea1 = scorea1+1;
//                                end
//                                else scorea0 = scorea0+1;
                            end
                            else speed = speed - 1;
                        end
                        else l=12'b000000000010;
                    end
                    else if (l==12'b000000000010) begin
                        if (b==1) begin
                            left=1;
                            lb=1;
//                            if (scoreb0 == 4'b1000) begin
//                                scoreb0 = 4'b0000;
//                                scoreb1 = scoreb1+1;
//                            end
//                            else if (scoreb0==4'b1001) begin
//                                scoreb0 = 4'b0001;
//                                scoreb1 = scoreb1+1;
//                            end
//                            else scoreb0 = scoreb0+2;
                            speed = 2'b11;
                        end
                        else l=12'b000000000001;
                    end
                    else if (l==12'b000000000001) begin
                        if (b==1) begin
                            left=1;
                            lb=1;
//                            if (scoreb0 == 4'b1001) begin
//                                scoreb0 = 4'b0000;
//                                scoreb1 = scoreb1+1;
//                            end
//                            else scoreb0 = scoreb0+1;
                            if (speed==2'b00) begin 
                                speed=2'b11;
//                                chance=1;
//                                gamepause=1;
//                                if (scorea0 == 4'b1001) begin
//                                    scorea0 = 4'b0000;
//                                    scorea1 = scorea1+1;
//                                end
//                                else scorea0 = scorea0+1;
                            end
                            else speed = speed - 1;
                        end
                        else begin
                            chance=1;
                            gamepause=1;
                            l=12'b10000000000;
                            left=0;
                            if (scorea0 == 4'b1001) begin
                                scorea0 = 4'b0000;
                                scorea1 = scorea1+1;
                            end
                            else scorea0 = scorea0+1;
                        end
                    end
                    else begin
                        chance=1;
                        gamepause=1;
                        if (scorea0==4'b1001) begin
                            scorea1 = scorea1+1;
                            scorea0 = 4'b0000;
                        end
                        else scorea0 = scorea0+1;
                    end
                end
            end
            
            if (scorea0==4'b0101 && scorea1==4'b0010) begin
                wona=1;
                wonb=0;
            end
            else if (scoreb0==4'b0101 && scoreb1==4'b0010) begin
                wonb=1;
                wona=0;
            end
        end
        else begin
            wona=0;
            wonb=0;
            if (whofirst == 0) begin
                l = 12'b000000000010;
                left=1;
                scorea0=4'b0000;
                scorea1=4'b0000;
                scoreb0=4'b0000;
                scoreb1=4'b0000;
                gamepause=1;
                chance=0;
            end
            else if (whofirst == 1) begin
                l = 12'b010000000000;
                left=0;
                scorea0=4'b0000;
                scorea1=4'b0000;
                scoreb0=4'b0000;
                scoreb1=4'b0000;
                gamepause=1;
                chance=1;
            end
        end
    end
    
    output reg [3:0]enabler=4'b0111;
    
    score_sevenseg score_to_sevenseg(fastclock,rpi_score,ss);
    
    always @(posedge fastclock) begin
        if (enabler==4'b1110) begin
            enabler = 4'b1101;
            rpi_score = scorea0;
        end
        else if (enabler==4'b1101) begin
            enabler = 4'b1011;
            rpi_score = scorea1;
        end
        else if (enabler==4'b1011) begin
            enabler = 4'b0111;
            rpi_score = scoreb0;
        end
        else begin
            enabler = 4'b1110;
            rpi_score = scoreb1;
        end
        
    end
    
endmodule
