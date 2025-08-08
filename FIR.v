module FIR (
	input					clk_in,
	input					rst_in,
	input					wr_in,
	input					rd_in,
	inout			[9:0]	data_io
);
	parameter	N = 223;
	reg	signed	[31:0]	x_n	[0 : N-1];
	wire	signed	[31:0] data_w;
	reg	signed	[31:0] y_n;
	wire	signed	[31:0]	h	[0 : N-1];
	reg	signed	[31:0]	add_n	[0 : N-1];

//	initial
//	begin
//		$readmemh ("coefis.txt", h);
//	end

	assign h[0]= 32'hFFFFFFE1;
	assign h[1]= 32'h00000000;
	assign h[2]= 32'h0000004C;
	assign h[3]= 32'h0000004B;
	assign h[4]= 32'hFFFFFFF3;
	assign h[5]= 32'hFFFFFFC2;
	assign h[6]= 32'hFFFFFFE8;
	assign h[7]= 32'h00000000;
	assign h[8]= 32'hFFFFFFDF;
	assign h[9]= 32'hFFFFFFDC;
	assign h[10]= 32'h00000024;
	assign h[11]= 32'h00000054;
	assign h[12]= 32'h00000022;
	assign h[13]= 32'hFFFFFFE0;
	assign h[14]= 32'hFFFFFFE4;
	assign h[15]= 32'h00000000;
	assign h[16]= 32'hFFFFFFEE;
	assign h[17]= 32'hFFFFFFD6;
	assign h[18]= 32'hFFFFFFF8;
	assign h[19]= 32'h0000002B;
	assign h[20]= 32'h00000028;
	assign h[21]= 32'h00000000;
	assign h[22]= 32'hFFFFFFF4;
	assign h[23]= 32'h00000000;
	assign h[24]= 32'hFFFFFFFF;
	assign h[25]= 32'hFFFFFFF6;
	assign h[26]= 32'hFFFFFFFC;
	assign h[27]= 32'h00000000;
	assign h[28]= 32'hFFFFFFF8;
	assign h[29]= 32'hFFFFFFF9;
	assign h[30]= 32'h00000005;
	assign h[31]= 32'h00000000;
	assign h[32]= 32'hFFFFFFF8;
	assign h[33]= 32'h00000019;
	assign h[34]= 32'h00000042;
	assign h[35]= 32'h0000001A;
	assign h[36]= 32'hFFFFFFC0;
	assign h[37]= 32'hFFFFFFB5;
	assign h[38]= 32'hFFFFFFF9;
	assign h[39]= 32'h00000000;
	assign h[40]= 32'hFFFFFFCB;
	assign h[41]= 32'h00000000;
	assign h[42]= 32'h0000009A;
	assign h[43]= 32'h000000A5;
	assign h[44]= 32'hFFFFFFE0;
	assign h[45]= 32'hFFFFFF5E;
	assign h[46]= 32'hFFFFFFBA;
	assign h[47]= 32'h00000000;
	assign h[48]= 32'hFFFFFF8F;
	assign h[49]= 32'hFFFFFF7B;
	assign h[50]= 32'h00000090;
	assign h[51]= 32'h0000016F;
	assign h[52]= 32'h000000A4;
	assign h[53]= 32'hFFFFFF54;
	assign h[54]= 32'hFFFFFF5A;
	assign h[55]= 32'h00000000;
	assign h[56]= 32'hFFFFFF7A;
	assign h[57]= 32'hFFFFFEA0;
	assign h[58]= 32'hFFFFFFB0;
	assign h[59]= 32'h000001D8;
	assign h[60]= 32'h000001FB;
	assign h[61]= 32'h00000000;
	assign h[62]= 32'hFFFFFF17;
	assign h[63]= 32'h00000000;
	assign h[64]= 32'hFFFFFFD3;
	assign h[65]= 32'hFFFFFDEA;
	assign h[66]= 32'hFFFFFDDF;
	assign h[67]= 32'h0000010E;
	assign h[68]= 32'h00000346;
	assign h[69]= 32'h00000190;
	assign h[70]= 32'hFFFFFF51;
	assign h[71]= 32'h00000000;
	assign h[72]= 32'h000000C1;
	assign h[73]= 32'hFFFFFE1C;
	assign h[74]= 32'hFFFFFBA6;
	assign h[75]= 32'hFFFFFE75;
	assign h[76]= 32'h0000036C;
	assign h[77]= 32'h000003B2;
	assign h[78]= 32'h00000058;
	assign h[79]= 32'h00000000;
	assign h[80]= 32'h00000229;
	assign h[81]= 32'h00000000;
	assign h[82]= 32'hFFFFFA3F;
	assign h[83]= 32'hFFFFFA0F;
	assign h[84]= 32'h0000011D;
	assign h[85]= 32'h00000577;
	assign h[86]= 32'h00000251;
	assign h[87]= 32'h00000000;
	assign h[88]= 32'h0000039A;
	assign h[89]= 32'h0000042F;
	assign h[90]= 32'hFFFFFB87;
	assign h[91]= 32'hFFFFF4B1;
	assign h[92]= 32'hFFFFFAF6;
	assign h[93]= 32'h00000551;
	assign h[94]= 32'h0000052A;
	assign h[95]= 32'h00000000;
	assign h[96]= 32'h00000441;
	assign h[97]= 32'h00000B68;
	assign h[98]= 32'h000002A8;
	assign h[99]= 32'hFFFFEFCB;
	assign h[100]= 32'hFFFFEDE9;
	assign h[101]= 32'h00000000;
	assign h[102]= 32'h0000093E;
	assign h[103]= 32'h00000000;
	assign h[104]= 32'h0000021A;
	assign h[105]= 32'h00001BA3;
	assign h[106]= 32'h0000204D;
	assign h[107]= 32'hFFFFECDD;
	assign h[108]= 32'hFFFFB485;
	assign h[109]= 32'hFFFFCC5F;
	assign h[110]= 32'h00002B31;
	assign h[111]= 32'h000061A8;
	assign h[112]= 32'h00002B31;
	assign h[113]= 32'hFFFFCC5F;
	assign h[114]= 32'hFFFFB485;
	assign h[115]= 32'hFFFFECDD;
	assign h[116]= 32'h0000204D;
	assign h[117]= 32'h00001BA3;
	assign h[118]= 32'h0000021A;
	assign h[119]= 32'h00000000;
	assign h[120]= 32'h0000093E;
	assign h[121]= 32'h00000000;
	assign h[122]= 32'hFFFFEDE9;
	assign h[123]= 32'hFFFFEFCB;
	assign h[124]= 32'h000002A8;
	assign h[125]= 32'h00000B68;
	assign h[126]= 32'h00000441;
	assign h[127]= 32'h00000000;
	assign h[128]= 32'h0000052A;
	assign h[129]= 32'h00000551;
	assign h[130]= 32'hFFFFFAF6;
	assign h[131]= 32'hFFFFF4B1;
	assign h[132]= 32'hFFFFFB87;
	assign h[133]= 32'h0000042F;
	assign h[134]= 32'h0000039A;
	assign h[135]= 32'h00000000;
	assign h[136]= 32'h00000251;
	assign h[137]= 32'h00000577;
	assign h[138]= 32'h0000011D;
	assign h[139]= 32'hFFFFFA0F;
	assign h[140]= 32'hFFFFFA3F;
	assign h[141]= 32'h00000000;
	assign h[142]= 32'h00000229;
	assign h[143]= 32'h00000000;
	assign h[144]= 32'h00000058;
	assign h[145]= 32'h000003B2;
	assign h[146]= 32'h0000036C;
	assign h[147]= 32'hFFFFFE75;
	assign h[148]= 32'hFFFFFBA6;
	assign h[149]= 32'hFFFFFE1C;
	assign h[150]= 32'h000000C1;
	assign h[151]= 32'h00000000;
	assign h[152]= 32'hFFFFFF51;
	assign h[153]= 32'h00000190;
	assign h[154]= 32'h00000346;
	assign h[155]= 32'h0000010E;
	assign h[156]= 32'hFFFFFDDF;
	assign h[157]= 32'hFFFFFDEA;
	assign h[158]= 32'hFFFFFFD3;
	assign h[159]= 32'h00000000;
	assign h[160]= 32'hFFFFFF17;
	assign h[161]= 32'h00000000;
	assign h[162]= 32'h000001FB;
	assign h[163]= 32'h000001D8;
	assign h[164]= 32'hFFFFFFB0;
	assign h[165]= 32'hFFFFFEA0;
	assign h[166]= 32'hFFFFFF7A;
	assign h[167]= 32'h00000000;
	assign h[168]= 32'hFFFFFF5A;
	assign h[169]= 32'hFFFFFF54;
	assign h[170]= 32'h000000A4;
	assign h[171]= 32'h0000016F;
	assign h[172]= 32'h00000090;
	assign h[173]= 32'hFFFFFF7B;
	assign h[174]= 32'hFFFFFF8F;
	assign h[175]= 32'h00000000;
	assign h[176]= 32'hFFFFFFBA;
	assign h[177]= 32'hFFFFFF5E;
	assign h[178]= 32'hFFFFFFE0;
	assign h[179]= 32'h000000A5;
	assign h[180]= 32'h0000009A;
	assign h[181]= 32'h00000000;
	assign h[182]= 32'hFFFFFFCB;
	assign h[183]= 32'h00000000;
	assign h[184]= 32'hFFFFFFF9;
	assign h[185]= 32'hFFFFFFB5;
	assign h[186]= 32'hFFFFFFC0;
	assign h[187]= 32'h0000001A;
	assign h[188]= 32'h00000042;
	assign h[189]= 32'h00000019;
	assign h[190]= 32'hFFFFFFF8;
	assign h[191]= 32'h00000000;
	assign h[192]= 32'h00000005;
	assign h[193]= 32'hFFFFFFF9;
	assign h[194]= 32'hFFFFFFF8;
	assign h[195]= 32'h00000000;
	assign h[196]= 32'hFFFFFFFC;
	assign h[197]= 32'hFFFFFFF6;
	assign h[198]= 32'hFFFFFFFF;
	assign h[199]= 32'h00000000;
	assign h[200]= 32'hFFFFFFF4;
	assign h[201]= 32'h00000000;
	assign h[202]= 32'h00000028;
	assign h[203]= 32'h0000002B;
	assign h[204]= 32'hFFFFFFF8;
	assign h[205]= 32'hFFFFFFD6;
	assign h[206]= 32'hFFFFFFEE;
	assign h[207]= 32'h00000000;
	assign h[208]= 32'hFFFFFFE4;
	assign h[209]= 32'hFFFFFFE0;
	assign h[210]= 32'h00000022;
	assign h[211]= 32'h00000054;
	assign h[212]= 32'h00000024;
	assign h[213]= 32'hFFFFFFDC;
	assign h[214]= 32'hFFFFFFDF;
	assign h[215]= 32'h00000000;
	assign h[216]= 32'hFFFFFFE8;
	assign h[217]= 32'hFFFFFFC2;
	assign h[218]= 32'hFFFFFFF3;
	assign h[219]= 32'h0000004B;
	assign h[220]= 32'h0000004C;
	assign h[221]= 32'h00000000;
	assign h[222]= 32'hFFFFFFE1;
	
	
	integer i;
	
	
	always @(posedge wr_in, negedge rst_in)
	begin
		if (!rst_in)
			for (i = 0; i<N; i = i+1)
			begin
				x_n[i] <= 0;
			end
		else
		begin
			x_n[0] <= data_w;
			for (i = 1; i<N; i = i+1)
			begin
				x_n[i] <= x_n[i-1];
			end
		end
	end
	
	always @ (*)
	begin
		add_n[0] = x_n[0]*h[0];
		for (i = 1; i<N; i = i+1)
			begin
				add_n[i] <= add_n[i-1] + x_n[i]*h[i];
			end
	end
	
	always @ (posedge rd_in, negedge rst_in)
	begin
		if (!rst_in)
			y_n <= 0;
		else
			y_n <= add_n[N-1] / 100000;
		
	end
	
	assign data_io = (rd_in ? y_n : {10{1'bz}});
	assign data_w = {{22{1'b1}},data_io};
	
endmodule