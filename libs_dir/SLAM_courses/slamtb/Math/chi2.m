function chi2 = chi2(n,p)

% CHI2  Chi square distribution
%   TH = CHI2(N,P) gives the critical values of the N-dimensional
%   Chi-squared distribuiton function for a right-tail probability area P

%   Copyright 2009 Joan Sola @ LAAS-CNRS.

[nTab,pTab,Chi2Tab] = chi2tab();

if (n == floor(n))
    
    
    % values of p
    if p < .001
        warning('Too small probability. Assuming P=0.001')
        p = 0.001;
    elseif (p > 0.2) && (p<0.975) && (p~=0.5)
        warning('Poor data in table. Inaccurate results. Use P<0.2 or P>0.975.')
    elseif p > 0.995
        warning('Too big probability. Assuming P=0.995')
        p = 0.995;
    end

    % values of n
    if (n > 1000)
        error('Chi2 Lookup table only up to N=1000 DOF')
    elseif (n > 250) && (mod(n,50)~=0)
        warning('Value of N-DOF not found. Innacurate results. Use N in [1:1:250,300:50:1000]')
    end
    
    % 2-D interpolation
    chi2 = interp2(pTab,nTab,Chi2Tab,p,n);
        
else
    error('Dimension N must be a positive integer value in [1:1000]')
end

end

%% Lookup tables

function [DOF,PRB,TAB] = chi2tab()

PRB = [0.995	0.975	0.20	0.10	0.05	0.025	0.02	0.01	0.005	0.002	0.001];

DOF = [1:250 300:50:1000];

TAB = [...
1	0.0000393	0.000982	1.642	2.706	3.841	5.024	5.412	6.635	7.879	9.550	10.828
2	0.0100	0.0506	3.219	4.605	5.991	7.378	7.824	9.210	10.597	12.429	13.816
3	0.0717	0.216	4.642	6.251	7.815	9.348	9.837	11.345	12.838	14.796	16.266
4	0.207	0.484	5.989	7.779	9.488	11.143	11.668	13.277	14.860	16.924	18.467
5	0.412	0.831	7.289	9.236	11.070	12.833	13.388	15.086	16.750	18.907	20.515
6	0.676	1.237	8.558	10.645	12.592	14.449	15.033	16.812	18.548	20.791	22.458
7	0.989	1.690	9.803	12.017	14.067	16.013	16.622	18.475	20.278	22.601	24.322
8	1.344	2.180	11.030	13.362	15.507	17.535	18.168	20.090	21.955	24.352	26.124
9	1.735	2.700	12.242	14.684	16.919	19.023	19.679	21.666	23.589	26.056	27.877
10	2.156	3.247	13.442	15.987	18.307	20.483	21.161	23.209	25.188	27.722	29.588
11	2.603	3.816	14.631	17.275	19.675	21.920	22.618	24.725	26.757	29.354	31.264
12	3.074	4.404	15.812	18.549	21.026	23.337	24.054	26.217	28.300	30.957	32.909
13	3.565	5.009	16.985	19.812	22.362	24.736	25.472	27.688	29.819	32.535	34.528
14	4.075	5.629	18.151	21.064	23.685	26.119	26.873	29.141	31.319	34.091	36.123
15	4.601	6.262	19.311	22.307	24.996	27.488	28.259	30.578	32.801	35.628	37.697
16	5.142	6.908	20.465	23.542	26.296	28.845	29.633	32.000	34.267	37.146	39.252
17	5.697	7.564	21.615	24.769	27.587	30.191	30.995	33.409	35.718	38.648	40.790
18	6.265	8.231	22.760	25.989	28.869	31.526	32.346	34.805	37.156	40.136	42.312
19	6.844	8.907	23.900	27.204	30.144	32.852	33.687	36.191	38.582	41.610	43.820
20	7.434	9.591	25.038	28.412	31.410	34.170	35.020	37.566	39.997	43.072	45.315
21	8.034	10.283	26.171	29.615	32.671	35.479	36.343	38.932	41.401	44.522	46.797
22	8.643	10.982	27.301	30.813	33.924	36.781	37.659	40.289	42.796	45.962	48.268
23	9.260	11.689	28.429	32.007	35.172	38.076	38.968	41.638	44.181	47.391	49.728
24	9.886	12.401	29.553	33.196	36.415	39.364	40.270	42.980	45.559	48.812	51.179
25	10.520	13.120	30.675	34.382	37.652	40.646	41.566	44.314	46.928	50.223	52.620
26	11.160	13.844	31.795	35.563	38.885	41.923	42.856	45.642	48.290	51.627	54.052
27	11.808	14.573	32.912	36.741	40.113	43.195	44.140	46.963	49.645	53.023	55.476
28	12.461	15.308	34.027	37.916	41.337	44.461	45.419	48.278	50.993	54.411	56.892
29	13.121	16.047	35.139	39.087	42.557	45.722	46.693	49.588	52.336	55.792	58.301
30	13.787	16.791	36.250	40.256	43.773	46.979	47.962	50.892	53.672	57.167	59.703
31	14.458	17.539	37.359	41.422	44.985	48.232	49.226	52.191	55.003	58.536	61.098
32	15.134	18.291	38.466	42.585	46.194	49.480	50.487	53.486	56.328	59.899	62.487
33	15.815	19.047	39.572	43.745	47.400	50.725	51.743	54.776	57.648	61.256	63.870
34	16.501	19.806	40.676	44.903	48.602	51.966	52.995	56.061	58.964	62.608	65.247
35	17.192	20.569	41.778	46.059	49.802	53.203	54.244	57.342	60.275	63.955	66.619
36	17.887	21.336	42.879	47.212	50.998	54.437	55.489	58.619	61.581	65.296	67.985
37	18.586	22.106	43.978	48.363	52.192	55.668	56.730	59.893	62.883	66.633	69.346
38	19.289	22.878	45.076	49.513	53.384	56.896	57.969	61.162	64.181	67.966	70.703
39	19.996	23.654	46.173	50.660	54.572	58.120	59.204	62.428	65.476	69.294	72.055
40	20.707	24.433	47.269	51.805	55.758	59.342	60.436	63.691	66.766	70.618	73.402
41	21.421	25.215	48.363	52.949	56.942	60.561	61.665	64.950	68.053	71.938	74.745
42	22.138	25.999	49.456	54.090	58.124	61.777	62.892	66.206	69.336	73.254	76.084
43	22.859	26.785	50.548	55.230	59.304	62.990	64.116	67.459	70.616	74.566	77.419
44	23.584	27.575	51.639	56.369	60.481	64.201	65.337	68.710	71.893	75.874	78.750
45	24.311	28.366	52.729	57.505	61.656	65.410	66.555	69.957	73.166	77.179	80.077
46	25.041	29.160	53.818	58.641	62.830	66.617	67.771	71.201	74.437	78.481	81.400
47	25.775	29.956	54.906	59.774	64.001	67.821	68.985	72.443	75.704	79.780	82.720
48	26.511	30.755	55.993	60.907	65.171	69.023	70.197	73.683	76.969	81.075	84.037
49	27.249	31.555	57.079	62.038	66.339	70.222	71.406	74.919	78.231	82.367	85.351
50	27.991	32.357	58.164	63.167	67.505	71.420	72.613	76.154	79.490	83.657	86.661
51	28.735	33.162	59.248	64.295	68.669	72.616	73.818	77.386	80.747	84.943	87.968
52	29.481	33.968	60.332	65.422	69.832	73.810	75.021	78.616	82.001	86.227	89.272
53	30.230	34.776	61.414	66.548	70.993	75.002	76.223	79.843	83.253	87.507	90.573
54	30.981	35.586	62.496	67.673	72.153	76.192	77.422	81.069	84.502	88.786	91.872
55	31.735	36.398	63.577	68.796	73.311	77.380	78.619	82.292	85.749	90.061	93.168
56	32.490	37.212	64.658	69.919	74.468	78.567	79.815	83.513	86.994	91.335	94.461
57	33.248	38.027	65.737	71.040	75.624	79.752	81.009	84.733	88.236	92.605	95.751
58	34.008	38.844	66.816	72.160	76.778	80.936	82.201	85.950	89.477	93.874	97.039
59	34.770	39.662	67.894	73.279	77.931	82.117	83.391	87.166	90.715	95.140	98.324
60	35.534	40.482	68.972	74.397	79.082	83.298	84.580	88.379	91.952	96.404	99.607
61	36.301	41.303	70.049	75.514	80.232	84.476	85.767	89.591	93.186	97.665	100.888
62	37.068	42.126	71.125	76.630	81.381	85.654	86.953	90.802	94.419	98.925	102.166
63	37.838	42.950	72.201	77.745	82.529	86.830	88.137	92.010	95.649	100.182	103.442
64	38.610	43.776	73.276	78.860	83.675	88.004	89.320	93.217	96.878	101.437	104.716
65	39.383	44.603	74.351	79.973	84.821	89.177	90.501	94.422	98.105	102.691	105.988
66	40.158	45.431	75.424	81.085	85.965	90.349	91.681	95.626	99.330	103.942	107.258
67	40.935	46.261	76.498	82.197	87.108	91.519	92.860	96.828	100.554	105.192	108.526
68	41.713	47.092	77.571	83.308	88.250	92.689	94.037	98.028	101.776	106.440	109.791
69	42.494	47.924	78.643	84.418	89.391	93.856	95.213	99.228	102.996	107.685	111.055
70	43.275	48.758	79.715	85.527	90.531	95.023	96.388	100.425	104.215	108.929	112.317
71	44.058	49.592	80.786	86.635	91.670	96.189	97.561	101.621	105.432	110.172	113.577
72	44.843	50.428	81.857	87.743	92.808	97.353	98.733	102.816	106.648	111.412	114.835
73	45.629	51.265	82.927	88.850	93.945	98.516	99.904	104.010	107.862	112.651	116.092
74	46.417	52.103	83.997	89.956	95.081	99.678	101.074	105.202	109.074	113.889	117.346
75	47.206	52.942	85.066	91.061	96.217	100.839	102.243	106.393	110.286	115.125	118.599
76	47.997	53.782	86.135	92.166	97.351	101.999	103.410	107.583	111.495	116.359	119.850
77	48.788	54.623	87.203	93.270	98.484	103.158	104.576	108.771	112.704	117.591	121.100
78	49.582	55.466	88.271	94.374	99.617	104.316	105.742	109.958	113.911	118.823	122.348
79	50.376	56.309	89.338	95.476	100.749	105.473	106.906	111.144	115.117	120.052	123.594
80	51.172	57.153	90.405	96.578	101.879	106.629	108.069	112.329	116.321	121.280	124.839
81	51.969	57.998	91.472	97.680	103.010	107.783	109.232	113.512	117.524	122.507	126.083
82	52.767	58.845	92.538	98.780	104.139	108.937	110.393	114.695	118.726	123.733	127.324
83	53.567	59.692	93.604	99.880	105.267	110.090	111.553	115.876	119.927	124.957	128.565
84	54.368	60.540	94.669	100.980	106.395	111.242	112.712	117.057	121.126	126.179	129.804
85	55.170	61.389	95.734	102.079	107.522	112.393	113.871	118.236	122.325	127.401	131.041
86	55.973	62.239	96.799	103.177	108.648	113.544	115.028	119.414	123.522	128.621	132.277
87	56.777	63.089	97.863	104.275	109.773	114.693	116.184	120.591	124.718	129.840	133.512
88	57.582	63.941	98.927	105.372	110.898	115.841	117.340	121.767	125.913	131.057	134.745
89	58.389	64.793	99.991	106.469	112.022	116.989	118.495	122.942	127.106	132.273	135.978
90	59.196	65.647	101.054	107.565	113.145	118.136	119.648	124.116	128.299	133.489	137.208
91	60.005	66.501	102.117	108.661	114.268	119.282	120.801	125.289	129.491	134.702	138.438
92	60.815	67.356	103.179	109.756	115.390	120.427	121.954	126.462	130.681	135.915	139.666
93	61.625	68.211	104.241	110.850	116.511	121.571	123.105	127.633	131.871	137.127	140.893
94	62.437	69.068	105.303	111.944	117.632	122.715	124.255	128.803	133.059	138.337	142.119
95	63.250	69.925	106.364	113.038	118.752	123.858	125.405	129.973	134.247	139.546	143.344
96	64.063	70.783	107.425	114.131	119.871	125.000	126.554	131.141	135.433	140.755	144.567
97	64.878	71.642	108.486	115.223	120.990	126.141	127.702	132.309	136.619	141.962	145.789
98	65.694	72.501	109.547	116.315	122.108	127.282	128.849	133.476	137.803	143.168	147.010
99	66.510	73.361	110.607	117.407	123.225	128.422	129.996	134.642	138.987	144.373	148.230
100	67.328	74.222	111.667	118.498	124.342	129.561	131.142	135.807	140.169	145.577	149.449
101	68.146	75.083	112.726	119.589	125.458	130.700	132.287	136.971	141.351	146.780	150.667
102	68.965	75.946	113.786	120.679	126.574	131.838	133.431	138.134	142.532	147.982	151.884
103	69.785	76.809	114.845	121.769	127.689	132.975	134.575	139.297	143.712	149.183	153.099
104	70.606	77.672	115.903	122.858	128.804	134.111	135.718	140.459	144.891	150.383	154.314
105	71.428	78.536	116.962	123.947	129.918	135.247	136.860	141.620	146.070	151.582	155.528
106	72.251	79.401	118.020	125.035	131.031	136.382	138.002	142.780	147.247	152.780	156.740
107	73.075	80.267	119.078	126.123	132.144	137.517	139.143	143.940	148.424	153.977	157.952
108	73.899	81.133	120.135	127.211	133.257	138.651	140.283	145.099	149.599	155.173	159.162
109	74.724	82.000	121.192	128.298	134.369	139.784	141.423	146.257	150.774	156.369	160.372
110	75.550	82.867	122.250	129.385	135.480	140.917	142.562	147.414	151.948	157.563	161.581
111	76.377	83.735	123.306	130.472	136.591	142.049	143.700	148.571	153.122	158.757	162.788
112	77.204	84.604	124.363	131.558	137.701	143.180	144.838	149.727	154.294	159.950	163.995
113	78.033	85.473	125.419	132.643	138.811	144.311	145.975	150.882	155.466	161.141	165.201
114	78.862	86.342	126.475	133.729	139.921	145.441	147.111	152.037	156.637	162.332	166.406
115	79.692	87.213	127.531	134.813	141.030	146.571	148.247	153.191	157.808	163.523	167.610
116	80.522	88.084	128.587	135.898	142.138	147.700	149.383	154.344	158.977	164.712	168.813
117	81.353	88.955	129.642	136.982	143.246	148.829	150.517	155.496	160.146	165.900	170.016
118	82.185	89.827	130.697	138.066	144.354	149.957	151.652	156.648	161.314	167.088	171.217
119	83.018	90.700	131.752	139.149	145.461	151.084	152.785	157.800	162.481	168.275	172.418
120	83.852	91.573	132.806	140.233	146.567	152.211	153.918	158.950	163.648	169.461	173.617
121	84.686	92.446	133.861	141.315	147.674	153.338	155.051	160.100	164.814	170.647	174.816
122	85.520	93.320	134.915	142.398	148.779	154.464	156.183	161.250	165.980	171.831	176.014
123	86.356	94.195	135.969	143.480	149.885	155.589	157.314	162.398	167.144	173.015	177.212
124	87.192	95.070	137.022	144.562	150.989	156.714	158.445	163.546	168.308	174.198	178.408
125	88.029	95.946	138.076	145.643	152.094	157.839	159.575	164.694	169.471	175.380	179.604
126	88.866	96.822	139.129	146.724	153.198	158.962	160.705	165.841	170.634	176.562	180.799
127	89.704	97.698	140.182	147.805	154.302	160.086	161.834	166.987	171.796	177.743	181.993
128	90.543	98.576	141.235	148.885	155.405	161.209	162.963	168.133	172.957	178.923	183.186
129	91.382	99.453	142.288	149.965	156.508	162.331	164.091	169.278	174.118	180.103	184.379
130	92.222	100.331	143.340	151.045	157.610	163.453	165.219	170.423	175.278	181.282	185.571
131	93.063	101.210	144.392	152.125	158.712	164.575	166.346	171.567	176.438	182.460	186.762
132	93.904	102.089	145.444	153.204	159.814	165.696	167.473	172.711	177.597	183.637	187.953
133	94.746	102.968	146.496	154.283	160.915	166.816	168.600	173.854	178.755	184.814	189.142
134	95.588	103.848	147.548	155.361	162.016	167.936	169.725	174.996	179.913	185.990	190.331
135	96.431	104.729	148.599	156.440	163.116	169.056	170.851	176.138	181.070	187.165	191.520
136	97.275	105.609	149.651	157.518	164.216	170.175	171.976	177.280	182.226	188.340	192.707
137	98.119	106.491	150.702	158.595	165.316	171.294	173.100	178.421	183.382	189.514	193.894
138	98.964	107.372	151.753	159.673	166.415	172.412	174.224	179.561	184.538	190.688	195.080
139	99.809	108.254	152.803	160.750	167.514	173.530	175.348	180.701	185.693	191.861	196.266
140	100.655	109.137	153.854	161.827	168.613	174.648	176.471	181.840	186.847	193.033	197.451
141	101.501	110.020	154.904	162.904	169.711	175.765	177.594	182.979	188.001	194.205	198.635
142	102.348	110.903	155.954	163.980	170.809	176.882	178.716	184.118	189.154	195.376	199.819
143	103.196	111.787	157.004	165.056	171.907	177.998	179.838	185.256	190.306	196.546	201.002
144	104.044	112.671	158.054	166.132	173.004	179.114	180.959	186.393	191.458	197.716	202.184
145	104.892	113.556	159.104	167.207	174.101	180.229	182.080	187.530	192.610	198.885	203.366
146	105.741	114.441	160.153	168.283	175.198	181.344	183.200	188.666	193.761	200.054	204.547
147	106.591	115.326	161.202	169.358	176.294	182.459	184.321	189.802	194.912	201.222	205.727
148	107.441	116.212	162.251	170.432	177.390	183.573	185.440	190.938	196.062	202.390	206.907
149	108.291	117.098	163.300	171.507	178.485	184.687	186.560	192.073	197.211	203.557	208.086
150	109.142	117.985	164.349	172.581	179.581	185.800	187.678	193.208	198.360	204.723	209.265
151	109.994	118.871	165.398	173.655	180.676	186.914	188.797	194.342	199.509	205.889	210.443
152	110.846	119.759	166.446	174.729	181.770	188.026	189.915	195.476	200.657	207.054	211.620
153	111.698	120.646	167.495	175.803	182.865	189.139	191.033	196.609	201.804	208.219	212.797
154	112.551	121.534	168.543	176.876	183.959	190.251	192.150	197.742	202.951	209.383	213.973
155	113.405	122.423	169.591	177.949	185.052	191.362	193.267	198.874	204.098	210.547	215.149
156	114.259	123.312	170.639	179.022	186.146	192.474	194.384	200.006	205.244	211.710	216.324
157	115.113	124.201	171.686	180.094	187.239	193.584	195.500	201.138	206.390	212.873	217.499
158	115.968	125.090	172.734	181.167	188.332	194.695	196.616	202.269	207.535	214.035	218.673
159	116.823	125.980	173.781	182.239	189.424	195.805	197.731	203.400	208.680	215.197	219.846
160	117.679	126.870	174.828	183.311	190.516	196.915	198.846	204.530	209.824	216.358	221.019
161	118.536	127.761	175.875	184.382	191.608	198.025	199.961	205.660	210.968	217.518	222.191
162	119.392	128.651	176.922	185.454	192.700	199.134	201.076	206.790	212.111	218.678	223.363
163	120.249	129.543	177.969	186.525	193.791	200.243	202.190	207.919	213.254	219.838	224.535
164	121.107	130.434	179.016	187.596	194.883	201.351	203.303	209.047	214.396	220.997	225.705
165	121.965	131.326	180.062	188.667	195.973	202.459	204.417	210.176	215.539	222.156	226.876
166	122.823	132.218	181.109	189.737	197.064	203.567	205.530	211.304	216.680	223.314	228.045
167	123.682	133.111	182.155	190.808	198.154	204.675	206.642	212.431	217.821	224.472	229.215
168	124.541	134.003	183.201	191.878	199.244	205.782	207.755	213.558	218.962	225.629	230.383
169	125.401	134.897	184.247	192.948	200.334	206.889	208.867	214.685	220.102	226.786	231.552
170	126.261	135.790	185.293	194.017	201.423	207.995	209.978	215.812	221.242	227.942	232.719
171	127.122	136.684	186.338	195.087	202.513	209.102	211.090	216.938	222.382	229.098	233.887
172	127.983	137.578	187.384	196.156	203.602	210.208	212.201	218.063	223.521	230.253	235.053
173	128.844	138.472	188.429	197.225	204.690	211.313	213.311	219.189	224.660	231.408	236.220
174	129.706	139.367	189.475	198.294	205.779	212.419	214.422	220.314	225.798	232.563	237.385
175	130.568	140.262	190.520	199.363	206.867	213.524	215.532	221.438	226.936	233.717	238.551
176	131.430	141.157	191.565	200.432	207.955	214.628	216.641	222.563	228.074	234.870	239.716
177	132.293	142.053	192.610	201.500	209.042	215.733	217.751	223.687	229.211	236.023	240.880
178	133.157	142.949	193.654	202.568	210.130	216.837	218.860	224.810	230.347	237.176	242.044
179	134.020	143.845	194.699	203.636	211.217	217.941	219.969	225.933	231.484	238.328	243.207
180	134.884	144.741	195.743	204.704	212.304	219.044	221.077	227.056	232.620	239.480	244.370
181	135.749	145.638	196.788	205.771	213.391	220.148	222.185	228.179	233.755	240.632	245.533
182	136.614	146.535	197.832	206.839	214.477	221.251	223.293	229.301	234.891	241.783	246.695
183	137.479	147.432	198.876	207.906	215.563	222.353	224.401	230.423	236.026	242.933	247.857
184	138.344	148.330	199.920	208.973	216.649	223.456	225.508	231.544	237.160	244.084	249.018
185	139.210	149.228	200.964	210.040	217.735	224.558	226.615	232.665	238.294	245.234	250.179
186	140.077	150.126	202.008	211.106	218.820	225.660	227.722	233.786	239.428	246.383	251.339
187	140.943	151.024	203.052	212.173	219.906	226.761	228.828	234.907	240.561	247.532	252.499
188	141.810	151.923	204.095	213.239	220.991	227.863	229.935	236.027	241.694	248.681	253.659
189	142.678	152.822	205.139	214.305	222.076	228.964	231.040	237.147	242.827	249.829	254.818
190	143.545	153.721	206.182	215.371	223.160	230.064	232.146	238.266	243.959	250.977	255.976
191	144.413	154.621	207.225	216.437	224.245	231.165	233.251	239.386	245.091	252.124	257.135
192	145.282	155.521	208.268	217.502	225.329	232.265	234.356	240.505	246.223	253.271	258.292
193	146.150	156.421	209.311	218.568	226.413	233.365	235.461	241.623	247.354	254.418	259.450
194	147.020	157.321	210.354	219.633	227.496	234.465	236.566	242.742	248.485	255.564	260.607
195	147.889	158.221	211.397	220.698	228.580	235.564	237.670	243.860	249.616	256.710	261.763
196	148.759	159.122	212.439	221.763	229.663	236.664	238.774	244.977	250.746	257.855	262.920
197	149.629	160.023	213.482	222.828	230.746	237.763	239.877	246.095	251.876	259.001	264.075
198	150.499	160.925	214.524	223.892	231.829	238.861	240.981	247.212	253.006	260.145	265.231
199	151.370	161.826	215.567	224.957	232.912	239.960	242.084	248.329	254.135	261.290	266.386
200	152.241	162.728	216.609	226.021	233.994	241.058	243.187	249.445	255.264	262.434	267.541
201	153.112	163.630	217.651	227.085	235.077	242.156	244.290	250.561	256.393	263.578	268.695
202	153.984	164.532	218.693	228.149	236.159	243.254	245.392	251.677	257.521	264.721	269.849
203	154.856	165.435	219.735	229.213	237.240	244.351	246.494	252.793	258.649	265.864	271.002
204	155.728	166.338	220.777	230.276	238.322	245.448	247.596	253.908	259.777	267.007	272.155
205	156.601	167.241	221.818	231.340	239.403	246.545	248.698	255.023	260.904	268.149	273.308
206	157.474	168.144	222.860	232.403	240.485	247.642	249.799	256.138	262.031	269.291	274.460
207	158.347	169.047	223.901	233.466	241.566	248.739	250.900	257.253	263.158	270.432	275.612
208	159.221	169.951	224.943	234.529	242.647	249.835	252.001	258.367	264.285	271.574	276.764
209	160.095	170.855	225.984	235.592	243.727	250.931	253.102	259.481	265.411	272.715	277.915
210	160.969	171.759	227.025	236.655	244.808	252.027	254.202	260.595	266.537	273.855	279.066
211	161.843	172.664	228.066	237.717	245.888	253.122	255.302	261.708	267.662	274.995	280.217
212	162.718	173.568	229.107	238.780	246.968	254.218	256.402	262.821	268.788	276.135	281.367
213	163.593	174.473	230.148	239.842	248.048	255.313	257.502	263.934	269.912	277.275	282.517
214	164.469	175.378	231.189	240.904	249.128	256.408	258.601	265.047	271.037	278.414	283.666
215	165.344	176.283	232.230	241.966	250.207	257.503	259.701	266.159	272.162	279.553	284.815
216	166.220	177.189	233.270	243.028	251.286	258.597	260.800	267.271	273.286	280.692	285.964
217	167.096	178.095	234.311	244.090	252.365	259.691	261.898	268.383	274.409	281.830	287.112
218	167.973	179.001	235.351	245.151	253.444	260.785	262.997	269.495	275.533	282.968	288.261
219	168.850	179.907	236.391	246.213	254.523	261.879	264.095	270.606	276.656	284.106	289.408
220	169.727	180.813	237.432	247.274	255.602	262.973	265.193	271.717	277.779	285.243	290.556
221	170.604	181.720	238.472	248.335	256.680	264.066	266.291	272.828	278.902	286.380	291.703
222	171.482	182.627	239.512	249.396	257.758	265.159	267.389	273.939	280.024	287.517	292.850
223	172.360	183.534	240.552	250.457	258.837	266.252	268.486	275.049	281.146	288.653	293.996
224	173.238	184.441	241.592	251.517	259.914	267.345	269.584	276.159	282.268	289.789	295.142
225	174.116	185.348	242.631	252.578	260.992	268.438	270.681	277.269	283.390	290.925	296.288
226	174.995	186.256	243.671	253.638	262.070	269.530	271.777	278.379	284.511	292.061	297.433
227	175.874	187.164	244.711	254.699	263.147	270.622	272.874	279.488	285.632	293.196	298.579
228	176.753	188.072	245.750	255.759	264.224	271.714	273.970	280.597	286.753	294.331	299.723
229	177.633	188.980	246.790	256.819	265.301	272.806	275.066	281.706	287.874	295.465	300.868
230	178.512	189.889	247.829	257.879	266.378	273.898	276.162	282.814	288.994	296.600	302.012
231	179.392	190.797	248.868	258.939	267.455	274.989	277.258	283.923	290.114	297.734	303.156
232	180.273	191.706	249.908	259.998	268.531	276.080	278.354	285.031	291.234	298.867	304.299
233	181.153	192.615	250.947	261.058	269.608	277.171	279.449	286.139	292.353	300.001	305.443
234	182.034	193.524	251.986	262.117	270.684	278.262	280.544	287.247	293.472	301.134	306.586
235	182.915	194.434	253.025	263.176	271.760	279.352	281.639	288.354	294.591	302.267	307.728
236	183.796	195.343	254.063	264.235	272.836	280.443	282.734	289.461	295.710	303.400	308.871
237	184.678	196.253	255.102	265.294	273.911	281.533	283.828	290.568	296.828	304.532	310.013
238	185.560	197.163	256.141	266.353	274.987	282.623	284.922	291.675	297.947	305.664	311.154
239	186.442	198.073	257.179	267.412	276.062	283.713	286.016	292.782	299.065	306.796	312.296
240	187.324	198.984	258.218	268.471	277.138	284.802	287.110	293.888	300.182	307.927	313.437
241	188.207	199.894	259.256	269.529	278.213	285.892	288.204	294.994	301.300	309.058	314.578
242	189.090	200.805	260.295	270.588	279.288	286.981	289.298	296.100	302.417	310.189	315.718
243	189.973	201.716	261.333	271.646	280.362	288.070	290.391	297.206	303.534	311.320	316.859
244	190.856	202.627	262.371	272.704	281.437	289.159	291.484	298.311	304.651	312.450	317.999
245	191.739	203.539	263.409	273.762	282.511	290.248	292.577	299.417	305.767	313.580	319.138
246	192.623	204.450	264.447	274.820	283.586	291.336	293.670	300.522	306.883	314.710	320.278
247	193.507	205.362	265.485	275.878	284.660	292.425	294.762	301.626	307.999	315.840	321.417
248	194.391	206.274	266.523	276.935	285.734	293.513	295.855	302.731	309.115	316.969	322.556
249	195.276	207.186	267.561	277.993	286.808	294.601	296.947	303.835	310.231	318.098	323.694
250	196.161	208.098	268.599	279.050	287.882	295.689	298.039	304.940	311.346	319.227	324.832
300	240.663	253.912	320.397	331.789	341.395	349.874	352.425	359.906	366.844	375.369	381.425
350	285.608	300.064	372.051	384.306	394.626	403.723	406.457	414.474	421.900	431.017	437.488
400	330.903	346.482	423.590	436.649	447.632	457.305	460.211	468.724	476.606	486.274	493.132
450	376.483	393.118	475.035	488.849	500.456	510.670	513.736	522.717	531.026	541.212	548.432
500	422.303	439.936	526.401	540.930	553.127	563.852	567.070	576.493	585.207	595.882	603.446
550	468.328	486.910	577.701	592.909	605.667	616.878	620.241	630.084	639.183	650.324	658.215
600	514.529	534.019	628.943	644.800	658.094	669.769	673.270	683.516	692.982	704.568	712.771
650	560.885	581.245	680.134	696.614	710.421	722.542	726.176	736.807	746.625	758.639	767.141
700	607.380	628.577	731.280	748.359	762.661	775.211	778.972	789.974	800.131	812.556	821.347
750	653.997	676.003	782.386	800.043	814.822	827.785	831.670	843.029	853.514	866.336	875.404
800	700.725	723.513	833.456	851.671	866.911	880.275	884.279	895.984	906.786	919.991	929.329
850	747.554	771.099	884.492	903.249	918.937	932.689	936.808	948.848	959.957	973.534	983.133
900	794.475	818.756	935.499	954.782	970.904	985.032	989.263	1001.630	1013.036	1026.974	1036.826
950	841.480	866.477	986.478	1006.272	1022.816	1037.311	1041.651	1054.334	1066.031	1080.320	1090.418
1000	888.564	914.257	1037.431	1057.724	1074.679	1089.531	1093.977	1106.969	1118.948	1133.579	1143.917];

% remove DOF column
TAB = TAB(:,2:end); 

% add the P=0.5 column
PRB = [PRB(1:2) 0.500 PRB(3:end)];
TAB = [TAB(:,1:2) DOF' TAB(:,3:end)];

end



% ========== End of function - Start GPL license ==========


%   # START GPL LICENSE

%---------------------------------------------------------------------
%
%   This file is part of SLAMTB, a SLAM toolbox for Matlab.
%
%   SLAMTB is free software: you can redistribute it and/or modify
%   it under the terms of the GNU General Public License as published by
%   the Free Software Foundation, either version 3 of the License, or
%   (at your option) any later version.
%
%   SLAMTB is distributed in the hope that it will be useful,
%   but WITHOUT ANY WARRANTY; without even the implied warranty of
%   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%   GNU General Public License for more details.
%
%   You should have received a copy of the GNU General Public License
%   along with SLAMTB.  If not, see <http://www.gnu.org/licenses/>.
%
%---------------------------------------------------------------------

%   SLAMTB is Copyright:
%   Copyright (c) 2008-2010, Joan Sola @ LAAS-CNRS,
%   Copyright (c) 2010-2013, Joan Sola,
%   Copyright (c) 2014-2015, Joan Sola @ IRI-UPC-CSIC,
%   SLAMTB is Copyright 2009 
%   by Joan Sola, Teresa Vidal-Calleja, David Marquez and Jean Marie Codol
%   @ LAAS-CNRS.
%   See on top of this file for its particular copyright.

%   # END GPL LICENSE

