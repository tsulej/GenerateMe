 FloatDict getFoldsParameters() {
  FloatDict f = new FloatDict();
  
 f.set("lines_scale",random(0.01,0.5));
 f.set("lines_squared",random(0,1) < 0.5 ? 1 : 0);
 f.set("flower_petals",round(random(3,13)));
 f.set("flower_holes",random(-0.2,1));
 f.set("waves_b",random(-0.8,0.8));
 f.set("waves_e",random(-0.8,0.8));
 f.set("waves_c",random(-0.8,0.8));
 f.set("waves_f",random(-0.8,0.8));
 f.set("popcorn_c",random(-0.8,0.8));
 f.set("popcorn_f",random(-0.8,0.8)); 
 f.set("rings_c",random(-0.9,0.9));
 f.set("fan_c",random(-0.9,0.9));
 f.set("fan_f",random(-0.8,0.8));
 f.set("blob_low",random(0.2,0.7));
 f.set("blob_high",random(0.8,1.2));
 f.set("blob_waves",round(random(2,7)));
 f.set("pdj_a",random(-3.0,3.0));
 f.set("pdj_b",random(-3.0,3.0));
 f.set("pdj_c",random(-3.0,3.0));
 f.set("pdj_d",random(-3.0,3.0)); 
 f.set("fan2_x",random(-1,1));
 f.set("fan2_y",random(2,7));  
 f.set("rings2_val",random(0.1,1.2));
 f.set("perspective_angle",random(0.3,1.0));
 f.set("perspective_dist",random(1.0,3.0));
 f.set("julian_power",random(0,1)<0.5? (int)random(4,10) : -(int)random(4,10));
 f.set("julian_dist",random(0.5,3.0));
 f.set("juliascope_power",random(0,1)<0.5? (int)random(4,10) : -(int)random(4,10));
 f.set("juliascope_dist",random(0.5,2.0));
 f.set("radialblur_angle",HALF_PI * random(-1,1));
 f.set("pie_slices",(int)random(3,10));
 f.set("pie_rotation",random(-2,2));
 f.set("pie_thickness",random(0.2,0.8));
 f.set("ngon_sides",(int)random(3,9));
 f.set("ngon_power",random(1.01, 4.0));
 f.set("ngon_circle",random(0.5, 1.5));
 f.set("ngon_corners",random(0.5, 1.5));
 f.set("curl_c1",random(0.1,0.7));
 f.set("curl_c2",random(0.1,0.7));
 f.set("wedgejulia_count",(int)random(2,7));
 f.set("wedgejulia_angle",random(-3,3));
 f.set("wedgejulia_power",random(0,1)<0.5?(int)random(2,7):-(int)random(2,7));
 f.set("wedgejulia_dist",random(1,4));
 f.set("circus_size",random(0.2,1.2));
 f.set("rectangles_x",random(0.1,1));
 f.set("rectangles_y",random(0.1,1));
 f.set("arch_weight",random(0.4,1));
 f.set("rays_weight",random(0.4,1));
 f.set("blade_weight",random(0.4,1));
 f.set("secant_weight",random(0.4,1));
 f.set("twintrian_weight",random(0.4,1));
 f.set("disc2_rot",random(-2,2));
 f.set("disc2_twist",random(-8,8)); 
 f.set("supershape_rnd",random(1)<0.8?0:random(0,0.3));
 f.set("supershape_m",random(1,20));
 f.set("supershape_n1",random(0.5,20));
 f.set("supershape_n2",random(0.5,20));
 f.set("supershape_n3",random(0.5,20));
 f.set("supershape_holes",random(-1,1));
 f.set("conic_holes",random(0,1));
 f.set("conic_eccentricity",random(0.3,1.0));  
 f.set("parabola_width",random(0,1) < 0.5 ? random(1,3) : -random(1,3));  
 f.set("parabola_height",random(0,1) < 0.5 ? random(1,3) : -random(1,3));
 f.set("bent2_x",random(-1.5,1.5));
 f.set("bent2_y",random(-1.5,1.5));
 f.set("bipolar_shift",random(-1.5,1.5));  
 f.set("cell_size",random(-2.5,2.5));
 f.set("cpow_r",random(1,3));
 f.set("cpow_i",random(-0.25,0.25));
 f.set("cpow_power",(int)random(1,5));
 f.set("loonie_weight",random(0.8,1.6));
 f.set("scry_weight",random(0.4,1));
 f.set("curve_xamp",random(-2.5,2.5));
 f.set("curve_yamp",random(-2.5,2.5));
 f.set("curve_xlength",random(0.9,2.7)); 
 f.set("curve_ylength",random(0.9,2.7));
 f.set("escher_beta",random(-3,3));
 f.set("lazysuzan_spin",random(-3,3));
 f.set("lazysuzan_space",random(-1,2));
 f.set("lazysuzan_twist",random(-2,2));
 f.set("lazysuzan_x",random(-0.5,0.5));
 f.set("lazysuzan_y",random(-0.5,0.5));
 f.set("lazysuzan_weight",random(0.4,1));
 f.set("modulus_x",random(0.8,1.5)*(random(0,1)<0.5?-1:1));
 f.set("modulus_y",random(0.8,1.5)*(random(0,1)<0.5?-1:1));
 f.set("oscilloscope_separation",random(0.01,2));
 f.set("oscilloscope_frequency",random(-8,8));
 f.set("oscilloscope_amplitude",random(0.4,3));
 f.set("oscilloscope_damping",random(0,1));
 f.set("popcorn2_x",random(-1,1));
 f.set("popcorn2_y",random(-1,1));
 f.set("popcorn2_c",random(-5,5));
 f.set("separation_x",random(0,1));
 f.set("separation_y",random(0,1));
 f.set("separation_xinside",random(-1,1));
 f.set("separation_yinside",random(-1,1));
 f.set("split_xsize",random(-0.8,0.8));
 f.set("split_ysize",random(-0.8,0.8));
 f.set("splits_x",random(-1,1));
 f.set("splits_y",random(-1,1));
 f.set("stripes_space",random(-0.8,0.8));
 f.set("stripes_warp",random(-4,4));
 f.set("wedge_angle",random(-3,3));
 f.set("wedge_hole",random(-0.5,0.5));
 f.set("wedge_count",floor(random(1,6.9)));
 f.set("wedge_swirl",random(-1,1));
 f.set("wedgesph_angle",random(-3,3));
 f.set("wedgesph_hole",random(-0.5,0.5));
 f.set("wedgesph_count",floor(random(1,6.9)));
 f.set("wedgesph_swirl",random(-1,1));
 f.set("whorl_inside",random(-2,2));
 f.set("whorl_outside",random(-2,2));
 f.set("whorl_weight",random(0.8,2));
 f.set("waves2_freqx",random(0.01,4));
 f.set("waves2_freqy",random(0.01,4));
 f.set("waves2_scalex",random(0.5,1.5));
 f.set("waves2_scaley",random(0.5,1.5));
 f.set("auger_freq",floor(random(3,7.9)));
 f.set("auger_scale",random(0.1,0.8));
 f.set("auger_sym",random(-1,1));
 f.set("auger_weight",random(-1,1));
 f.set("flux_spread",random(0.5,1));
 f.set("flux_weight",random(0.4,1));
 f.set("mobius_re_a",random(-1,1));
 f.set("mobius_im_a",random(-1,1));
 f.set("mobius_re_b",random(-1,1));
 f.set("mobius_im_b",random(-1,1));
 f.set("mobius_re_c",random(-1,1));
 f.set("mobius_im_c",random(-1,1));
 f.set("mobius_re_d",random(-1,1));
 f.set("mobius_im_d",random(-1,1));
 f.set("bcollide_num",random(1.1,8.1));
 f.set("bcollide_a",random(-0.5,1));
 f.set("bmod_radius", random(0.01, TWO_PI));
 f.set("bmod_distance", random(0.01, 2));
 f.set("bswirl_in", random(-2,2));
 f.set("bswirl_out", random(-2,2));
 f.set("btransform_rotate", random(-TWO_PI, TWO_PI));
 f.set("btransform_power", random(1,6));
 f.set("btransform_move", random(-0.5,0.5));
 f.set("btransform_split", random(-1,1));
 f.set("bwraps7_cellsize", random(0.4,2));
 f.set("bwraps7_space", random(0,0.8));
 f.set("bwraps7_gain",random(0.5,2.5));
 f.set("bwraps7_inner_twist", random(-PI,PI));
 f.set("bwraps7_outer_twist", random(-PI,PI));
 f.set("barycentroid_a",random(-1,1));
 f.set("barycentroid_b",random(-1,1));
 f.set("barycentroid_c",random(-1,1));
 f.set("barycentroid_d",random(-1,1));
 f.set("blocky_x", (random(0,1)<0.5?1.0:-1.0) * random(0.9,1));
 f.set("blocky_y", (random(0,1)<0.5?1.0:-1.0) * random(0.9,1));
 f.set("blocky_mp",(random(0,1)<0.5?1.0:-1.0) * random(1.5,6));
 f.set("blocky_weight",random(0.4,1));
 f.set("blurzoom_length",random(-1.0,1.5));
 f.set("blurzoom_x", random(-1,1));
 f.set("blurzoom_y", random(-1,1));
 f.set("boarders2_c",random(0.1,0.9));
 f.set("boarders2_left",random(0.1,0.9));
 f.set("boarders2_right",random(0.1,0.9));
 f.set("cannabiscurvewf_filled",random01());
 f.set("checks_x", random(0.2,1.5));
 f.set("checks_y", random(0.2,1.5));
 f.set("checks_size", random(0.4,1.5));
 f.set("checks_rnd", random(0,1)<0.5?0.0:1.0);
 f.set("circlecrop_radius", random(1,2));
 f.set("circlecrop_zero", random01());
 f.set("circlecrop_scatterarea", random(-1,1));
 f.set("circlecrop_x", random(-0.5,0.5));
 f.set("circlecrop_y", random(-0.5,0.5));
 f.set("circlize_hole",random(-2,2));
 f.set("cloverleaf_filled",random01());
 f.set("collideoscope_a", random(0,1));
 f.set("collideoscope_num", (int)random(1,10));
 f.set("crackle_cellsize", random(0.02,1.0));
 f.set("crackle_power", random(0.001,2));
 f.set("crackle_distort", random(-2,2));
 f.set("crackle_scale",random(0.1,10));
 f.set("crackle_z",random(-15,15));
 f.set("crop_left",random(-2.0,-0.5));
 f.set("crop_right",random(0.5,2.0));
 f.set("crop_top",random(-2.0,-0.5));
 f.set("crop_bottom",random(0.5,2.0));
 f.set("crop_scatter_area",random(-2,2));
 f.set("crop_zero",random01());
 f.set("dcperlin_shape",(int)random(0,3)); // 0,1,2
 f.set("dcperlin_map",(int)random(0,7)); // 0-5
 f.set("dcperlin_select_centre", random(-1,1));
 f.set("dcperlin_select_range", random(0.1,2.0));
 f.set("dcperlin_edge", random(0.5,2.5));
 f.set("dcperlin_scale", random(0.1,3.0));
 f.set("dcperlin_octaves",(int)random(1,4));
 f.set("dcperlin_freqs",random(0.25,0.75));
 f.set("dcperlin_z",random(-10,10));
 f.set("dcperlin_select_bailout",random(2,100));
 f.set("dcperlin_centre", random(-0.3,0.3));
 f.set("dcperlin_range", random(0.5,1.5));
 f.set("dlawf_buffersize",random(500,1500));
 f.set("dlawf_maxiter", random(3000,10000));
 f.set("dlawf_seed", (1.0+millis()) * (1.0+frameCount) % random(1000,1.0e20));
 f.set("dlawf_scale", random(10,20));
 f.set("ecollide_num", (int)random(1,10));
 f.set("ecollide_a", random(-1,1));
 f.set("ejulia_power",random(-6.6));
 f.set("emod_radius",random(0.3,2));
 f.set("emod_distance",random(-1,1));
 f.set("emotion_move",random(-0.5,0.5));
 f.set("emotion_rotate",random(-PI,PI));
 f.set("epush_dist", random(0.5,1.2) * (random01() * 2.0 - 1.0));
 f.set("epush_push", random(-1,1));
 f.set("epush_rotate", random(-PI,PI));
 f.set("erotate_rotate", random(0,TWO_PI));
 f.set("escale_scale", random(0.6,1.5));
 f.set("escale_angle", random(-PI,PI));
 f.set("eswirl_in", random(-0.5,0.5));
 f.set("eswirl_out", random(-1,1));
 f.set("eclipse_shift", random(-2,2));
 f.set("eclipse_weight", random(0.5,2));
 f.set("epispiral_n",(int)random(2,15));
 f.set("epispiral_thickness",random(-1,1));
 f.set("epispiral_holes", random(-1,0));
 f.set("epispiralwf_waves",(int)random(2,15));
 f.set("fibonacci2_sc",random(-1,1));
 f.set("fibonacci2_sc2",random(-1,1));
 f.set("flipcircle_weight",random(0.4,1.5));
 f.set("fourth_spin",random(0,TWO_PI));
 f.set("fourth_space", random(-1,1));
 f.set("fourth_twist", random(0,TWO_PI));
 f.set("fourth_x", random(-0.5,0.5));
 f.set("fourth_y", random(-0.5,0.5));
 f.set("fourth_weight", random(0.4,1.0));
 f.set("gdoffs_delta_x", random(8,12.0));
 f.set("gdoffs_delta_y", random(8,12.0));
 f.set("gdoffs_area_x", random(2.0,3.0));
 f.set("gdoffs_area_y", random(2.0,3.0));
 f.set("gdoffs_center_x", randomGaussian()/3);
 f.set("gdoffs_center_y", randomGaussian()/3);
 f.set("gdoffs_gamma", (int)random(1,7));
 f.set("gdoffs_square", (int)random(0,2));
 f.set("glynnsim1_radius", random(1.0,2.0));
 f.set("glynnsim1_radius1", random(0.05,0.8));
 f.set("glynnsim1_phi1", random(0,360));
 f.set("glynnsim1_thickness", random(0,1));
 f.set("glynnsim1_pow",random(-3,3));
 f.set("glynnsim1_contrast",random(0,1));
 f.set("glynnsim2_radius", random(0.5,2.0));
 f.set("glynnsim2_phi1", random(0,360));
 f.set("glynnsim2_phi2", random(0,360));
 f.set("glynnsim2_thickness", random(0.01,1.0));
 f.set("glynnsim2_pow",random(-3,3));
 f.set("glynnsim2_contrast",random(0,1));
 f.set("glynnsim3_radius", random(0.5,2.0));
 f.set("glynnsim3_thickness", random(0.01,1.0));
 f.set("glynnsim3_thickness2", random(0.01,1.0));
 f.set("glynnsim3_pow",random(-3,3));
 f.set("glynnsim3_contrast",random(0,1));
 f.set("heartwf_scale_x",random(0.7,1.3));
 f.set("heartwf_shift_t",random(-0.5,0.5));
 f.set("heartwf_scale_t_left", random(0.7,1.3));
 f.set("heartwf_scale_t_right", random(0.7,1.3));
 f.set("hexes_cellsize", random(0.5,2.0));
 f.set("hexes_power", random(0.3,6.0));
 f.set("hexes_rotate", random(0, TWO_PI));
 f.set("hexes_scale",random(0.5,2.0));
 f.set("hypertile1_p",random(3,8));
 f.set("hypertile1_q",random(3,8));
 f.set("hypertile2_p",random(3,8));
 f.set("hypertile2_q",random(3,8));
 f.set("hypertile_p",random(3,8));
 f.set("hypertile_q",random(3,8));
 f.set("hypertile_n",random(0,8));
 f.set("jaccn_k",random(-1.0,1.0));
 f.set("jacdn_k",random(-1.0,1.0));
 f.set("jacsn_k",random(-1.0,1.0));
 f.set("juliac_re",(random(1)<0.5?1:-1) * ((int)(random(4.0,24.0)) * 0.25 ));
 f.set("juliac_im", random(-3,3));
 f.set("juliac_dist", random(-2,2));
 f.set("asteria_alpha",random(0,2));
 f.set("bwrands_cellsize",random(0.5,2.0));
 f.set("bwrands_space",random(0,1));
 f.set("bwrands_gain",random(0.8,2.0));
 f.set("bwrands_inner_twist",random(0,TWO_PI));
 f.set("bwrands_outer_twist",random(0,TWO_PI));
 f.set("bwrands_seed",(int)random(0,MAX_INT));
 f.set("bwrands_rrot",random(0,1));
 f.set("bwrands_rmin",random(0,1));
 f.set("bwrands_loonie_chance",random(0,1));
 f.set("bwrands_petals_chance",random(0,1));
 f.set("bwrands_minpetals",(int)random(1,20));
 f.set("bwrands_maxpetals", f.get("bwrands_minpetals")+(int)random(1,20));
 f.set("circlize2_hole",random(-2,2));
 f.set("funnel_effect",random(0,8));
 f.set("funnel2_effect",random(0,8));
 f.set("juliaq_power", ((random(1)<0.5?-1.0:1.0)*random(1.5,10)));
 f.set("juliaq_divisor", random(1,5));
 f.set("kaleidoscope_pull",random(-1,1));
 f.set("kaleidoscope_rotate",random(-PI,PI));
 f.set("kaleidoscope_lineup",random(-1,1));
 f.set("kaleidoscope_x",random(-1,1));
 f.set("kaleidoscope_y",random(-1,1));
 f.set("layeredspiral_radius",((random(1)<0.5?-1.0:1.0)*random(0.9,1.3)));
 f.set("vibration2_dir",random(0, TWO_PI));
 f.set("vibration2_angle",random(0,TWO_PI));
 f.set("vibration2_freq",random(-1.1,1.1));
 f.set("vibration2_amp",random(-1,1));
 f.set("vibration2_phase",random(-1,1));
 f.set("vibration2_dir2",random(0,TWO_PI));
 f.set("vibration2_angle2",random(0,TWO_PI));
 f.set("vibration2_freq2",random(-1.1,1.1));
 f.set("vibration2_amp2",random(-1,1));
 f.set("vibration2_phase2",random(-1,1));
 f.set("vibration2_dm",random(-1,1));
 f.set("vibration2_dmfreq",random(-1,1));
 f.set("vibration2_tm",random(-1,1));
 f.set("vibration2_tmfreq",random(-1,1));
 f.set("vibration2_fm",random(-1,1));
 f.set("vibration2_fmfreq",random(-1,1));
 f.set("vibration2_am",random(-1,1));
 f.set("vibration2_amfreq",random(-1,1));
 f.set("vibration2_d2m",random(-1,1));
 f.set("vibration2_d2mfreq",random(-1,1));
 f.set("vibration2_t2m",random(-1,1));
 f.set("vibration2_t2mfreq",random(-1,1));
 f.set("vibration2_f2m",random(-1,1));
 f.set("vibration2_f2mfreq",random(-1,1));
 f.set("vibration2_a2m",random(-1,1));
 f.set("vibration2_a2mfreq",random(-1,1));
 f.set("lazyjess_n",(int)random(2,10));
 f.set("lazyjess_spin",random(-PI,PI));
 f.set("lazyjess_space", random(-0.5,0.5));
 f.set("lazyjess_corner",(int)random(1,10));
 f.set("lazyjess_weight",random(0.8,1.2)); 
 f.set("lineart_powx",random(0.5,1.5));
 f.set("lineart_powy",random(0.5,1.5));
 f.set("lissajous_tmin",random(-TWO_PI,0));
 f.set("lissajous_tmax",random(0,TWO_PI)+f.get("lissajous_tmin"));
 f.set("lissajous_a",random(-5,5));
 f.set("lissajous_b",random(-5,5));
 f.set("lissajous_c",random(-1,1));
 f.set("lissajous_d",random(-5,5));
 f.set("lissajous_e",random(-2,2));
 f.set("logapo_base",random(0.5,5));
 f.set("logdb_base",random(0.5,5));
 f.set("logdb_fix_period",random(0.3,3));
 f.set("loonie2_sides",(int)random(1,30));
 f.set("loonie2_star",random(-1,1));
 f.set("loonie2_circle",random(-1,1));
 f.set("loonie2_weight",random(0.8,1.6));
 f.set("loonie3_weight",random(0.8,1.6));
 f.set("mcarpet_x",random(-1,1));
 f.set("mcarpet_y",random(-1,1));
 f.set("mcarpet_tilt",random(-1,1));
 f.set("mcarpet_twist",random(-1,1));
 f.set("murl2_power",random(-3,3));
 f.set("murl2_c",random(-1,1));
 f.set("murl_power",random(-3,3));
 f.set("murl_c",random(-1,1));
 f.set("nblur_numedges",(int)random(3,20));
 f.set("nblur_numstripes",random(1)<0.5?0:(int)random(-30,30));
 // f.set("nblur_numstripes",0);
 f.set("nblur_ratiostripes",random(0,2));
 f.set("nblur_ratiohole",random(0,1));
 f.set("nblur_circumcircle",random(0,1)<0.5?1:0);
 f.set("nblur_adjusttolinear",random(0,1)<0.5?1:0);
 f.set("nblur_equalblur",random(0,1)<0.5?1:0);
 f.set("nblur_exactcalc",random(0,1)<0.5?1:0);
 f.set("nblur_highlightedges",random(0,2));
 f.set("nblur_weight",random(0.8,1.25));
 f.set("bsplit_shiftx",random(-2.0,2.0));
 f.set("bsplit_shifty",random(-2.0,2.0));
 f.set("devilwarp_a",random(-3,3));
 f.set("devilwarp_b",random(-3,3));
 f.set("devilwarp_effect",random(-2,2));
 f.set("devilwarp_warp",random(0.5,3));
 f.set("devilwarp_rmin",random(1));
 f.set("devilwarp_rmax",random(f.get("devilwarp_rmin")+random(0.5,1)));
 f.set("oscilloscope2_separation",random(0.01,2));
 f.set("oscilloscope2_frequencyx",random(-8,8));
 f.set("oscilloscope2_frequencyy",random(-8,8));
 f.set("oscilloscope2_amplitude",random(0.4,3));
 f.set("oscilloscope2_damping",random(0,1));
 f.set("oscilloscope2_perturbation",random(1));
 
 return f;
}

class Folds {
  int screenl, screenr;
  int middle;
  float ymin;
  float ymax;
  float xmin;
  float xmax;
  FloatDict params;
  
  String[] foldnames = { "none",
    "lines","flower","spherical","horseshoe","polar","spiral","hyperbolic","diamond","ex","julia","handkerchief",
    "disc","exponential","swirl","heart","power","eyefish","fisheye","bubble","square","cylinder","waves",
    "popcorn","sinusoidal","butterfly","cosine","rings","fan","blob","pdj","bent","fan2","rings2","perspective","vnoise",
    "julian","juliascope","blur","gaussian","realgaussian","radialblur","pie","ngon","curl","wedgejulia","circus","rectangles",
    "arch","tangent","rays","blade","secant","twintrian","cross","disc2","supershape","conic","parabola","bent2",
    "boarders","bipolar","cell","fold","foci","loonie","polar2","scry","vexp","rotate","curve","edisc", "elliptic",
    "escher", "lazysuzan", "modulus", "oscilloscope", "popcorn2", "separation", "split", "splits", "stripes", "wedge", "wedgesph",
    "whorl", "waves2", "auger", "flux", "mobius", "vlog", "vsin", "vcos", "vtan", "sec", "csc", "cot", "vsinh", "vcosh", "vtanh", "sech", "csch", "coth",
    "bcollide", "bmod", "bswirl", "btransform", "bwraps7", "barycentroid", "bilinear", "blocky", "blurzoom", "boarders2", "cannabiscurvewf",
    "checks", "circleblur", "circlecrop", "circlize", "cloverleaf", "collideoscope", "crackle", "crop", "dcperlin", "dlawf",
    "ecollide", "ejulia", /* brakowalo emod... do glynnsim3*/ "emod", "emotion", "epush", "erotate", "escale", "eswirl", "eclipse", "epispiral", "epispiralwf", "fibonacci2", "flipcircle",
    "flipy", "fourth", "gdoffs", "glynnsim1", "glynnsim2", "glynnsim3", "glynnia", "heartwf", "hexes", "hypertile1", "hypertile2", "hypertile",
    "jaccn", "jacdn", "jacsn", "juliac", "asteria", "bwrands", "circlize2", "ennepers", "funnel", "funnel2", "juliaq", "kaleidoscope","layeredspiral", "vibration2", "lazyjess",
    "lineart","lissajous","logapo","logdb","loonie2", "loonie3", "mcarpet","murl2","murl","nblur", "bsplit", "devilwarp", "oscilloscope2"};
    
  float lines_scale, lines_squared;
  float flower_petals, flower_holes;
  float waves_b, waves_e, waves_c, waves_f;
  float popcorn_c,popcorn_f;
  float rings_c, rings_c2;
  float fan_c, fan_f, fan_cc, fan_c2;
  float blob_low, blob_high, blob_waves, blob_bdiff;
  float pdj_a, pdj_b, pdj_c, pdj_d;
  float fan2_x, fan2_y, fan2_dx, fan2_dx2;
  float rings2_val, rings2_val2; 
  float perspective_angle, perspective_dist, perspective_vsin, perspective_vfcos;
  float julian_power, julian_dist, julian_cpower, julian_abspower;
  float juliascope_power, juliascope_dist, juliascope_cpower, juliascope_abspower;
  float radialblur_angle, radialblur_spinvar, radialblur_zoomvar;
  float pie_slices, pie_rotation, pie_thickness;
  float ngon_sides, ngon_power, ngon_circle, ngon_corners, ngon_pow, ngon_b;
  float curl_c1, curl_c2;
  float wedgejulia_count, wedgejulia_angle, wedgejulia_power, wedgejulia_dist, wedgejulia_cf, wedgejulia_cn, wedgejulia_rN;
  float circus_size;
  float rectangles_x, rectangles_y;
  float arch_weight;
  float rays_weight;
  float blade_weight;
  float secant_weight;
  float twintrian_weight;
  float disc2_rot, disc2_twist, disc2_timespi, disc2_sinadd, disc2_cosadd; 
  float supershape_rnd, supershape_m, supershape_n1, supershape_n2, supershape_n3, supershape_holes, supershape_pm_4, supershape_pneg1_n1;
  float conic_holes;
  float conic_eccentricity;  
  float parabola_width, parabola_height;
  float bent2_x, bent2_y;
  float bipolar_shift, bipolar_ps;  
  float cell_size;
  float cpow_r, cpow_i, cpow_power, cpow_va, cpow_vc, cpow_vd;
  float loonie_weight;
  float scry_weight;
  float curve_xamp, curve_yamp, curve_xlength, curve_ylength, curve_xlength2, curve_ylength2;
  float elliptic_v;
  float escher_beta, escher_vc, escher_vd;
  float lazysuzan_twist, lazysuzan_space, lazysuzan_spin, lazysuzan_x, lazysuzan_y, lazysuzan_weight;
  float modulus_x, modulus_y;
  float oscilloscope_separation, oscilloscope_frequency, oscilloscope_amplitude, oscilloscope_damping;
  float popcorn2_x, popcorn2_y, popcorn2_c;
  float separation_x, separation_y, separation_xinside, separation_yinside, separation_x2, separation_y2; 
  float split_xsize, split_ysize;
  float splits_x, splits_y;  
  float stripes_space, stripes_warp;
  float wedge_angle, wedge_hole, wedge_count, wedge_swirl;
  float wedgesph_angle, wedgesph_hole, wedgesph_count, wedgesph_swirl;
  float whorl_inside, whorl_outside, whorl_weight;
  float waves2_freqx, waves2_freqy, waves2_scalex, waves2_scaley;
  float auger_freq, auger_scale, auger_sym, auger_weight;
  float flux_spread, flux_weight;
  float mobius_re_a, mobius_im_a, mobius_re_b, mobius_im_b, mobius_re_c, mobius_im_c, mobius_re_d, mobius_im_d;
  float bcollide_num, bcollide_a, bcollide_bcn_pi, bcollide_pi_bcn, bcollide_bca_bcn;  
  float bmod_radius, bmod_distance;
  float bswirl_in, bswirl_out;
  float btransform_rotate, btransform_power, btransform_move, btransform_split;
  float bwraps7_cellsize, bwraps7_space, bwraps7_gain, bwraps7_inner_twist, bwraps7_outer_twist, bwraps7_g2, bwraps7_r2, bwraps7_rfactor;
  float barycentroid_a, barycentroid_b, barycentroid_c, barycentroid_d, barycentroid_dot00, barycentroid_dot01, barycentroid_dot11, barycentroid_invdenom;
  float blocky_x, blocky_y, blocky_mp, blocky_weight;
  float blurzoom_x, blurzoom_y, blurzoom_length;
  float boarders2_c, boarders2_left, boarders2_right, boarders2_cl, boarders2_cr;
  float cannabiscurvewf_filled;
  float checks_x, checks_y, checks_size, checks_rnd, checks_cs;
  float circlecrop_x, circlecrop_y, circlecrop_scatterarea, circlecrop_zero, circlecrop_radius;
  float circlize_hole;
  float cloverleaf_filled;
  float collideoscope_a, collideoscope_num, collideoscope_kn_pi, collideoscope_pi_kn, collideoscope_ka_kn;
  float crackle_cellsize, crackle_power, crackle_distort, crackle_scale, crackle_z;
  Crackle crackle_obj;
  float crop_left, crop_right, crop_top, crop_bottom, crop_scatter_area, crop_zero, crop_w, crop_h;
  float dcperlin_centre, dcperlin_range, dcperlin_notch_bottom, dcperlin_notch_top, dcperlin_shape, dcperlin_map, dcperlin_select_centre, dcperlin_select_range, dcperlin_edge, dcperlin_scale, dcperlin_octaves, dcperlin_freqs, dcperlin_z, dcperlin_select_bailout;
  float dlawf_buffersize, dlawf_maxiter, dlawf_seed, dlawf_scale;
  DLAWF dlawf_obj;
  float ecollide_num, ecollide_a, ecollide_ecn_pi, ecollide_pi_ecn, ecollide_eca_ecn;
  float ejulia_power;
  float emod_radius, emod_distance;
  float emotion_move, emotion_rotate;
  float epush_dist, epush_push, epush_rotate;
  float erotate_rotate;
  float escale_scale, escale_angle;
  float eswirl_in, eswirl_out;
  float eclipse_shift, eclipse_weight;
  float epispiral_n, epispiral_thickness, epispiral_holes;
  float epispiralwf_waves;
  float fibonacci2_sc, fibonacci2_sc2;
  float flipcircle_weight;
  float fourth_spin, fourth_space, fourth_twist, fourth_x, fourth_y, fourth_weight, fourth_sqrvvar;
  float gdoffs_delta_x, gdoffs_delta_y, gdoffs_area_x, gdoffs_area_y, gdoffs_center_x, gdoffs_center_y, gdoffs_gamma, gdoffs_square, gdoffs_gdodx, gdoffs_gdody, gdoffs_gdoax, gdoffs_gdoay, gdoffs_gdocx, gdoffs_gdocy, gdoffs_gdob;
  float glynnsim1_radius, glynnsim1_radius1, glynnsim1_phi1, glynnsim1_thickness, glynnsim1_pow, glynnsim1_contrast, glynnsim1_x1, glynnsim1_y1, glynnsim1_abspow;
  float glynnsim2_radius, glynnsim2_phi1, glynnsim2_phi2, glynnsim2_thickness, glynnsim2_pow, glynnsim2_contrast, glynnsim2_phi10, glynnsim2_phi20, glynnsim2_abspow, glynnsim2_gamma, glynnsim2_delta;
  float glynnsim3_radius, glynnsim3_thickness2, glynnsim3_thickness, glynnsim3_pow, glynnsim3_contrast, glynnsim3_abspow, glynnsim3_gamma, glynnsim3_radius1, glynnsim3_radius2;
  float heartwf_scale_x,heartwf_shift_t, heartwf_scale_t_left, heartwf_scale_t_right;    
  Hexes hexes_obj;  
  float hexes_cellsize, hexes_power, hexes_rotate, hexes_scale;  
  float hypertile1_pa, hypertile1_r, hypertile1_q, hypertile1_p;    
  float hypertile2_pa, hypertile2_r, hypertile2_q, hypertile2_p;    
  float hypertile_re, hypertile_im, hypertile_q, hypertile_p, hypertile_n;   
  float jaccn_k;
  float jacdn_k;
  float jacsn_k;
  float juliac_re, juliac_im, juliac_dist;
  float asteria_alpha, asteria_sina, asteria_cosa;
  float bwrands_cellsize, bwrands_space, bwrands_gain, bwrands_inner_twist, bwrands_outer_twist, bwrands_seed, bwrands_rrot, bwrands_rmin, bwrands_loonie_chance, bwrands_petals_chance, bwrands_minpetals, bwrands_maxpetals, bwrands_petx, bwrands_pety, bwrands_g2, bwrands_r2, bwrands_rfactor;
  float circlize2_hole;
  float funnel_effect;
  float funnel2_effect;
  float juliaq_power, juliaq_divisor, juliaq_half_inv_power, juliaq_inv_power, juliaq_inv_power_2pi;
  float kaleidoscope_pull, kaleidoscope_rotate, kaleidoscope_lineup, kaleidoscope_x, kaleidoscope_y;
  float layeredspiral_radius;
  float vibration2_dir,vibration2_angle,vibration2_freq,vibration2_amp,vibration2_phase,vibration2_dir2,vibration2_angle2,vibration2_freq2,vibration2_amp2,vibration2_phase2,vibration2_dm,vibration2_dmfreq,vibration2_tm,vibration2_tmfreq,vibration2_fm,vibration2_fmfreq,vibration2_am,vibration2_amfreq,vibration2_d2m,vibration2_d2mfreq,vibration2_t2m,vibration2_t2mfreq,vibration2_f2m,vibration2_f2mfreq,vibration2_a2m,vibration2_a2mfreq;
  float lazyjess_n, lazyjess_spin, lazyjess_space, lazyjess_corner, lazyjess_vertex, lazyjess_sin_vertex, lazyjess_pie_slice, lazyjess_half_slice, lazyjess_corner_rotation, lazyjess_weight;
  float lineart_powx, lineart_powy;   
  float lissajous_tmin, lissajous_tmax, lissajous_a, lissajous_b, lissajous_c, lissajous_d, lissajous_e;   
  float logapo_base, logapo_denom;   
  float logdb_base, logdb_fix_period, logdb_denom, logdb_fixpe;   
  float loonie2_sides, loonie2_star, loonie2_circle, loonie2_weight, loonie2_sqrvvar, loonie2_sina, loonie2_cosa, loonie2_sins, loonie2_coss, loonie2_sinc, loonie2_cosc;   
  float loonie3_weight, loonie3_sqrvvar;   
  float mcarpet_x, mcarpet_y, mcarpet_twist, mcarpet_tilt;   
  float murl2_power, murl2_c;   
  float murl_power, murl_c; 
  float nblur_numedges, nblur_numstripes, nblur_ratiostripes, nblur_ratiohole, nblur_circumcircle, nblur_adjusttolinear, nblur_equalblur, nblur_exactcalc, nblur_highlightedges;
  float nblur_weight, nblur_midAngle, nblur_angStripes, nblur_angStart, nblur_ratiocomplement, nblur_tan90_m_2, nblur_sina, nblur_cosa,  nblur_speedCalc1, nblur_speedCalc2, nblur_maxStripes, nblur_arc_tan1, nblur_arc_tan2;
  int nblur_hasStripes, nblur_negStripes;
  float bsplit_shiftx, bsplit_shifty;
  float devilwarp_a, devilwarp_b, devilwarp_effect, devilwarp_warp, devilwarp_rmin, devilwarp_rmax;
  float oscilloscope2_separation, oscilloscope2_frequencyx, oscilloscope2_frequencyy, oscilloscope2_amplitude, oscilloscope2_damping, oscilloscope2_perturbation;

  Folds(int _size,float _ymin,float _ymax,float _xmin,float _xmax) {
    float middle = _size/2;
    float size = 0.95 * middle;
    screenl = (int)(-size + middle);
    screenr =(int)(size + middle);
    ymin = _ymin;
    ymax = _ymax;
    xmin = _xmin;
    xmax = _xmax;
    
    setParameters(getFoldsParameters());
  }
    
  void setParameters(FloatDict p) {
    params = p;
    
lines_scale             = p.get("lines_scale");
lines_squared           = p.get("lines_squared");
flower_petals           = p.get("flower_petals");
flower_holes            = p.get("flower_holes");
waves_b                 = p.get("waves_b");
waves_e                 = p.get("waves_e");
waves_c                 = p.get("waves_c");
waves_f                 = p.get("waves_f");
popcorn_c               = p.get("popcorn_c");
popcorn_f               = p.get("popcorn_f");
rings_c                 = p.get("rings_c");
fan_c                   = p.get("fan_c");
fan_f                   = p.get("fan_f");
blob_low                = p.get("blob_low");
blob_high               = p.get("blob_high");
blob_waves              = p.get("blob_waves");
pdj_a                   = p.get("pdj_a");
pdj_b                   = p.get("pdj_b");
pdj_c                   = p.get("pdj_c");
pdj_d                   = p.get("pdj_d");
fan2_x                  = p.get("fan2_x");
fan2_y                  = p.get("fan2_y");
rings2_val              = p.get("rings2_val");
perspective_angle       = p.get("perspective_angle");
perspective_dist        = p.get("perspective_dist");
julian_power            = p.get("julian_power");
julian_dist             = p.get("julian_dist");
juliascope_power        = p.get("juliascope_power");
juliascope_dist         = p.get("juliascope_dist");
radialblur_angle        = p.get("radialblur_angle");
pie_slices              = p.get("pie_slices");
pie_rotation            = p.get("pie_rotation");
pie_thickness           = p.get("pie_thickness");
ngon_sides              = p.get("ngon_sides");
ngon_power              = p.get("ngon_power");
ngon_circle             = p.get("ngon_circle");
ngon_corners            = p.get("ngon_corners");
curl_c1                 = p.get("curl_c1");
curl_c2                 = p.get("curl_c2");
wedgejulia_count        = p.get("wedgejulia_count");
wedgejulia_angle        = p.get("wedgejulia_angle");
wedgejulia_power        = p.get("wedgejulia_power");
wedgejulia_dist         = p.get("wedgejulia_dist");
circus_size             = p.get("circus_size");
rectangles_x            = p.get("rectangles_x");
rectangles_y            = p.get("rectangles_y");
arch_weight             = p.get("arch_weight");
rays_weight             = p.get("rays_weight");
blade_weight            = p.get("blade_weight");
secant_weight           = p.get("secant_weight");
twintrian_weight        = p.get("twintrian_weight");
disc2_rot               = p.get("disc2_rot");
disc2_twist             = p.get("disc2_twist");
supershape_rnd          = p.get("supershape_rnd");
supershape_m            = p.get("supershape_m");
supershape_n1           = p.get("supershape_n1");
supershape_n2           = p.get("supershape_n2");
supershape_n3           = p.get("supershape_n3");
supershape_holes        = p.get("supershape_holes");
conic_holes             = p.get("conic_holes");
conic_eccentricity      = p.get("conic_eccentricity");
parabola_width          = p.get("parabola_width");
parabola_height         = p.get("parabola_height");
bent2_x                 = p.get("bent2_x");
bent2_y                 = p.get("bent2_y");
bipolar_shift           = p.get("bipolar_shift");
cell_size               = p.get("cell_size");
cpow_r                  = p.get("cpow_r");
cpow_i                  = p.get("cpow_i");
cpow_power              = p.get("cpow_power");
loonie_weight           = p.get("loonie_weight");
scry_weight             = p.get("scry_weight");
curve_xamp              = p.get("curve_xamp");
curve_yamp              = p.get("curve_yamp");
curve_xlength           = p.get("curve_xlength");    
curve_ylength           = p.get("curve_ylength");
escher_beta             = p.get("escher_beta");
lazysuzan_spin          = p.get("lazysuzan_spin");
lazysuzan_twist         = p.get("lazysuzan_twist");
lazysuzan_space         = p.get("lazysuzan_space");
lazysuzan_x             = p.get("lazysuzan_x");
lazysuzan_y             = p.get("lazysuzan_y");
lazysuzan_weight        = p.get("lazysuzan_weight");
modulus_x               = p.get("modulus_x");
modulus_y               = p.get("modulus_y");
oscilloscope_separation = p.get("oscilloscope_separation");
oscilloscope_frequency  = p.get("oscilloscope_frequency");
oscilloscope_amplitude  = p.get("oscilloscope_amplitude");
oscilloscope_damping    = p.get("oscilloscope_damping");
popcorn2_x              = p.get("popcorn2_x");
popcorn2_y              = p.get("popcorn2_y");
popcorn2_c              = p.get("popcorn2_c");
separation_x            = p.get("separation_x");
separation_y            = p.get("separation_y");
separation_xinside      = p.get("separation_xinside");
separation_yinside      = p.get("separation_yinside");
split_xsize             = p.get("split_xsize");
split_ysize             = p.get("split_ysize");
splits_x                = p.get("splits_x");
splits_y                = p.get("splits_y");
stripes_space           = p.get("stripes_space");
stripes_warp            = p.get("stripes_warp");
wedge_angle             = p.get("wedge_angle");
wedge_hole              = p.get("wedge_hole");
wedge_count             = p.get("wedge_count");
wedge_swirl             = p.get("wedge_swirl");
wedgesph_angle          = p.get("wedge_angle");
wedgesph_hole           = p.get("wedge_hole");
wedgesph_count          = p.get("wedge_count");
wedgesph_swirl          = p.get("wedge_swirl");
whorl_inside            = p.get("whorl_inside");
whorl_outside           = p.get("whorl_outside");
whorl_weight            = p.get("whorl_weight");
waves2_freqx            = p.get("waves2_freqx");
waves2_freqy            = p.get("waves2_freqy");
waves2_scalex           = p.get("waves2_scalex");
waves2_scaley           = p.get("waves2_scaley");
auger_freq              = p.get("auger_freq");
auger_scale             = p.get("auger_scale");
auger_sym               = p.get("auger_sym");
auger_weight            = p.get("auger_weight");
flux_spread             = p.get("flux_spread");
flux_weight             = p.get("flux_weight");
mobius_re_a             = p.get("mobius_re_a");
mobius_im_a             = p.get("mobius_im_a");
mobius_re_b             = p.get("mobius_re_b");
mobius_im_b             = p.get("mobius_im_b");
mobius_re_c             = p.get("mobius_re_c");
mobius_im_c             = p.get("mobius_im_c");
mobius_re_d             = p.get("mobius_re_d");
mobius_im_d             = p.get("mobius_im_d");
bcollide_num            = p.get("bcollide_num");
bcollide_a              = p.get("bcollide_a");
bmod_radius             = p.get("bmod_radius");
bmod_distance           = p.get("bmod_distance");
bswirl_in               = p.get("bswirl_in");
bswirl_out              = p.get("bswirl_out");
btransform_rotate       = p.get("btransform_rotate");
btransform_power        = p.get("btransform_power");
btransform_move         = p.get("btransform_move");
btransform_split        = p.get("btransform_split");
bwraps7_cellsize        = p.get("bwraps7_cellsize");
bwraps7_space           = p.get("bwraps7_space");
bwraps7_gain            = p.get("bwraps7_gain");
bwraps7_inner_twist     = p.get("bwraps7_inner_twist");
bwraps7_outer_twist     = p.get("bwraps7_outer_twist");
barycentroid_a          = p.get("barycentroid_a");
barycentroid_b          = p.get("barycentroid_b");
barycentroid_c          = p.get("barycentroid_c");
barycentroid_d          = p.get("barycentroid_d");
blocky_x                = p.get("blocky_x");
blocky_y                = p.get("blocky_y");
blocky_mp               = p.get("blocky_mp");
blocky_weight           = p.get("blocky_weight");
blurzoom_x              = p.get("blurzoom_x");
blurzoom_y              = p.get("blurzoom_y");
blurzoom_length         = p.get("blurzoom_length");
boarders2_c             = p.get("boarders2_c");
boarders2_left          = p.get("boarders2_left");
boarders2_right         = p.get("boarders2_right");
cannabiscurvewf_filled  = p.get("cannabiscurvewf_filled");
checks_x                = p.get("checks_x");
checks_y                = p.get("checks_y");
checks_size             = p.get("checks_size");
checks_rnd              = p.get("checks_rnd");
circlecrop_x            = p.get("circlecrop_x");
circlecrop_y            = p.get("circlecrop_y");
circlecrop_scatterarea  = p.get("circlecrop_scatterarea");
circlecrop_zero         = p.get("circlecrop_zero");
circlecrop_radius       = p.get("circlecrop_radius");
circlize_hole           = p.get("circlize_hole");
cloverleaf_filled       = p.get("cloverleaf_filled");
collideoscope_a         = p.get("collideoscope_a");
collideoscope_num       = p.get("collideoscope_num");
crackle_cellsize        = p.get("crackle_cellsize");
crackle_distort         = p.get("crackle_distort");
crackle_power           = p.get("crackle_power");
crackle_scale           = p.get("crackle_scale");
crackle_z               = p.get("crackle_z");
crop_left               = p.get("crop_left");
crop_bottom             = p.get("crop_bottom");
crop_right              = p.get("crop_right");
crop_top                = p.get("crop_top");
crop_scatter_area       = p.get("crop_scatter_area");
crop_zero               = p.get("crop_zero");
dcperlin_edge           = p.get("dcperlin_edge");
dcperlin_freqs          = p.get("dcperlin_freqs");
dcperlin_map            = p.get("dcperlin_map");
dcperlin_octaves        = p.get("dcperlin_octaves");
dcperlin_scale          = p.get("dcperlin_scale");
dcperlin_select_bailout = p.get("dcperlin_select_bailout");
dcperlin_select_centre  = p.get("dcperlin_select_centre");
dcperlin_select_range   = p.get("dcperlin_select_range");
dcperlin_shape          = p.get("dcperlin_shape");
dcperlin_z              = p.get("dcperlin_z");
dcperlin_centre         = p.get("dcperlin_centre");
dcperlin_range          = p.get("dcperlin_range");
dlawf_buffersize        = p.get("dlawf_buffersize");
dlawf_maxiter           = p.get("dlawf_maxiter");
dlawf_seed              = p.get("dlawf_seed");
dlawf_scale             = p.get("dlawf_scale");
ecollide_a              = p.get("ecollide_a");
ecollide_num            = p.get("ecollide_num");
ejulia_power            = p.get("ejulia_power");
emod_distance           = p.get("emod_distance");
emod_radius             = p.get("emod_radius");
emotion_move            = p.get("emotion_move");
emotion_rotate          = p.get("emotion_rotate");
epush_dist              = p.get("epush_dist");
epush_push              = p.get("epush_push");
epush_rotate            = p.get("epush_rotate");
erotate_rotate          = p.get("erotate_rotate");
escale_angle            = p.get("escale_angle");
escale_scale            = p.get("escale_scale");
eswirl_in               = p.get("eswirl_in");
eswirl_out              = p.get("eswirl_out");
eclipse_shift           = p.get("eclipse_shift");
eclipse_weight          = p.get("eclipse_weight");
epispiral_n             = p.get("epispiral_n");
epispiral_holes         = p.get("epispiral_holes");
epispiral_thickness     = p.get("epispiral_thickness");
epispiralwf_waves       = p.get("epispiralwf_waves");
fibonacci2_sc           = p.get("fibonacci2_sc");
fibonacci2_sc2          = p.get("fibonacci2_sc2");
flipcircle_weight       = p.get("flipcircle_weight");
fourth_spin             = p.get("fourth_spin");
fourth_space            = p.get("fourth_space");
fourth_twist            = p.get("fourth_twist");
fourth_x                = p.get("fourth_x");
fourth_y                = p.get("fourth_y");
fourth_weight           = p.get("fourth_weight");
gdoffs_delta_x          = p.get("gdoffs_delta_x");
gdoffs_delta_y          = p.get("gdoffs_delta_y");
gdoffs_area_x           = p.get("gdoffs_area_x");
gdoffs_area_y           = p.get("gdoffs_area_y");
gdoffs_center_x         = p.get("gdoffs_center_x");
gdoffs_center_y         = p.get("gdoffs_center_y");
gdoffs_gamma            = p.get("gdoffs_gamma");
gdoffs_square           = p.get("gdoffs_square");
glynnsim1_radius        = p.get("glynnsim1_radius");
glynnsim1_radius1       = p.get("glynnsim1_radius1");
glynnsim1_phi1          = p.get("glynnsim1_phi1");
glynnsim1_thickness     = p.get("glynnsim1_thickness");
glynnsim1_pow           = p.get("glynnsim1_pow");
glynnsim1_contrast      = p.get("glynnsim1_contrast");
glynnsim2_radius        = p.get("glynnsim2_radius");
glynnsim2_phi2          = p.get("glynnsim2_phi2");
glynnsim2_phi1          = p.get("glynnsim2_phi1");
glynnsim2_thickness     = p.get("glynnsim2_thickness");
glynnsim2_pow           = p.get("glynnsim2_pow");
glynnsim2_contrast      = p.get("glynnsim2_contrast");
glynnsim3_radius        = p.get("glynnsim3_radius");
glynnsim3_thickness2    = p.get("glynnsim3_thickness2");
glynnsim3_thickness     = p.get("glynnsim3_thickness");
glynnsim3_pow           = p.get("glynnsim3_pow");
glynnsim3_contrast      = p.get("glynnsim3_contrast");
heartwf_scale_t_left    = p.get("heartwf_scale_t_left");
heartwf_scale_t_right   = p.get("heartwf_scale_t_right");
heartwf_scale_x         = p.get("heartwf_scale_x");
heartwf_shift_t         = p.get("heartwf_shift_t");
hexes_cellsize          = p.get("hexes_cellsize");
hexes_power             = p.get("hexes_power");
hexes_rotate            = p.get("hexes_rotate");
hexes_scale             = p.get("hexes_scale");
hypertile1_p            = p.get("hypertile1_p");
hypertile1_q            = p.get("hypertile1_q");
hypertile2_p            = p.get("hypertile2_p");
hypertile2_q            = p.get("hypertile2_q");
hypertile_q             = p.get("hypertile_q");
hypertile_p             = p.get("hypertile_p");
hypertile_n             = p.get("hypertile_n");
jaccn_k                 = p.get("jaccn_k");
jacdn_k                 = p.get("jacdn_k");
jacsn_k                 = p.get("jacsn_k");
juliac_dist             = p.get("juliac_dist");
juliac_im               = p.get("juliac_im");
juliac_re               = p.get("juliac_re");
asteria_alpha           = p.get("asteria_alpha");
bwrands_cellsize        = p.get("bwrands_cellsize");
bwrands_space           = p.get("bwrands_space");
bwrands_gain            = p.get("bwrands_gain");
bwrands_inner_twist     = p.get("bwrands_inner_twist");
bwrands_outer_twist     = p.get("bwrands_outer_twist");
bwrands_seed            = p.get("bwrands_seed");
bwrands_rrot            = p.get("bwrands_rrot");
bwrands_rmin            = p.get("bwrands_rmin");
bwrands_loonie_chance   = p.get("bwrands_loonie_chance");
bwrands_petals_chance   = p.get("bwrands_petals_chance");
bwrands_minpetals       = p.get("bwrands_minpetals");
bwrands_maxpetals       = p.get("bwrands_maxpetals");
circlize2_hole          = p.get("circlize2_hole");
funnel_effect           = p.get("funnel_effect");
funnel2_effect          = p.get("funnel2_effect");
juliaq_power            = p.get("juliaq_power");
juliaq_divisor          = p.get("juliaq_divisor");
kaleidoscope_pull       = p.get("kaleidoscope_pull");
kaleidoscope_rotate     = p.get("kaleidoscope_rotate");
kaleidoscope_lineup     = p.get("kaleidoscope_lineup");
kaleidoscope_x          = p.get("kaleidoscope_x");
kaleidoscope_y          = p.get("kaleidoscope_y");
layeredspiral_radius    = p.get("layeredspiral_radius");
vibration2_dir          = p.get("vibration2_dir");
vibration2_angle        = p.get("vibration2_angle");
vibration2_freq         = p.get("vibration2_freq");
vibration2_amp          = p.get("vibration2_amp");
vibration2_phase        = p.get("vibration2_phase");
vibration2_dir2         = p.get("vibration2_dir2");
vibration2_angle2       = p.get("vibration2_angle2");
vibration2_freq2        = p.get("vibration2_freq2");
vibration2_amp2         = p.get("vibration2_amp2");
vibration2_phase2       = p.get("vibration2_phase2");
vibration2_dm           = p.get("vibration2_dm");
vibration2_dmfreq       = p.get("vibration2_dmfreq");
vibration2_tm           = p.get("vibration2_tm");
vibration2_tmfreq       = p.get("vibration2_tmfreq");
vibration2_fm           = p.get("vibration2_fm");
vibration2_fmfreq       = p.get("vibration2_fmfreq");
vibration2_am           = p.get("vibration2_am");
vibration2_amfreq       = p.get("vibration2_amfreq");
vibration2_d2m          = p.get("vibration2_d2m");
vibration2_d2mfreq      = p.get("vibration2_d2mfreq");
vibration2_t2m          = p.get("vibration2_t2m");
vibration2_t2mfreq      = p.get("vibration2_t2mfreq");
vibration2_f2m          = p.get("vibration2_f2m");
vibration2_f2mfreq      = p.get("vibration2_f2mfreq");
vibration2_a2m          = p.get("vibration2_a2m");
vibration2_a2mfreq      = p.get("vibration2_a2mfreq");
lazyjess_n              = p.get("lazyjess_n");
lazyjess_spin           = p.get("lazyjess_spin");
lazyjess_space          = p.get("lazyjess_space");
lazyjess_corner         = p.get("lazyjess_corner");
lazyjess_weight         = p.get("lazyjess_weight");
lineart_powx            = p.get("lineart_powx");
lineart_powy            = p.get("lineart_powy");
lissajous_tmin          = p.get("lissajous_tmin");
lissajous_tmax          = p.get("lissajous_tmax");
lissajous_a             = p.get("lissajous_a");
lissajous_b             = p.get("lissajous_b");
lissajous_c             = p.get("lissajous_c");
lissajous_d             = p.get("lissajous_d");
lissajous_e             = p.get("lissajous_e");
logapo_base             = p.get("logapo_base");
logdb_base              = p.get("logdb_base");
logdb_fix_period        = p.get("logdb_fix_period");
loonie2_sides           = p.get("loonie2_sides");
loonie2_star            = p.get("loonie2_star");
loonie2_circle          = p.get("loonie2_circle");
loonie2_weight          = p.get("loonie2_weight");
loonie3_weight          = p.get("loonie3_weight");
mcarpet_x               = p.get("mcarpet_x");
mcarpet_y               = p.get("mcarpet_y");
mcarpet_tilt            = p.get("mcarpet_tilt");
mcarpet_twist           = p.get("mcarpet_twist");
murl2_power             = p.get("murl2_power");
murl2_c                 = p.get("murl2_c");
murl_power              = p.get("murl_power");
murl_c                  = p.get("murl_c");
nblur_numedges          = p.get("nblur_numedges");
nblur_numstripes        = p.get("nblur_numstripes");
nblur_ratiostripes      = p.get("nblur_ratiostripes");
nblur_ratiohole         = p.get("nblur_ratiohole");
nblur_circumcircle      = p.get("nblur_circumcircle");
nblur_adjusttolinear    = p.get("nblur_adjusttolinear");
nblur_equalblur         = p.get("nblur_equalblur");
nblur_exactcalc         = p.get("nblur_exactcalc");
nblur_highlightedges    = p.get("nblur_highlightedges");
nblur_weight            = p.get("nblur_weight");
bsplit_shiftx           = p.get("bsplit_shiftx");
bsplit_shifty           = p.get("bsplit_shifty");
devilwarp_a = p.get("devilwarp_a");
devilwarp_b = p.get("devilwarp_b");
devilwarp_effect = p.get("devilwarp_effect");
devilwarp_rmax = p.get("devilwarp_rmax");
devilwarp_rmin = p.get("devilwarp_rmin");
devilwarp_warp = p.get("devilwarp_warp");
oscilloscope2_separation = p.get("oscilloscope2_separation");
oscilloscope2_frequencyx  = p.get("oscilloscope2_frequencyx");
oscilloscope2_frequencyy  = p.get("oscilloscope2_frequencyy");
oscilloscope2_amplitude  = p.get("oscilloscope2_amplitude");
oscilloscope2_damping    = p.get("oscilloscope2_damping");
oscilloscope2_perturbation  = p.get("oscilloscope2_perturbation");

    precalc();

  }
  
  PVector getFoldbyNo(int no, PVector p, float w) {
    switch(no) {
      case 1: return lines(p,w);
      case 2: return flower(p,w);
      case 3: return spherical(p,w);
      case 4: return horseshoe(p,w);
      case 5: return polar(p,w);
      case 6: return spiral(p,w);
      case 7: return hyperbolic(p,w);
      case 8: return diamond(p,w);
      case 9: return ex(p,w);
      case 10: return julia(p,w);
      case 11: return handkerchief(p,w);
      case 12: return disc(p,w);
      case 13: return exponential(p,w);
      case 14: return swirl(p,w);
      case 15: return heart(p,w);
      case 16: return power(p,w);
      case 17: return eyefish(p,w);
      case 18: return fisheye(p,w);
      case 19: return bubble(p,w);
      case 20: return square(p,w);
      case 21: return cylinder(p,w);
      case 22: return waves(p,w);
      case 23: return popcorn(p,w);
      case 24: return sinusoidal(p,w);
      case 25: return butterfly(p,w);
      case 26: return cosine(p,w);
      case 27: return rings(p,w);
      case 28: return fan(p,w);
      case 29: return blob(p,w);
      case 30: return pdj(p,w);
      case 31: return bent(p,w);
      case 32: return fan2(p,w);
      case 33: return rings2(p,w);
      case 34: return perspective(p,w);
      case 35: return vnoise(p,w);
      case 36: return julian(p,w);
      case 37: return juliascope(p,w);
      case 38: return blur(p,w);
      case 39: return gaussian(p,w);
      case 40: return realgaussian(p,w);
      case 41: return radialblur(p,w);
      case 42: return pie(p,w);
      case 43: return ngon(p,w);
      case 44: return curl(p,w);
      case 45: return wedgejulia(p,w);
      case 46: return circus(p,w);
      case 47: return rectangles(p,w);
      case 48: return arch(p,w);
      case 49: return tangent(p,w);
      case 50: return rays(p,w);
      case 51: return blade(p,w);
      case 52: return secant(p,w);
      case 53: return twintrian(p,w);
      case 54: return cross(p,w);
      case 55: return disc2(p,w);
      case 56: return supershape(p,w);
      case 57: return conic(p,w);
      case 58: return parabola(p,w);
      case 59: return bent2(p,w);
      case 60: return boarders(p,w);
      case 61: return bipolar(p,w);
      case 62: return cell(p,w);
      case 63: return fold(p,w);
      case 64: return foci(p,w);
      case 65: return loonie(p,w);
      case 66: return polar2(p,w);
      case 67: return scry(p,w);
      case 68: return vexp(p,w);
      case 69: return rotate(p,w);
      case 70: return curve(p,w);
      case 71: return edisc(p,w);
      case 72: return elliptic(p,w);
      case 73: return escher(p,w);
      case 74: return lazysuzan(p,w);
      case 75: return modulus(p,w);
      case 76: return oscilloscope(p,w);
      case 77: return popcorn2(p,w);
      case 78: return separation(p,w);
      case 79: return split(p,w);
      case 80: return splits(p,w);
      case 81: return stripes(p,w);
      case 82: return wedge(p,w);
      case 83: return wedgesph(p,w);
      case 84: return whorl(p,w);
      case 85: return waves2(p,w);
      case 86: return auger(p,w);
      case 87: return flux(p,w);
      case 88: return mobius(p,w);
      case 89: return vlog(p,w);
      case 90: return vsin(p,w);
      case 91: return vcos(p,w);
      case 92: return vtan(p,w);
      case 93: return sec(p,w);
      case 94: return csc(p,w);
      case 95: return cot(p,w);
      case 96: return vsinh(p,w);
      case 97: return vcosh(p,w);
      case 98: return vtanh(p,w);
      case 99: return sech(p,w);
      case 100: return csch(p,w);
      case 101: return coth(p,w); 
      case 102: return bcollide(p,w);
      case 103: return bmod(p,w);
      case 104: return bswirl(p,w);
      case 105: return btransform(p,w);
      case 106: return bwraps7(p,w);
      case 107: return barycentroid(p,w);
      case 108: return bilinear(p,w);
      case 109: return blocky(p,w);
      case 110: return blurzoom(p,w);
      case 111: return boarders2(p,w);
      case 112: return cannabiscurvewf(p,w);
      case 113: return checks(p,w);
      case 114: return circleblur(p,w);
      case 115: return circlecrop(p,w);
      case 116: return circlize(p,w);
      case 117: return cloverleaf(p,w);
      case 118: return collideoscope(p,w);
      case 119: return crackle(p,w);
      case 120: return crop(p,w);
      case 121: return dcperlin(p,w);
      case 122: return dlawf(p,w);
      case 123: return ecollide(p,w);
      case 124: return ejulia(p,w);
      case 125: return emod(p,w);
      case 126: return emotion(p,w);
      case 127: return epush(p,w);
      case 128: return erotate(p,w);
      case 129: return escale(p,w);
      case 130: return eswirl(p,w);
      case 131: return eclipse(p,w);
      case 132: return epispiral(p,w);
      case 133: return epispiralwf(p,w);
      case 134: return fibonacci2(p,w);
      case 135: return flipcircle(p,w);
      case 136: return flipy(p,w);
      case 137: return fourth(p,w);
      case 138: return gdoffs(p,w);
      case 139: return glynnsim1(p,w);
      case 140: return glynnsim2(p,w);
      case 141: return glynnsim3(p,w);
      case 142: return glynnia(p,w);
      case 143: return heartwf(p,w);
      case 144: return hexes(p,w);
      case 145: return hypertile1(p,w);
      case 146: return hypertile2(p,w);
      case 147: return hypertile(p,w);
      case 148: return jaccn(p,w);
      case 149: return jacdn(p,w);
      case 150: return jacsn(p,w);
      case 151: return juliac(p,w);
      case 152: return asteria(p,w);
      case 153: return bwrands(p,w);
      case 154: return circlize2(p,w);
      case 155: return ennepers(p,w);
      case 156: return funnel(p,w);
      case 157: return funnel2(p,w);
      case 158: return juliaq(p,w);
      case 159: return kaleidoscope(p,w);
      case 160: return layeredspiral(p,w);
      case 161: return vibration2(p,w);
      case 162: return lazyjess(p,w);
      case 163: return lineart(p,w);
      case 164: return lissajous(p,w);
      case 165: return logapo(p,w);
      case 166: return logdb(p,w);
      case 167: return loonie2(p,w);
      case 168: return loonie3(p,w);
      case 169: return mcarpet(p,w);
      case 170: return murl2(p,w);
      case 171: return murl(p,w);
      case 172: return nblur(p,w);
      case 173: return bsplit(p,w);
      case 174: return devilwarp(p,w);
      case 175: return oscilloscope2(p,w);
      default: return new PVector(w * p.x, w * p.y);
    }
  }  
  
  void precalc() {
    float tmp, tmp2;
    
    rings_c2 = rings_c * rings_c;
    
    fan_cc = PI * sq(fan_c);
    fan_c2 = 0.5 * fan_cc;
    
    blob_bdiff = blob_high - blob_low;
    
    fan2_dx = PI * sq(fan2_x) + 1.0e-10;
    fan2_dx2 = 0.5 * fan2_dx;
    
    rings2_val2 = sq(rings2_val);
    
    tmp = perspective_angle * PI/2.0;
    perspective_vsin = sin(tmp);
    perspective_vfcos = perspective_dist * cos(tmp);
    
    julian_cpower = julian_dist/julian_power/2.0;
    julian_abspower = abs(julian_power);
    
    juliascope_cpower = juliascope_dist/juliascope_power/2.0;
    juliascope_abspower = abs(juliascope_power);
    
    radialblur_spinvar = sin(radialblur_angle);
    radialblur_zoomvar = cos(radialblur_angle);
    
    ngon_pow = ngon_power/2.0;
    ngon_b = TWO_PI / ngon_sides;
    
    wedgejulia_cf = 1.0 - 0.5 / PI * wedgejulia_angle * wedgejulia_count;
    wedgejulia_cn = wedgejulia_dist / wedgejulia_power / 2.0;
    wedgejulia_rN = abs(wedgejulia_power);
    
    disc2_timespi = disc2_rot * PI;
    disc2_sinadd = sin(disc2_twist);
    disc2_cosadd = cos(disc2_twist)-1.0;
    if(disc2_twist > TWO_PI) {
      float k = 1 + disc2_twist - TWO_PI;
      disc2_cosadd *= k;
      disc2_sinadd *= k;
    }
    if(disc2_twist < -TWO_PI) {
      float k = 1 + disc2_twist + TWO_PI;
      disc2_cosadd *= k;
      disc2_sinadd *= k;
    }
    
    supershape_pm_4 = supershape_m / 4.0;
    supershape_pneg1_n1 = -1.0 / supershape_n1;
    
    bipolar_ps = -HALF_PI * bipolar_shift;
    
    cpow_va = TWO_PI / cpow_power;
    cpow_vc = cpow_r / cpow_power;
    cpow_vd = cpow_i / cpow_power;
    
    curve_xlength2 = sq(curve_xlength);
    curve_ylength2 = sq(curve_ylength);
    
    elliptic_v =  2 / HALF_PI;
    
    escher_vc = 0.5 * (1.0 + cos(escher_beta));
    escher_vd = 0.5 * sin(escher_beta);
    
    separation_x2 = sq(separation_x);
    separation_y2 = sq(separation_y);
    
    bcollide_bcn_pi = bcollide_num / PI;
    bcollide_pi_bcn = PI / bcollide_num;
    bcollide_bca_bcn = (PI * bcollide_a) / bcollide_num;
    
    tmp = 0.5 * (bwraps7_cellsize / (1.0 + sq(bwraps7_space)));
    bwraps7_g2 = sq(bwraps7_gain) + 1.0e-10;
    tmp2 = bwraps7_g2 * tmp;
    if(tmp2>2.0) 
      tmp2 = 1.0;
     else
      tmp2 *= 1.0 / (( sq(tmp2) / 4.0 + 1.0));
    bwraps7_r2 = sq(tmp);
    bwraps7_rfactor = tmp / tmp2;  
    
    barycentroid_dot00 = sq(barycentroid_a) + sq(barycentroid_b);
    barycentroid_dot01 = barycentroid_a * barycentroid_c + barycentroid_b * barycentroid_d;
    barycentroid_dot11 = sq(barycentroid_c) + sq(barycentroid_d);
    barycentroid_invdenom = 1.0 / (barycentroid_dot00 * barycentroid_dot11 - sq(barycentroid_dot01));
    
    boarders2_cl = boarders2_c * boarders2_left;
    boarders2_cr = boarders2_c + (boarders2_c * boarders2_right);
    
    checks_cs = 1.0 / (checks_size + 1.0e-10);
    
    collideoscope_kn_pi = collideoscope_num / PI;
    collideoscope_pi_kn = PI / collideoscope_num;
    collideoscope_ka_kn = (PI * collideoscope_a) / collideoscope_num;
    
    crackle_obj = new Crackle(crackle_z, crackle_cellsize, crackle_distort, crackle_power, crackle_scale);
    
    crop_w = (crop_right - crop_left) * 0.5 * crop_scatter_area;
    crop_h = (crop_bottom - crop_top) * 0.5 * crop_scatter_area;
    
    dcperlin_notch_bottom = dcperlin_select_centre - dcperlin_select_range;
    dcperlin_notch_bottom = (dcperlin_notch_bottom > 0.75) ? 0.75 : dcperlin_notch_bottom;
    dcperlin_notch_bottom = (dcperlin_notch_bottom < -3.0) ? -3.0 : dcperlin_notch_bottom;
    dcperlin_notch_top = dcperlin_select_centre + dcperlin_select_range;
    dcperlin_notch_top = (dcperlin_notch_top < -0.75) ? -0.75 : dcperlin_notch_top;
    dcperlin_notch_top = (dcperlin_notch_top > 3.0) ? 3.0 : dcperlin_notch_top;
    
    dlawf_obj = new DLAWF(dlawf_seed, dlawf_maxiter, dlawf_buffersize, dlawf_scale);
    
    ecollide_ecn_pi = ecollide_num / PI;
    ecollide_pi_ecn = PI / ecollide_num;
    ecollide_eca_ecn = (PI * ecollide_a) / ecollide_num;
    
    fourth_sqrvvar = sq(fourth_weight);
    
    gdoffs_gdodx = gdoffs_delta_x * gdoffs_agdod;
    gdoffs_gdody = gdoffs_delta_y * gdoffs_agdod;
    gdoffs_gdoax = (abs(gdoffs_area_x) < 0.1 ? 0.1 : abs(gdoffs_area_x)) * gdoffs_agdoa;
    gdoffs_gdoay = (abs(gdoffs_area_y) < 0.1 ? 0.1 : abs(gdoffs_area_y)) * gdoffs_agdoa;
    gdoffs_gdocx = gdoffs_center_x * gdoffs_agdoc;
    gdoffs_gdocy = gdoffs_center_y * gdoffs_agdoc;
    gdoffs_gdob = gdoffs_gamma * gdoffs_agdoa / (max(gdoffs_gdoax, gdoffs_gdoay));
    
    tmp = PI * glynnsim1_phi1 / 180.0;
    glynnsim1_x1 = glynnsim1_radius * cos(tmp);
    glynnsim1_y1 = glynnsim1_radius * sin(tmp);
    glynnsim1_abspow = abs(glynnsim1_pow); 
    
    glynnsim2_phi10 = PI * glynnsim2_phi1 / 180.0;
    glynnsim2_phi20 = PI * glynnsim2_phi2 / 180.0;
    glynnsim2_gamma = glynnsim2_thickness * (2.0 * glynnsim2_radius + glynnsim2_thickness) / (glynnsim2_radius + glynnsim2_thickness);
    glynnsim2_delta = glynnsim2_phi20 - glynnsim2_phi10;
    glynnsim2_abspow = abs(glynnsim2_pow);
    
    glynnsim3_radius1 = glynnsim3_radius + glynnsim3_thickness;
    glynnsim3_radius2 = sq(glynnsim3_radius) / glynnsim3_radius1;
    glynnsim3_gamma = glynnsim3_radius1 / (glynnsim3_radius1 + glynnsim3_radius2);
    glynnsim3_abspow = abs(glynnsim2_pow);
    
    hexes_obj = new Hexes(hexes_cellsize, hexes_power, hexes_rotate, hexes_scale);

    hypertile1_pa = TWO_PI / hypertile1_p;
    tmp = 1.0 - (cos(TWO_PI / hypertile1_p) - 1.0) / (cos(TWO_PI / hypertile1_p) + cos(TWO_PI / hypertile1_q));
    if(tmp>0) hypertile1_r = 1.0 / sqrt(tmp); else hypertile1_r=1.0;
    
    hypertile2_pa = TWO_PI / hypertile2_p;
    tmp = 1.0 - (cos(TWO_PI / hypertile2_p) - 1.0) / (cos(TWO_PI / hypertile2_p) + cos(TWO_PI / hypertile2_q));
    if(tmp>0) hypertile2_r = 1.0 / sqrt(tmp); else hypertile2_r=1.0;
    
    tmp = TWO_PI / hypertile_p;
    tmp2 = TWO_PI / hypertile_q;
    float tmp3 = (1.0 - cos(tmp)) / ((cos(tmp) + cos(tmp2)) + 1.0);
    if(tmp3 > 0) tmp3 = 1.0/sqrt(tmp3); else tmp3 = 1.0;
    tmp2 = hypertile_n * tmp;
    hypertile_re = tmp3 * cos(tmp2);
    hypertile_im = tmp3 * sin(tmp2);
    
    asteria_sina = sin(PI*asteria_alpha);
    asteria_cosa = cos(PI*asteria_alpha);
    
    tmp = 0.5 * ( bwrands_cellsize / (1.0 + sq(bwrands_space)));
    bwrands_g2 = sq(bwrands_gain) / tmp + 1.0e-6;
    tmp2 = bwrands_g2 * tmp;
    if(tmp2 > 2.0) tmp2 = 1.0;
    else tmp2 *= 1.0 / ( sq(tmp2)/4.0 + 1.0);
    bwrands_r2 = sq(tmp);
    bwrands_rfactor = tmp / tmp2;
    bwrands_petx = min(bwrands_minpetals,bwrands_maxpetals);
    bwrands_pety = abs(bwrands_maxpetals - bwrands_minpetals);

    juliaq_half_inv_power = 0.5 * juliaq_divisor / juliaq_power;
    juliaq_inv_power = juliaq_divisor / juliaq_power;
    juliaq_inv_power_2pi = TWO_PI / juliaq_power;
    
    if(lazyjess_n < 2) lazyjess_n = 2;
    lazyjess_vertex = PI * (lazyjess_n - 2) / (2 * lazyjess_n);
    lazyjess_sin_vertex = sin(lazyjess_vertex);
    lazyjess_pie_slice = TWO_PI/ lazyjess_n;
    lazyjess_half_slice = lazyjess_pie_slice / 2;
    lazyjess_corner_rotation = (lazyjess_corner - 1) * lazyjess_pie_slice;
    
    logapo_denom = 0.5 / log(logapo_base);
    
    logdb_denom = 0.5;
    if(logdb_base > 1.0e-10)
      logdb_denom = logdb_denom / log(2.71828182845905 * logdb_base);
    logdb_fixpe = PI;
    if(logdb_fix_period > 1.0e-10)
      logdb_fixpe *= logdb_fix_period;  
      
    loonie2_sqrvvar = sq(loonie2_weight);
    tmp = TWO_PI / loonie2_sides;
    loonie2_sina = sin(tmp);
    loonie2_cosa = cos(tmp);
    tmp = -TWO_PI / loonie2_star;
    loonie2_sins = sin(tmp);
    loonie2_coss = cos(tmp);
    tmp = TWO_PI / loonie2_circle;
    loonie2_sinc = sin(tmp);
    loonie2_cosc = cos(tmp);
    
    loonie3_sqrvvar = sq(loonie3_weight);
    
    if(nblur_numedges < 3) nblur_numedges = 3;
    if(nblur_numstripes != 0) {
      nblur_hasStripes = 1;
      if(nblur_numstripes < 0) {
        nblur_negStripes = 1;
        nblur_numstripes *= -1;
      } else nblur_negStripes = 0;
    } else {
      nblur_hasStripes = 0;
      nblur_negStripes = 0;
    }
    nblur_midAngle = TWO_PI / nblur_numedges;
    if(nblur_hasStripes == 1) {
      nblur_angStripes = nblur_midAngle / (2*nblur_numstripes);
      nblur_angStart = nblur_angStripes / 2.0;
      nblur_ratiocomplement = 2.0 - nblur_ratiostripes;
    }
    if(nblur_ratiohole>0.95 && nblur_exactcalc==1 && nblur_circumcircle==0)
      nblur_ratiohole = 0.95;
    nblur_tan90_m_2 = tan(HALF_PI + nblur_midAngle / 2.0);
    tmp = nblur_midAngle / 2.0;
    nblur_sina = sin(tmp);
    nblur_cosa = cos(tmp);
    if(nblur_highlightedges <= 0.1) nblur_highlightedges = 0.1;
    if(nblur_adjusttolinear == 1) {
      if(nblur_numedges%4==0)
        nblur_weight /= sqrt(2.0 - 2.0 * cos(nblur_midAngle * (nblur_numedges/2.0-1.0)))/2.0;
       else
        nblur_weight /= sqrt(2.0 - 2.0 * cos(nblur_midAngle * floor(nblur_numedges/2.0)))/2.0; 
    }
    if(nblur_circumcircle==1) {
      nblur_exactcalc = 0;
      nblur_highlightedges = 0.1;
    }
    nblur_speedCalc1 = nblur_ratiocomplement * nblur_angStart;
    nblur_speedCalc2 = nblur_ratiostripes * nblur_angStart;
    nblur_maxStripes = 2*nblur_numstripes;
    if(nblur_negStripes == 0) {
      nblur_arc_tan1 = (13.0/pow(nblur_numedges,1.3))*nblur_highlightedges;
      nblur_arc_tan2 = (2.0*atan(nblur_arc_tan1)/-2.0);
    } else {
      nblur_arc_tan1 = (7.5/pow(nblur_numedges,1.3))*nblur_highlightedges;
      nblur_arc_tan2 = (2.0*atan(nblur_arc_tan1)/-2.0);
    }

 }

PVector oscilloscope2(PVector p, float weight) {
  float t, pt = oscilloscope2_perturbation * sin(oscilloscope2_frequencyy * p.y);
  if(abs(oscilloscope2_damping)<1.0e-6) {
    t = oscilloscope2_amplitude * (cos(oscilloscope2_frequencyx * p.x + pt)) + oscilloscope2_separation;
  } else {
    t = oscilloscope2_amplitude * exp(-abs(p.x)*oscilloscope2_damping) * (cos(oscilloscope2_frequencyx * p.x + pt)) + oscilloscope2_separation;
  }
  
  if(abs(p.y)<=t) {
    return new PVector(weight * -p.x, weight * -p.y);
  } else {
    return new PVector(weight * p.x, weight * p.y);
  }
}

PVector devilwarp(PVector p, float weight) {
  float r2 = 1.0 / p.magSq();
  float r = pow(sq(p.x) + r2 * devilwarp_b * sq(p.y),devilwarp_warp) - pow(sq(p.y) + r2 * devilwarp_a * sq(p.x), devilwarp_warp);
  if(r>devilwarp_rmax) r = devilwarp_rmax;
  else if(r< devilwarp_rmin) r = devilwarp_rmin;
  r = devilwarp_effect * r;
  return new PVector(p.x * (1+r), p.y*(1+r));
}

 PVector bsplit(PVector p, float weight) {
   if(p.x+bsplit_shiftx == 0 || p.x + bsplit_shiftx == PI) {
     return new PVector(weight * p.x,weight * p.y);
   } else {
     float xx = weight / tan(p.x+bsplit_shiftx) * cos(p.y + bsplit_shifty);
     float yy = weight / sin(p.x+bsplit_shiftx) * (-1 * p.y + bsplit_shifty);
     return new PVector(xx,yy);
   }
 }

 class randXYData {
   float x,y;
   float lenXY, lenOuterEdges, lenInnerEdges;
 }

 void randXY(randXYData d) {
   float x, y;
   float xTmp, yTmp, lenOuterEdges = d.lenOuterEdges, lenInnerEdges=d.lenOuterEdges;
   float angXY, lenXY=d.lenXY;
   float ranTmp, angTmp, angMem;
   float ratioTmp, ratioTmpNum, ratioTmpDen;
   float speedCalcTmp;
   int count;
   
   if(nblur_exactcalc == 1)
     angXY = random(1)*TWO_PI;
    else
     angXY = (atan(nblur_arc_tan1*(random(1)-0.5))/(nblur_arc_tan2)+0.5 + ((int)random(32767))%((int)nblur_numedges)) * nblur_midAngle;
   x=sin(angXY);
   y=cos(angXY);
   angMem = angXY;
   while(angXY>nblur_midAngle)
     angXY -= nblur_midAngle;
   
   if(nblur_hasStripes == 1) {
     angTmp = nblur_angStart;
     count = 0;
     
     while(angXY > angTmp) {
       angTmp += nblur_angStripes;
       if(angTmp > nblur_midAngle) angTmp = nblur_midAngle;
       count++;
     }
     
     if(angTmp!=nblur_midAngle) angTmp -= nblur_angStart;
     
     if(nblur_negStripes == 0) {
       
       if(count%2==1) {
         if(angXY>angTmp) {
           angXY = angXY + nblur_angStart;
           angMem = angMem + nblur_angStart;
           x = sin(angMem);
           y = cos(angMem);
           angTmp += nblur_angStripes;
           count++;
         } else {
           angXY = angXY - nblur_angStart;
           angMem = angMem - nblur_angStart;
           x = sin(angMem);
           y = cos(angMem);
           angTmp -= nblur_angStripes;
           count--;
         }
       }  
         
         if(count%2==0 && nblur_ratiostripes >1.0) {
           if(angXY > angTmp && count!=nblur_maxStripes) {
             angMem = angMem - angXY + angTmp + (angXY-angTmp)/nblur_angStart * nblur_ratiostripes * nblur_angStart;
             angXY  = angTmp + (angXY-angTmp)/(nblur_angStart) * nblur_ratiostripes * nblur_angStart;
             x = sin(angMem);
             y = cos(angMem);
           } else {
             angMem = angMem - angXY + angTmp - (angTmp-angXY)/nblur_angStart * nblur_ratiostripes * nblur_angStart;
             angXY  = angTmp + (angXY-angTmp)/(nblur_angStart) * nblur_ratiostripes * nblur_angStart;
             x = sin(angMem);
             y = cos(angMem);
           }
         }
         
         if(count%2==0 && nblur_ratiostripes<1.0) {
             if(abs(angXY-angTmp) > nblur_speedCalc2 && count != nblur_maxStripes) {
               if((angXY-angTmp) > nblur_speedCalc2) {
                 ratioTmpNum = (angXY - (angTmp+nblur_speedCalc2))*nblur_speedCalc2;
                 ratioTmpDen = nblur_angStart - nblur_speedCalc2;
                 ratioTmp = ratioTmpNum/ratioTmpDen;
                 float t = angMem - angXY + angTmp + ratioTmp;
                 x = sin(t);
                 y = cos(t);
                 angXY = angTmp + ratioTmp;
               }
               if((angTmp-angXY) > nblur_speedCalc2) {
                 ratioTmpNum = (angTmp - nblur_speedCalc2-angXY)*nblur_speedCalc2;
                 ratioTmpDen = nblur_angStart - nblur_speedCalc2;
                 ratioTmp = ratioTmpNum/ratioTmpDen;
                 float t = angMem - angXY + angTmp - ratioTmp;
                 x = sin(t);
                 y = cos(t);
                 angXY = angTmp - ratioTmp;
               }
             }
             if(count==nblur_maxStripes) {
               if((angTmp-angXY)>nblur_speedCalc2) {
                 ratioTmpNum = (angTmp - nblur_speedCalc2-angXY)*nblur_speedCalc2;
                 ratioTmpDen = nblur_angStart - nblur_speedCalc2;
                 ratioTmp = ratioTmpNum/ratioTmpDen;
                 float t = angMem - angXY + angTmp - ratioTmp;
                 x = sin(t);
                 y = cos(t);
                 angXY = angTmp - ratioTmp;
               }
             }
           }  
 
     } else {
       ratioTmp = nblur_ratiostripes;
       nblur_ratiostripes = nblur_ratiocomplement;
       nblur_ratiocomplement = ratioTmp;
       speedCalcTmp = nblur_speedCalc1;
       nblur_speedCalc1 = nblur_speedCalc2;
       nblur_speedCalc2 = speedCalcTmp;
       
       if(count%2==0) {
         if(angXY>angTmp && count != nblur_maxStripes) {
           angXY = angXY + nblur_angStart;
           angMem = angMem + nblur_angStart;
           x = sin(angMem);
           y = cos(angMem);
           angTmp += nblur_angStripes;
           count++;
         } else {
           angXY = angXY - nblur_angStart;
           angMem = angMem - nblur_angStart;
           x = sin(angMem);
           y = cos(angMem);
           angTmp -= nblur_angStripes;
           count--;
         }
       }
       
       if(count%2==1 && nblur_ratiostripes >1.0) {
           if(angXY > angTmp && count!=nblur_maxStripes) {
             angMem = angMem - angXY + angTmp + (angXY-angTmp)/nblur_angStart * nblur_ratiostripes * nblur_angStart;
             angXY  = angTmp + (angXY-angTmp)/(nblur_angStart) * nblur_ratiostripes * nblur_angStart;
             x = sin(angMem);
             y = cos(angMem);
           } else {
             angMem = angMem - angXY + angTmp - (angTmp-angXY)/nblur_angStart * nblur_ratiostripes * nblur_angStart;
             angXY  = angTmp + (angXY-angTmp)/(nblur_angStart) * nblur_ratiostripes * nblur_angStart;
             x = sin(angMem);
             y = cos(angMem);
           }
         }
       
       if(count%2==1 && nblur_ratiostripes<1.0) {
             if(abs(angXY-angTmp) > nblur_speedCalc2 && count != nblur_maxStripes) {
               if((angXY-angTmp) > nblur_speedCalc2) {
                 ratioTmpNum = (angXY - (angTmp+nblur_speedCalc2))*nblur_speedCalc2;
                 ratioTmpDen = nblur_angStart - nblur_speedCalc2;
                 ratioTmp = ratioTmpNum/ratioTmpDen;
                 float t = angMem - angXY + angTmp + ratioTmp;
                 x = sin(t);
                 y = cos(t);
                 angXY = angTmp + ratioTmp;
               }
               if((angTmp-angXY) > nblur_speedCalc2) {
                 ratioTmpNum = (angTmp - nblur_speedCalc2-angXY)*nblur_speedCalc2;
                 ratioTmpDen = nblur_angStart - nblur_speedCalc2;
                 ratioTmp = ratioTmpNum/ratioTmpDen;
                 float t = angMem - angXY + angTmp - ratioTmp;
                 x = sin(t);
                 y = cos(t);
                 angXY = angTmp - ratioTmp;
               }
             }
             if(count==nblur_maxStripes) {
               angTmp = nblur_midAngle;
               if((angTmp-angXY)>nblur_speedCalc2) {
                 ratioTmpNum = (angTmp - nblur_speedCalc2-angXY)*nblur_speedCalc2;
                 ratioTmpDen = nblur_angStart - nblur_speedCalc2;
                 ratioTmp = ratioTmpNum/ratioTmpDen;
                 float t = angMem - angXY + angTmp - ratioTmp;
                 x = sin(t);
                 y = cos(t);
                 angXY = angTmp - ratioTmp;
               }
             }
           }
       
         ratioTmp = nblur_ratiostripes;
       nblur_ratiostripes = nblur_ratiocomplement;
       nblur_ratiocomplement = ratioTmp;
       speedCalcTmp = nblur_speedCalc1;
       nblur_speedCalc1 = nblur_speedCalc2;
       nblur_speedCalc2 = speedCalcTmp;
       
     }
   } 
   
   xTmp = nblur_tan90_m_2 /(nblur_tan90_m_2 - tan(angXY));
   yTmp = xTmp * tan(angXY);
   lenOuterEdges = sqrt(sq(xTmp)+sq(yTmp));
   
   if(nblur_exactcalc == 1) {
     if(nblur_equalblur == 1) ranTmp = sqrt(random(1));
     else ranTmp = random(1);
   } else {
     if(nblur_circumcircle == 1) {
       if(nblur_equalblur == 1) ranTmp = sqrt(random(1));
       else ranTmp = random(1);
     } else {
       if(nblur_equalblur == 1) ranTmp = sqrt(random(1)) * lenOuterEdges;
       else ranTmp = random(1) * lenOuterEdges;
     }
   }
   
   lenInnerEdges = nblur_ratiohole * lenOuterEdges;
   
   if(nblur_exactcalc == 0) {
     if(ranTmp<lenInnerEdges) {
       if(nblur_circumcircle == 1) {
         if(nblur_equalblur == 1) ranTmp = lenInnerEdges + sqrt(random(1)) * (1.0 - lenInnerEdges + 1.0e-6);
         else ranTmp = lenInnerEdges + random(1) * (1.0 - lenInnerEdges + 1.0e-6);
       } else {
         if(nblur_equalblur == 1) ranTmp = lenInnerEdges + sqrt(random(1)) * (lenOuterEdges - lenInnerEdges);
         else ranTmp = lenInnerEdges + random(1) * (lenOuterEdges - lenInnerEdges);
       }
     }
   }
   
   x*=ranTmp;
   y*=ranTmp;
   lenXY = sqrt(sq(x)+sq(y));
   
   d.x = x;
   d.y = y;
   d.lenXY = lenXY;
   d.lenInnerEdges = lenInnerEdges;
   d.lenOuterEdges = lenOuterEdges;
 }

 PVector nblur(PVector p, float weight) {
   randXYData data = new randXYData();
   randXY(data);
   
   if(nblur_exactcalc == 1 && nblur_circumcircle == 0)
     while( (data.lenXY < data.lenInnerEdges) || (data.lenXY > data.lenOuterEdges)) randXY(data);
   
   if(nblur_exactcalc == 1 && nblur_circumcircle == 1)
     while( (data.lenXY < data.lenInnerEdges)) randXY(data);
   
   float x = nblur_weight * weight * (nblur_cosa * data.x - nblur_sina * data.y);
   float y = nblur_weight * weight * (nblur_sina * data.x + nblur_cosa * data.y);
   
   return new PVector(3*x,3*y);
   
 }

 PVector murl(PVector p, float weight) {
   float c = murl_c;
   if( murl_power-1 > 1e-6) {
     c/=murl_power = 1.0;
   }
   float p2 = murl_power / 2.0;
   float vp = weight * (c+1);
   float a = atan2(p.y,p.x) * murl_power;
   float sina = sin(a);
   float cosa = cos(a);
   
   float r = c * pow(p.magSq(),p2);
   float re = r * cosa + 1.0;
   float im = r * sina;
   float r1 = vp / (sq(re) + sq(im));
   
   float x = r1 * (p.x * re + p.y * im);
   float y = r1 * (p.y * re - p.x * im);
   
   return new PVector(x,y);
 }

 PVector murl2(PVector p, float weight) {
   float p2 = murl2_power / 2.0;
   float invp,vp;
   if(abs(murl2_power)>1.0e-6) {
     invp = 1.0 / murl2_power;
     if(murl2_c == -1.0) vp =0.0;
     else vp = weight * pow(murl2_c + 1.0, 2.0 / murl2_power); 
   } else {
     invp = 1.0e10;
     vp = weight * pow(murl2_c + 1.0, 4);
   }
   float a = atan2(p.y,p.x) * murl2_power;
   float sina = sin(a);
   float cosa = cos(a);
   
   float r = murl2_c * pow(p.magSq(),p2);
   float re = r * cosa + 1.0;
   float im = r * sina;
   
   r = pow(sq(re) + sq(im), invp);
   a = atan2(im,re) * 2.0 * invp;
   re = r*cos(a);
   im = r*sin(a);
   float r1 = vp / sq(r);
   
   float x = r1 * (p.x * re + p.y * im);
   float y = r1 * (p.y * re - p.x * im);
   
   return new PVector(x,y);
   
 }

 PVector mcarpet(PVector p, float weight) {
   float t = p.magSq() / 4.0 + 1.0;
   float r = 1.0/t;
   float x = p.x * r * mcarpet_x;
   float y = p.y * r * mcarpet_y;
   x += (1.0 - (mcarpet_twist * sq(p.x)) + p.y);
   y += mcarpet_tilt * p.x;
   return new PVector(weight * x, weight * y);
 }
   
 PVector loonie3(PVector p, float weight) {
   float r2 = 2 * loonie3_sqrvvar;
   if(p.x>1.0e-10) {
     r2 = sq(p.magSq() / p.x);
   }
   
   float r = weight;
   if(r2 < loonie3_sqrvvar) {
     r *= sqrt(loonie3_sqrvvar / r2 -1.0);
   }
   return new PVector(r*p.x,r*p.y);
 }

 PVector loonie2(PVector p, float weight) {
   float xrt = p.x;
   float yrt = p.y;
   float swp;
   float r2 = xrt * loonie2_coss + abs(yrt) * loonie2_sins;
   float circle = p.mag();
   int i;
   for(i =0;i<loonie2_sides-1;i++) {
     swp = xrt * loonie2_cosa - yrt * loonie2_sina;
     yrt = xrt * loonie2_sina + yrt * loonie2_cosa;
     xrt = swp;
     
     r2 = max(r2, xrt * loonie2_coss + abs(yrt) * loonie2_sins);
   }
   
   r2 = r2 * loonie2_cosc + circle * loonie2_sinc;
   if(i>1)
     r2 = sq(r2);
    else
     r2 = abs(r2)*r2;
     
   float x,y;  
   if(r2>0 && (r2<loonie2_sqrvvar)) {
     float r = weight * sqrt(abs(loonie2_sqrvvar / r2 - 1.0));
     x = r*p.x;
     y = r*p.y;
   } else {
     if(r2<0) {
       float r = weight / sqrt(abs(loonie2_sqrvvar / r2) - 1.0);
       x = r * p.x;
       y = r * p.y;
     } else {
       x = weight * p.x;
       y = weight * p.y;
     }
   }
   
   return new PVector(x,y); 
 }

 PVector logdb(PVector p, float weight) {
   float fap = 0.0;
   int adp;
   for(int i=0;i<7;i++) {
     adp = (int)random(-5,5);
     if(abs(adp)>=3) adp = 0;
     fap += adp;
   }
   fap *= logdb_fixpe;
   float x = weight * logdb_denom * log(p.magSq());
   float y = weight * (atan2(p.y,p.x) + fap);
   return new PVector(x,y);
 }

 PVector logapo(PVector p, float weight) {
   float x = weight * log(p.magSq()) * logapo_denom;
   float y = weight * atan2(p.y,p.x);
   return new PVector(x,y);
 }
 
 PVector lissajous(PVector p, float weight) {
   float t = (lissajous_tmax-lissajous_tmin) * random(1) + lissajous_tmin;
   float y = random(-0.5,0.5);
   float x1 = sin(lissajous_a * t + lissajous_d);
   float y1 = sin(lissajous_b * t);
   
   return new PVector(weight * (x1 + lissajous_c * t + lissajous_e * y), weight * (y1 + lissajous_c * t + lissajous_e * y) );
 }

 PVector lineart(PVector p, float weight) {
   float xx = sgn(p.x) * pow(abs(p.x),lineart_powx) * weight;
   float yy = sgn(p.y) * pow(abs(p.y),lineart_powy) * weight;
   return new PVector(xx,yy);
 }
   
 PVector lazyjess(PVector p, float weight) {
   float theta, sina, cosa;
   float x = p.x;
   float y = p.y;
   float modulus = p.mag();
   
   if(lazyjess_n==2) {
    
     if(abs(x) < lazyjess_weight) {
       theta = atan2(y,x) + lazyjess_spin;
       sina = sin(theta);
       cosa = cos(theta);
       x = lazyjess_weight * modulus * cosa;
       y = lazyjess_weight * modulus * sina;
       
       if(abs(x) >= lazyjess_weight) {
         theta = atan2(y,x) - lazyjess_spin + lazyjess_corner_rotation;
         sina = sin(theta);
         cosa = cos(theta);
         x = lazyjess_weight * modulus * cosa;
         y = -lazyjess_weight * modulus * sina;         
       }
     } else {
       modulus = 1.0 + lazyjess_space / modulus;
       x = lazyjess_weight * modulus * x;
       y = lazyjess_weight * modulus * y;
     }
     
   } else {
     
     theta = atan2(y,x) + TWO_PI;
     float theta_diff = (theta+lazyjess_half_slice) % lazyjess_pie_slice;
     float r = lazyjess_weight * M_SQRT2 * lazyjess_sin_vertex / sin(PI - theta_diff - lazyjess_vertex);
     
     if(modulus < r) {
       theta = atan2(y,x) + lazyjess_spin + TWO_PI;
       sina = sin(theta);
       cosa = cos(theta);
       x = lazyjess_weight * modulus * cosa;
       y = lazyjess_weight * modulus * sina;
       
       theta_diff = (theta + lazyjess_half_slice) % lazyjess_pie_slice;
       r = lazyjess_weight * M_SQRT2 * lazyjess_sin_vertex / sin(PI - theta_diff - lazyjess_vertex);
       modulus = sqrt(sq(x)+sq(y));
       
       if(modulus >= r) {
         theta = atan2(y,x) - lazyjess_spin + lazyjess_corner_rotation + TWO_PI;
         sina = sin(theta);
         cosa = cos(theta);
         x = lazyjess_weight * modulus * cosa;
         y = lazyjess_weight * modulus * sina;
       }
       
     } else {
       modulus = 1.0 + lazyjess_space / modulus;
       x = lazyjess_weight * modulus * x;
       y = lazyjess_weight * modulus * y;
     }
     
   }
   
   return new PVector(weight * x, weight * y);
 }

 PVector vibration2(PVector p, float weight) {
   float d_along_dir = p.x * cos(vibration2_dir) + p.y * sin(vibration2_dir);
   float dirL = vibration2_dir + modulate(vibration2_dm, vibration2_dmfreq, d_along_dir);
   float angleL = vibration2_angle + modulate(vibration2_tm, vibration2_tmfreq, d_along_dir);
   float freqL = modulate(vibration2_fm, vibration2_fmfreq, d_along_dir) / (vibration2_freq+1.0e-10);
   float ampL = vibration2_amp + vibration2_amp * modulate(vibration2_am, vibration2_amfreq, d_along_dir);

   float total_angle = angleL + dirL;
   float cos_dir = cos(dirL);
   float sin_dir = sin(dirL);
   float cos_tot = cos(total_angle);
   float sin_tot = sin(total_angle);
   float scaled_freq = vibration2_freq * TWO_PI;
   float phase_shift = TWO_PI * vibration2_phase / (vibration2_freq + 1.0e-10);
   d_along_dir = p.x * cos_dir + p.y * sin_dir;
   float local_amp = ampL * sin((d_along_dir * scaled_freq) + freqL + phase_shift);
   
   float x = p.x + local_amp * cos_tot;
   float y = p.y + local_amp * sin_tot;
   
   d_along_dir = p.x * cos(vibration2_dir2) + p.y * sin(vibration2_dir2);
   dirL = vibration2_dir2 + modulate(vibration2_d2m, vibration2_d2mfreq, d_along_dir);
   angleL = vibration2_angle2 + modulate(vibration2_t2m, vibration2_t2mfreq, d_along_dir);
   freqL = modulate(vibration2_f2m, vibration2_f2mfreq, d_along_dir) / (vibration2_freq2 + 1.0e-10);
   ampL = vibration2_amp2 + vibration2_amp2 * modulate(vibration2_a2m, vibration2_a2mfreq, d_along_dir);

   total_angle = angleL + dirL;
   cos_dir = cos(dirL);
   sin_dir = sin(dirL);
   cos_tot = cos(total_angle);
   sin_tot = sin(total_angle);
   scaled_freq = vibration2_freq2 * TWO_PI;
   phase_shift = TWO_PI* vibration2_phase2 / (vibration2_freq2 + 1.0e-10);
   d_along_dir = p.x * cos_dir + p.y * sin_dir;
   local_amp = ampL * sin((d_along_dir * scaled_freq) + freqL + phase_shift);

   x += local_amp * cos_tot;
   y += local_amp * sin_tot;

   return new PVector(weight * x, weight * y);
 }

 PVector layeredspiral(PVector p, float weight) {
   float r = p.x * layeredspiral_radius;
   float t = p.magSq();
   return new PVector(weight * r * cos(t), weight * r * sin(t));
 }

 final float c45 = cos(45.0);
 final float s45 = sin(45.0);
 
 PVector kaleidoscope(PVector p, float weight) {
   float xx = ((kaleidoscope_rotate * p.x) * c45 - p.y * s45 + kaleidoscope_lineup ) + kaleidoscope_x;
   float yy;
   if(p.y > 0.0)
     yy = (( kaleidoscope_rotate * p.y) * c45 + p.x * s45 + kaleidoscope_pull + kaleidoscope_lineup ) + kaleidoscope_y;
    else 
     yy = (( kaleidoscope_rotate * p.y) * c45 + p.x * s45 - kaleidoscope_pull - kaleidoscope_lineup ) ;
     
   return new PVector(weight * xx, weight * yy);  
 }

 PVector juliaq(PVector p, float weight) {
   float a = atan2(p.y,p.x) * juliaq_inv_power + random(1) * juliaq_inv_power_2pi;
   float sina = sin(a);
   float cosa = cos(a);
   float r = weight * pow(p.magSq(),juliaq_half_inv_power);
   return new PVector(r*cosa, r*sina);
 }

 PVector funnel2(PVector p, float weight) {
    float xx = tanh(p.x) * (1.0 / cos(p.x) + funnel2_effect * PI);
    float yy = tanh(p.y) * (1.0 / cos(p.y) + funnel2_effect * PI);
    
    return new PVector(weight * xx, weight * yy);
  }

  PVector funnel(PVector p, float weight) {
    float xx = tanh(p.x) * (1.0 / cos(p.y) + funnel_effect * PI);
    float yy = tanh(p.y) * (1.0 / cos(p.y) + funnel_effect * PI);
    
    return new PVector(weight * xx, weight * yy);
  }

  PVector ennepers(PVector p, float weight) {
    float xx = (p.x - ((sq(p.x) * p.x) / 3.0)) + p.x * sq(p.y);
    float yy = (p.y - ((sq(p.y) * p.y) / 3.0)) + p.y * sq(p.x);
    
    return new PVector(weight * xx, weight * yy);
  }

  PVector circlize2(PVector p, float weight) {
    float absx = abs(p.x);
    float absy = abs(p.y);
    float side, perimeter, r, sina, cosa;
    
    if(absx >= absy) {
       if(p.x >= absy) perimeter = absx+p.y;
       else perimeter = 5.0 * absx - p.y;
       side = absx;
    } else {
      if(p.y >= absx) perimeter = 3.0 * absy - p.x;
      else perimeter = 7.0 * absy + p.x;
      side = absy;
    }
    
    r = weight * (side + circlize2_hole);
    float a = QUARTER_PI * perimeter / side - QUARTER_PI;
    sina = sin(a);
    cosa = cos(a);
    
    return new PVector(r * sina, r * cosa);
  } 

  PVector bwrands(PVector p, float weight) {
    float vx = p.x;
    float vy = p.y;
    
    if(bwrands_cellsize == 0.0) return new PVector(weight * p.x,weight * p.y);
    
    int ix = floor( vx / bwrands_cellsize );
    int iy = floor( vy / bwrands_cellsize );
    float cx = (ix+0.5) * bwrands_cellsize;
    float cy = (iy+0.5) * bwrands_cellsize;
    
    int xx = ix ^ 0xb641;
    int yy = iy ^ 0x9d81;
    int xy = xx*yy + (int)bwrands_seed;
    xx &= 0xffff;
    yy &= 0xffff;
    xy &= 0xffff;

    int tt = bytemix(xx,yy);
    yy = bytemix(yy,xx);
    xx = tt;
    tt = byteshf(xx,yy);
    yy = byteshf(xy,yy);
    xx = tt;
    tt = bytexim(xx,yy);
    yy = bytexim(yy,xx);
    xx = tt;
    
    float ssz = (float)xx / 65535.0;
    ssz = bwrands_rmin + ssz * (1.0 - bwrands_rmin);
    float aan = bwrands_rrot * TWO_PI * (float)yy / 65536.0;

    tt = byteprimes(xx,yy);
    yy = byteprimes(yy,xx);
    xx = tt;

    float looniechance = - (float)xx/65536.0 + bwrands_loonie_chance;
    float petalschance = -1.0;
    if(looniechance < 0.0)  petalschance = looniechance + bwrands_petals_chance;
  
    float npetals = 1.0/3.0;
    if(bwrands_pety == 0) npetals = bwrands_petx;
    else npetals = bwrands_petx + (yy >> 3) % (1.0+bwrands_pety);

    if(looniechance <= petalschance) looniechance = -1.0;

    float lx = vx - cx;
    float ly = vy - cy;

    float vv2 = ssz * bwrands_r2;
    float l2 = sq(lx) + sq(ly);
    if( l2 > vv2) {
      return new PVector(weight * vx, weight * vy);
    }
    
    if(looniechance >0.0) {
      float r = vv2 / (l2+1.0e-10) - 1.0;
      r = sqrt(r);
      lx *= r;
      ly *= r;
      vv2 = 1.0; 
    } else if( petalschance > 0.0) {
      float flwr = npetals / TWO_PI * (PI + atan2(ly,lx));
      flwr = flwr - (int)flwr;
      flwr = abs(flwr - 0.5) * 2.0;
      float r = sqrt(l2);
      petalschance = random(1);
      if(petalschance < 0.5 * (flwr+0.5)) {
        lx *= (1.0-r) * (flwr*1.1);
        ly *= (1.0-r) * (flwr*1.1);
      } else {
        vv2 = sqrt(vv2);
        lx *= (vv2 - r * (1.0-flwr))/(r+1.0e-10);
        ly *= (vv2 - r * (1.0-flwr))/(r+1.0e-10);
      }
      vv2 = 1.0;
    } else {
      lx *= bwrands_g2 ;
      ly *= bwrands_g2 ;
      float r = bwrands_rfactor / ( (sq(lx)+sq(ly))/(4.0*ssz) + 1.0);
      lx *= r;
      ly *= r;
      vv2 = sqrt(ssz);
    }
    
    float r = vv2 * (sq(lx)+sq(ly)) / bwrands_r2;
    float theta = bwrands_inner_twist * (1.0-r) + bwrands_outer_twist * r;
    float s = sin(theta+aan);
    float c = cos(theta+aan);
    
    vx = cx + c * lx + s * ly;
    vy = cy - s * lx + c * ly;
    
    return new PVector(weight * vx, weight * vy);
  }

  PVector asteria(PVector p, float weight) {
    float x0 = weight * p.x;
    float y0 = weight * p.y;
    float xx = x0;
    float yy = y0;
    float r = sq(xx) + sq(yy);
    xx = sq(abs(xx)-1.0);
    yy = sq(abs(yy)-1.0);
    float r2 = sqrt(xx+yy);
    boolean in1 = r < 1.0;
    boolean out2 = r2 < 1.0;
    if(in1 && out2)
      in1 = (random(1)>0.35);
    else
      in1 = !in1;
    if(in1) {
      return new PVector(x0,y0);
    } else {
      xx = x0 * asteria_cosa - y0 * asteria_sina;
      yy = x0 * asteria_sina + y0 * asteria_cosa;
      float nx = xx / sqrt(1.0 - yy * yy) * (1.0 - sqrt(1.0 - sq(-abs(yy) + 1.0)));
      xx = nx * asteria_cosa + yy * asteria_sina;
      yy = -nx * asteria_sina + yy * asteria_cosa;
      return new PVector(xx,yy);
    }
  }

  PVector juliac(PVector p, float weight) {
    float re = 1.0 /(juliac_re + 1.0e-10);
    float im = juliac_im / 100.0;
    float arg = atan2(p.y,p.x) + (random(MAX_INT) % juliac_re) * TWO_PI;
    float lnmod = juliac_dist * 0.5 * log(p.magSq());
    float a = arg * re + lnmod * im;
    float mod2 = weight * exp(lnmod * re - arg * im);
    
    return new PVector(mod2 * cos(a), mod2 * sin(a));
  }

  PVector jacsn(PVector p, float weight) {
    Jacobi_elliptic_result jac_x = new Jacobi_elliptic_result();
    Jacobi_elliptic(p.x,jacsn_k,jac_x);
    Jacobi_elliptic_result jac_y = new Jacobi_elliptic_result();
    Jacobi_elliptic(p.y,1.0-jacsn_k,jac_y);
    
    float numx = jac_x.sn * jac_y.dn;
    float numy = jac_x.cn * jac_x.dn * jac_y.cn * jac_y.sn;
    float denom = sq(jac_x.sn) * sq(jac_y.sn) * jacsn_k + sq(jac_y.cn);
    denom = weight / (1.0e-10+denom);
    
    return new PVector(denom * numx, denom * numy);
  }

  PVector jacdn(PVector p, float weight) {
    Jacobi_elliptic_result jac_x = new Jacobi_elliptic_result();
    Jacobi_elliptic(p.x,jacdn_k,jac_x);
    Jacobi_elliptic_result jac_y = new Jacobi_elliptic_result();
    Jacobi_elliptic(p.y,1.0-jacdn_k,jac_y);
    
    float numx = jac_x.dn * jac_y.cn * jac_y.dn;
    float numy = -jac_x.cn * jac_x.sn * jac_y.sn * jacdn_k;
    float denom = sq(jac_x.sn) * sq(jac_y.sn) * jacdn_k + sq(jac_y.cn);
    denom = weight / (1.0e-10+denom);
    
    return new PVector(denom * numx, denom * numy);
  }

  PVector jaccn(PVector p, float weight) {
    Jacobi_elliptic_result jac_x = new Jacobi_elliptic_result();
    Jacobi_elliptic(p.x,jaccn_k,jac_x);
    Jacobi_elliptic_result jac_y = new Jacobi_elliptic_result();
    Jacobi_elliptic(p.y,1.0-jaccn_k,jac_y);
    
    float numx = jac_x.cn * jac_y.cn;
    float numy = -jac_x.dn * jac_x.sn * jac_y.dn * jac_y.sn;
    float denom = sq(jac_x.sn) * sq(jac_y.sn) * jaccn_k + sq(jac_y.cn);
    denom = weight / (1.0e-10+denom);
    
    return new PVector(denom * numx, denom * numy);
  }

  PVector hypertile(PVector p, float weight) {
    float a = p.x + hypertile_re;
    float b = p.y + hypertile_im;
    
    float c = hypertile_re * p.x - hypertile_im * p.y + 1.0;
    float d = hypertile_re * p.y + hypertile_im * p.x;
    
    float vr = weight / (sq(c) + sq(d));
    
    return new PVector(vr * (a*c+b*d), vr * (b*c-a*d));
  }

  PVector hypertile2(PVector p, float weight) {
    float a = p.x + hypertile2_r;
    float b = p.y;
    
    float c = hypertile2_r * p.x + 1.0;
    float d = hypertile2_r * p.y;
    
    float x = (a*c + b*d);
    float y = (b*c - a*d);
    
    float vr = weight / (sq(c) + sq(d));
    float rpa = hypertile2_pa * random(0,MAX_INT);
    float sina = sin(rpa);
    float cosa = cos(rpa);
    
    float xx = vr * (x * cosa + y * sina);
    float yy = vr * (y * cosa - x * sina);
    
    return new PVector(xx,yy);
  }

  PVector hypertile1(PVector p, float weight) {
    float rpa = random(0,MAX_INT) * hypertile1_pa;
    float sina = sin(rpa);
    float cosa = cos(rpa);
    float re = hypertile1_r * cosa;
    float im = hypertile1_r * sina;
    float a = p.x + re;
    float b = p.y - im;
    
    float c = re * p.x - im * p.y + 1;
    float d = re * p.y + im * p.x;
    
    float vr = weight / (sq(c) + sq(d));
    
    float x = vr * (a * c + b * d);
    float y = vr * (b * c - a * d);
    
    return new PVector(x,y);
  }

  PVector hexes(PVector p, float weight) {
    return hexes_obj.transform(p,weight);
  }

  PVector heartwf(PVector p, float weight) {
    float a = atan2(p.x,p.y);
    float r = p.mag();
    float nx,t;
    if(a < 0.0) {
      t = -a / PI * 60.0 * heartwf_scale_t_left - heartwf_shift_t;
      if(t>60.0) t=60.0;
      nx = -0.001 * (-t*t + 40.0 * t + 1200.0) * sin(PI * t/180.0) * r;
    } else {
      t = a / PI * 60.0 * heartwf_scale_t_right - heartwf_shift_t;
      if(t>60.0) t=60.0;
      nx = 0.001 * (-t*t + 40.0 * t + 1200.0) * sin(PI * t/180.0) * r;
    }
    float ny = -0.001 * (-t*t+40.0*t+400) * cos(PI * t/180.0) * r;
    nx *= heartwf_scale_x;
    return new PVector(weight * nx, weight * ny);
  }
  
  PVector glynnia(PVector p, float weight) {
    float r = p.mag();
    float d;
    if(r>1.0) {
      if(random(1)>0.5) {
        d = 1.0e-10 + sqrt(r + p.x);
        return new PVector(weight * HSQRT2 * d, -weight * HSQRT2 / d * p.y);
      } else {
        d = r + p.x;
        float dx = sqrt(r * (sq(p.y) + sq(d))) + 1.0e-10;
        r = weight / dx;
        return new PVector(r*d, r*p.y);
      }
    } else {
      if(random(1)>0.5) {
        d = 1.0e-10 + sqrt(r + p.x);
        return new PVector(-weight * HSQRT2 * d, -weight * HSQRT2 / d * p.y);
      } else {
        d = r + p.x;
        float dx = sqrt(r * (sq(p.y) + sq(d))) + 1.0e-10;
        r = weight / dx;
        return new PVector(-r*d, r*p.y);
      }
    }
  }

  final PVector glynnsim3_circle() {
    float phi = TWO_PI * random(1);
    float r;
    if(random(1) < glynnsim3_gamma)
      r = glynnsim3_radius1;
     else
      r = glynnsim3_radius2;
     return new PVector(r * cos(phi), r * sin(phi));
  }

  PVector glynnsim3(PVector p, float weight) {
    float r = p.mag();
    if(r < glynnsim3_radius1) {
      PVector toolpoint = glynnsim3_circle();
      toolpoint.mult(weight);
      return toolpoint;
    } else {
      float alpha = glynnsim3_radius / r;
      float x = p.x;
      float y = p.y;
      if(random(1) <= glynnsim2_contrast * pow(alpha, glynnsim3_abspow)) {
        float tmp = sq(alpha);
        x = tmp * p.x;
        y = tmp * p.y;
      }
      return new PVector(weight * x, weight * y);
    }
  }
 

  final PVector glynnsim2_circle() {
    float r = glynnsim2_radius + glynnsim2_thickness - glynnsim2_gamma * random(1);
    float phi = glynnsim2_phi10 + glynnsim2_delta * random(1);
    return new PVector(r * cos(phi), r * sin(phi));
  }

  PVector glynnsim2(PVector p, float weight) {
    float r = p.mag();
    if(r < glynnsim2_radius) {
      PVector toolpoint = glynnsim2_circle();
      toolpoint.mult(weight);
      return toolpoint;
    } else {
      float alpha = glynnsim2_radius / r;
      float x = p.x;
      float y = p.y;
      if(random(1) <= glynnsim2_contrast * pow(alpha, glynnsim2_abspow)) {
        float tmp = sq(alpha);
        x = tmp * p.x;
        y = tmp * p.y;
      }
      return new PVector(weight * x, weight * y);
    }
  }


  final PVector glynnsim1_circle() {
    float r = glynnsim1_radius1 * (glynnsim1_thickness + (1.0 - glynnsim1_thickness) * random(1));
    float phi = TWO_PI * random(1);
    return new PVector(r * cos(phi) + glynnsim1_x1, r * sin(phi) + glynnsim1_y1);
  }

  PVector glynnsim1(PVector p, float weight) {
    float r = p.mag();
    if(r < glynnsim1_radius) {
      PVector toolpoint = glynnsim1_circle();
      toolpoint.mult(weight);
      return toolpoint;
    } else {
      float alpha = glynnsim1_radius / r;
      float x = p.x;
      float y = p.y;
      if(random(1) <= glynnsim1_contrast * pow(alpha, glynnsim1_abspow)) {
        float tmp = sq(alpha);
        x = tmp * p.x;
        y = tmp * p.y;
      }
      float z = sq(x - glynnsim1_x1) + sq(y - glynnsim1_y1);
      if(z < sq(glynnsim1_radius1)) {
        PVector toolpoint = glynnsim1_circle();
        toolpoint.mult(weight);
        return toolpoint;
      } else {
        return new PVector(weight * x, weight * y);
      }
    }
  }

final float gdoffs_agdod = 0.1;
final float gdoffs_agdoa = 2.0;
final float gdoffs_agdoc = 1.0;

final float gdoffs_fclp(float a) {return ((a<0)?-(abs(a)%1.0):abs(a)%1.0);}
final float gdoffs_fscl(float a) {return gdoffs_fclp((a+1.0)/2.0);}
final float gdoffs_fosc(float p, float a) {return gdoffs_fscl(-cos(p*a*TWO_PI));}
final float gdoffs_flip(float a, float b, float c) {return (c*(b-a)+a);}

  PVector gdoffs(PVector p, float weight) {
    float osc_x = gdoffs_fosc(gdoffs_gdodx,1.0);
    float osc_y = gdoffs_fosc(gdoffs_gdody,1.0);
    float in_x = p.x + gdoffs_gdocx;
    float in_y = p.y + gdoffs_gdocy;
    float out_x, out_y;
    if(gdoffs_square != 0.0) {
      out_x = gdoffs_flip(gdoffs_flip(in_x,gdoffs_fosc(in_x,4),osc_x),gdoffs_fosc(gdoffs_fclp(gdoffs_gdob*in_x),4),osc_x);
      out_y = gdoffs_flip(gdoffs_flip(in_y,gdoffs_fosc(in_y,4),osc_x),gdoffs_fosc(gdoffs_fclp(gdoffs_gdob*in_y),4),osc_x);
    } else {
      out_x = gdoffs_flip(gdoffs_flip(in_x,gdoffs_fosc(in_x,4),osc_x),gdoffs_fosc(gdoffs_fclp(gdoffs_gdob*in_x),4),osc_x);
      out_y = gdoffs_flip(gdoffs_flip(in_y,gdoffs_fosc(in_y,4),osc_y),gdoffs_fosc(gdoffs_fclp(gdoffs_gdob*in_y),4),osc_y);
    }
    return new PVector(weight * out_x, weight * out_y);
  }

  PVector fourth(PVector p, float weight) {
    if(p.x >0.0 && p.y >0.0) {
      float a = atan2(p.y,p.x);
      float r = 1.0 / p.mag();
      return new PVector(weight * r * cos(a), weight * r * sin(a));
    } else if(p.x > 0.0 && p.y < 0.0) {
      float r2 = p.magSq();
      float r = weight;
      if(r2 < fourth_sqrvvar)
        r *= sqrt(fourth_sqrvvar / r2 - 1.0);
      return new PVector(r * p.x, r * p.y);
    } else if(p.x <0.0 && p.y > 0.0) {
      float x = p.x-fourth_x;
      float y = p.y-fourth_y;
      float r = sqrt(x*x+y*y);
      if(r< fourth_weight) {
        float a = atan2(y,x) + fourth_spin + fourth_twist * (fourth_weight - r);
        r *= weight;
        return new PVector(r * cos(a) + fourth_x, r * sin(a) - fourth_y);
      } else {
        r = weight * (1.0 + fourth_space / r);
        return new PVector( r * x + fourth_x, r * y - fourth_y);
      }
    } else {
      return new PVector(weight * p.x, weight * p.y);
    }
  }

  PVector flipy(PVector p, float weight) {
    float y = p.y;
    if(p.x>0.0) y=-y;
    return new PVector(weight * p.x, weight * y); 
  }

  PVector flipcircle(PVector p, float weight) {
    float y = p.y;
    if(p.magSq() <= sq(flipcircle_weight)) y=-y;
    return new PVector(weight * p.x, weight * y); 
  }

  PVector fibonacci2(PVector p, float weight) {
    float a = p.y * FNATLOG;
    float snum1 = sin(a);
    float cnum1 = cos(a);
    float b = -(p.x * PI + a);
    float snum2 = sin(b);
    float cnum2 = cos(b);
    float eradius1 = fibonacci2_sc * exp(fibonacci2_sc2 * (p.x * FNATLOG));
    float eradius2 = fibonacci2_sc * exp(fibonacci2_sc2 * ((p.x * FNATLOG - p.y * PI) * -1.0));
    float x = weight * (eradius1 * cnum1 - eradius2 * cnum2) * FFIVE;
    float y = weight * (eradius1 * snum1 - eradius2 * snum2) * FFIVE;
    return new PVector(x,y);
  }

  PVector epispiral(PVector p, float weight) {
    float theta = atan2(p.y,p.x);
    float t = epispiral_holes;
    float d = cos(epispiral_n * theta);
    if(d == 0) d = 1.0e-10;
    if(abs(epispiral_thickness) > 1.0e-10) {
      t+= (random(1) * epispiral_thickness) * (1.0/d);
    } else {
      t+= 1.0/d;
    }
    return new PVector(weight * t * cos(theta),weight * t * sin(theta));
  }

  PVector epispiralwf(PVector p, float weight) {
    float a = atan2(p.x,p.y);
    float d = cos(epispiralwf_waves * a);
    if(d == 0.0) d = 1.0e-10;
    float r = 0.5 / d;
    return new PVector(weight * r * sin(a),weight * r * cos(a));
  }

  PVector eclipse(PVector p, float weight) {
    float xx=p.x;
    float yy=p.y;
    if (abs(p.y) <= eclipse_weight) {
      float c_2 = sqrt(sq(eclipse_weight) - sq(p.y));

      if (abs(p.x) <= c_2) {
        float x = p.x + eclipse_shift * eclipse_weight;
        if (abs(x) >= c_2)
          xx = -eclipse_weight * p.x;
        else
          xx = eclipse_weight * x;
      } 
    } 
    
    return new PVector(weight * xx,weight * yy);
  }

  PVector eswirl(PVector p, float weight) {
    float tmp = p.magSq() + 1.0;
    float tmp2 = 2.0 * p.x;
    float xmax = (safesqrt(tmp+tmp2) + safesqrt(tmp-tmp2))*0.5;
    if(xmax<1.0) xmax = 1.0;
    float mu = acosh(xmax);
    float t = p.x / xmax;
    if(t>1.0) t = 1.0;
     else if(t<-1.0) t = -1.0;
    float nu = acos(t);
    if(p.y<0.0) nu *= -1.0;
    nu = nu + mu * eswirl_out + eswirl_in / mu;
    return new PVector(weight * cosh(mu) * cos(nu), weight * sinh(mu) * sin(nu));
  }
  
  PVector escale(PVector p, float weight) {
    float tmp = p.magSq() + 1.0;
    float tmp2 = 2.0 * p.x;
    float xmax = (safesqrt(tmp+tmp2) + safesqrt(tmp-tmp2))*0.5;
    if(xmax<1.0) xmax = 1.0;
    float mu = acosh(xmax);
    float t = p.x / xmax;
    if(t>1.0) t = 1.0;
     else if(t<-1.0) t = -1.0;
    float nu = acos(t);
    if(p.y<0.0) nu *= -1.0;
    mu *= escale_scale;
    nu = ((escale_scale * (nu + PI + escale_angle)) % (TWO_PI * escale_scale) - escale_angle - escale_scale * PI) % TWO_PI;
    if(nu > PI) nu -= TWO_PI;
    if(nu < -PI) nu += TWO_PI;
    return new PVector(weight * cosh(mu) * cos(nu), weight * sinh(mu) * sin(nu));
  }
  
  PVector erotate(PVector p, float weight) {
    float tmp = p.magSq()+1.0;
    float tmp2 = 2.0 * p.x;
    float xmax = (safesqrt(tmp + tmp2) + safesqrt(tmp-tmp2))*0.5;
    if(xmax < 1.0) xmax = 1.0;
    float t = p.x/xmax;
    if(t>1.0) t = 1.0;
     else if(t<-1.0) t = -1.0;
    float nu = acos(t);
    if(p.y<0.0) nu *= -1.0;
    nu = (nu + erotate_rotate + PI) % TWO_PI - PI;
    float x = weight * xmax * cos(nu);
    float y = sqrt(xmax - 1.0) * sqrt(xmax + 1.0) * sin(nu);
    return new PVector(x,y);
  }
  
  PVector epush(PVector p, float weight) {
    float tmp = p.magSq() + 1.0;
    float tmp2 = 2.0 * p.x;
    float xmax = (safesqrt(tmp+tmp2) + safesqrt(tmp-tmp2))*0.5;
    if(xmax<1.0) xmax = 1.0;
    float mu = acosh(xmax);
    float t = p.x / xmax;
    if(t>1.0) t = 1.0;
     else if(t<-1.0) t = -1.0;
    float nu = acos(t);
    if(p.y<0.0) nu *= -1.0;
    nu += epush_rotate;
    mu *= epush_dist;
    mu += epush_push;
    return new PVector(weight * cosh(mu) * cos(nu), weight * sinh(mu) * sin(nu));
  }
  
  PVector emotion(PVector p, float weight) {
    float tmp = p.magSq() + 1.0;
    float tmp2 = 2.0 * p.x;
    float xmax = (safesqrt(tmp+tmp2) + safesqrt(tmp-tmp2))*0.5;
    if(xmax<1.0) xmax = 1.0;
    float mu = acosh(xmax);
    float t = p.x / xmax;
    if(t>1.0) t = 1.0;
     else if(t<-1.0) t = -1.0;
    float nu = acos(t);
    if(p.y<0.0) nu *= -1.0;
    if(nu < 0.0) mu += emotion_move;
    else mu -= emotion_move;
    if(mu <= 0.0) {
      mu *= -1.0;
      nu *= -1.0;
    }
    nu += emotion_rotate;
    return new PVector(weight * cosh(mu) * cos(nu), weight * sinh(mu) * sin(nu));
  }
  
  PVector emod(PVector p, float weight) {
    float tmp = p.magSq() + 1.0;
    float tmp2 = 2.0 * p.x;
    float xmax = (safesqrt(tmp+tmp2) + safesqrt(tmp-tmp2))*0.5;
    if(xmax<1.0) xmax = 1.0;
    float mu = acosh(xmax);
    float t = p.x / xmax;
    if(t>1.0) t = 1.0;
     else if(t<-1.0) t = -1.0;
    float nu = acos(t);
    if(p.y<0.0) nu *= -1.0;
    if( (mu < emod_radius) && (-mu < emod_radius)) {
      if(nu > 0.0)
        mu = (mu+emod_radius+emod_distance*emod_radius) % (2.0 * emod_radius) - emod_radius;
       else
        mu = (mu-emod_radius-emod_distance*emod_radius) % (2.0 * emod_radius) + emod_radius;
    }
    return new PVector(weight * cosh(mu) * cos(nu), weight * sinh(mu) * sin(nu));
  }
  
  PVector ejulia(PVector p, float weight) {
    float r2 = p.magSq();
    float x;
    if(ejulia_power >= 0) x = p.x;
    else {
      r2 = 1.0/r2;
      x = p.x * r2;
    }
    float tmp = r2 + 1.0;
    float tmp2 = 2.0 * x;
    float xmax = 0.5 * (safesqrt(tmp+tmp2) + safesqrt(tmp-tmp2));
    if(xmax<1.0) xmax = 1.0;
    float mu = acosh(xmax);
    float t = x / xmax;
    if(t>1.0) t = 1.0;
     else if(t<-1.0) t = -1.0;
    float nu = acos(t);
    if(p.y<0.0) nu *= -1.0;
    nu = nu / ejulia_power + TWO_PI / ejulia_power * floor(random(1) * ejulia_power);
    mu /= ejulia_power;
    return new PVector(weight * 2.0 * cosh(mu) * cos(nu), weight * 2.0 * sinh(mu) * sin(nu));
  }

  PVector ecollide(PVector p, float weight) {
    float tmp = p.magSq()+1.0;
    float tmp2 = 2.0 * p.x;
    float xmax = (safesqrt(tmp + tmp2) + safesqrt(tmp-tmp2))*0.5;
    if(xmax < 1.0) xmax = 1.0;
    float t = p.x/xmax;
    if(t>1.0) t = 1.0;
     else if(t<-1.0) t = -1.0;
    float nu = acos(t);
    int alt = (int)(nu * ecollide_ecn_pi);
    if(alt%2 ==0)
        nu = alt * ecollide_pi_ecn + (nu + ecollide_eca_ecn) % ecollide_pi_ecn;
      else
        nu = alt * ecollide_pi_ecn + (nu - ecollide_eca_ecn) % ecollide_pi_ecn;
    if(p.y<0.0) nu *= -1.0;
    float x = weight * xmax * cos(nu);
    float y = sqrt(xmax - 1.0) * sqrt(xmax + 1.0) * sin(nu);
    return new PVector(x,y);
  }

  PVector dlawf(PVector p, float weight) {
    return dlawf_obj.transform(p,weight);
  }

  PVector dcperlin(PVector p, float weight) {
    int t=0;
    float Vx = p.x;
    float Vy = p.y;
    PVector V = new PVector(p.x,p.y);
    float r, theta, s,c,pn,e;
    
    noiseDetail((int)dcperlin_octaves,dcperlin_freqs);
    do {
      e = 0.0;
      switch((int)dcperlin_shape) {
        case 0: 
         // Vx = (1.0 + dcperlin_edge) * (random(0,1) - 0.5);
         // Vy = (1.0 + dcperlin_edge) * (random(0,1) - 0.5);
          r = sq(Vx) > sq(Vy) ? abs(Vx) : abs(Vy);
          if (r > (1.0 - dcperlin_edge)) {
            e = 0.5 * (r - 1.0 + dcperlin_edge) / dcperlin_edge;
          }
          break;
        case 1:
          r = random(0,1) + random(0,1);
          r = (r > 1.0) ? 2.0 - r : r;
          r *= (1.0 + dcperlin_edge);
          if (r > 1.0 - dcperlin_edge) {
            e = 0.5 * (r - 1.0 + dcperlin_edge) / dcperlin_edge;
          }
          //theta = random(0,TWO_PI);
          theta = atan2(p.x,p.y);
          s = sin(theta);
          c = cos(theta);
          Vx = 0.5 * r * s;
          Vy = 0.5 * r * c;
          break;
        case 2:
          r = (1.0 + dcperlin_edge) * random(0,1);
          if (r > 1.0 - dcperlin_edge) {
            e = 0.5 * (r - 1.0 + dcperlin_edge) / dcperlin_edge;
          }
          //theta = random(0,TWO_PI);
          theta = atan2(p.x,p.y);
          s = sin(theta);
          c = cos(theta);
          Vx = 0.5 * r * s;
          Vy = 0.5 * r * c;
          break;  
      }
      
      switch((int)dcperlin_map) {
        case 0:
          V = new PVector(dcperlin_scale * Vx, dcperlin_scale * Vy, dcperlin_scale * dcperlin_z);
          break;

        case 1:
          r = 1.0 / (sq(Vx) + sq(Vy) + 1.0e-10);
          V = new PVector(dcperlin_scale * Vx * r, dcperlin_scale * Vy * r, dcperlin_scale * dcperlin_z);
          break;

        case 2:
          r = 1.0 / (sq(Vx) + sq(Vy) + 0.5);
          V = new PVector(dcperlin_scale * Vx * r, dcperlin_scale * Vy * r, dcperlin_scale * dcperlin_z);
          break;

        case 3:
          r = 1.0 / (sq(Vx) + sq(Vy) + 0.25);
          V = new PVector(dcperlin_scale * Vx * r, dcperlin_scale * Vy * r, dcperlin_scale * dcperlin_z);
          break;

        case 4:
          r = 0.25 - (Vx * Vx + Vy * Vy);
          if (r < 0.0) {
            r = sqrt(-r);
          }
          else {
            r = sqrt(r);
          }
          V = new PVector(dcperlin_scale * Vx, dcperlin_scale * Vy, dcperlin_scale * (r+dcperlin_z));
          break;

        case 5:
          r = 0.25 - (Vx * Vx + Vy * Vy);
          if (r < 0.0) {
            r = sqrt(-r);
          }
          else {
            r = sqrt(r);
          }
          V = new PVector(dcperlin_scale * Vx, dcperlin_scale * Vy, dcperlin_scale * (2*r+dcperlin_z));
          break;
      }
      
      pn = noise(V.x, V.y, V.z)*2.0-1.0;
      
      if (pn > 0.0) {
        e = pn * (1.0 + e * e * 20.0) + 2.0 * e;
      }
      else {
        e = pn * (1.0 + e * e * 20.0) - 2.0 * e;
      }
      
    } while( (e<dcperlin_notch_bottom || e > dcperlin_notch_top) && t++ < dcperlin_select_bailout);
    
    if( abs(pn+dcperlin_centre) < dcperlin_range)    
      return new PVector(weight * 3.0 * Vx, weight * 3.0 * Vy);
     else
      return new PVector(p.x,p.y);
  }

  PVector crop(PVector p, float weight) {
    if((p.x < crop_left || p.x > crop_right || p.y < crop_top || p.y > crop_bottom) && (crop_zero == 1.0)) {
      return new PVector(0,0);
    } else {
      float x=p.x,y=p.y;
      if(p.x<crop_left) x = crop_left + random(0,1) * crop_w;
      else if(p.x>crop_right) x = crop_right - random(0,1) * crop_w;
      if(p.y<crop_top) y = crop_top + random(0,1) * crop_h;
      else if(p.y>crop_bottom) y = crop_bottom - random(0,1) * crop_h;
      
      return new PVector(weight * x, weight * y);
    }
  }

  PVector crackle(PVector p, float weight) {
     return crackle_obj.transform(p,weight);
  }

  PVector collideoscope(PVector p, float weight) {
    float a = atan2(p.y,p.x);
    float r = p.mag();
    int alt;
    if(a >= 0.0) {
      alt = (int)(a * collideoscope_kn_pi);
      if(alt % 2 == 0)
        a = alt * collideoscope_pi_kn + (collideoscope_ka_kn + a) % collideoscope_pi_kn;
       else
        a = alt * collideoscope_pi_kn + (-collideoscope_ka_kn + a) % collideoscope_pi_kn;
    } else {
      alt = (int)(-a * collideoscope_kn_pi);
      if(alt % 2 == 1)
        a = -(alt * collideoscope_pi_kn + (-collideoscope_ka_kn - a) % collideoscope_pi_kn);
       else
        a = -(alt * collideoscope_pi_kn + (collideoscope_ka_kn - a) % collideoscope_pi_kn);
    }
    
    return new PVector(weight * r * cos(a), weight * r * sin(a));
  }
    
  PVector cloverleaf(PVector p, float weight) {
    float a = atan2(p.x,p.y);
    float r = 3.0 * (sin(2*a) + 0.25 * sin(6*a));
    if(cloverleaf_filled == 1.0) r *= random(0,1);
    return new PVector(weight * r * sin(a), weight * r * cos(a));
  }

  PVector circlize(PVector p, float weight) {
    float absx = abs(p.x);
    float absy = abs(p.y);
    float perimeter, side;
    if(absx >= absy) {
     if(p.x >= absy)
      perimeter = absx + p.y; 
     else
      perimeter = 5.0 * absx - p.y;
     side = absx; 
    } else {
      if(p.y >= absx)
       perimeter = 3.0 * absy - p.x;
      else
       perimeter = 7.0 * absy + p.x;
      side = absy;
    }
    
    float r = side / QUARTER_PI + circlize_hole;
    float a = QUARTER_PI * perimeter / side - QUARTER_PI;
    return new PVector(weight * r * cos(a), weight * r * sin(a));
  }

  PVector circlecrop(PVector p, float weight) {
    float x = p.x - circlecrop_x;
    float y = p.y - circlecrop_y;
    float ang = atan2(y,x);
    float rad = sqrt(sq(x)+sq(y));
    float rdc = circlecrop_radius + (random(0,1) * 0.5 * circlecrop_scatterarea);
    boolean esc = rad > circlecrop_radius;
    boolean cr0 = circlecrop_zero == 1.0;
    
    if (cr0 && esc) {
      return new PVector(weight*x,weight*y);
    }
    else if (cr0 && !esc) {
      return new PVector(weight * p.x, weight * p.y);
    }
    else if (!cr0 && esc) {
      return new PVector(weight * rdc * cos(ang) + circlecrop_x,
                 weight * rdc * sin(ang) + circlecrop_y);
    }
    else if (!cr0 && !esc) {
      return new PVector(weight * p.x, weight * p.y);
    }
    return new PVector(weight * p.x, weight * p.y);
  }

  PVector circleblur(PVector p, float weight) {
    float rad = sqrt(random(0,2));
    float a = random(0,1) * TWO_PI;
    return new PVector(weight * cos(a) * rad, weight * sin(a) * rad);
  }

  PVector checks(PVector p, float weight) {
    int isxy = (int)round(p.x * checks_cs) + (int)round(p.y * checks_cs);
    float rnx = checks_rnd * random(0,1);
    float rny = checks_rnd * random(0,1);
    float dx, dy;
    if(isxy % 2 == 0) {
      dx = -checks_x + rnx;
      dy = -checks_y;
    } else {
      dx = checks_x;
      dy = checks_y + rny;
    }
    return new PVector(weight * (p.x + dx), weight * (p.y + dy));
  }

  PVector cannabiscurvewf(PVector p, float weight) {
    float a = atan2(p.x, p.y);
    float r = (1.0 + 9.0 / 10.0 * cos(8.0 * a)) * (1.0 + 1.0 / 10.0 * cos(24.0 * a)) * (9.0 / 10.0 + 1.0 / 10.0 * cos(200.0 * a)) * (1.0 + sin(a));    
    
    if(cannabiscurvewf_filled == 1.0) r *= random(0,1);
    return new PVector(weight * cos(a) * r, -weight * sin(a) * r+2.0);
  }

  PVector boarders2(PVector p, float weight) {
    float roundx = round(p.x);
    float roundy = round(p.y);
    float offsetx = p.x - roundx;
    float offsety = p.y - roundy;
    float x,y;
    if(random(0,1) >= boarders2_cr) {
      x = offsetx * boarders2_c + roundx;
      y = offsety * boarders2_c + roundy;
    } else {
      if(abs(offsetx) >= abs(offsety)) {
        if(offsetx >= 0.0) {
          x = offsetx * boarders2_c + roundx + boarders2_cl;
          y = offsety * boarders2_c + roundy + boarders2_cl * offsety/offsetx;
        } else {
          x = offsetx * boarders2_c + roundx - boarders2_cl;
          y = offsety * boarders2_c + roundy - boarders2_cl * offsety/offsetx;
        }
      } else {
        if(offsety >= 0.0) {
          y = offsety * boarders2_c + roundy + boarders2_cl;
          x = offsetx * boarders2_c + roundx + offsetx/offsety * boarders2_cl;
        } else {
          y = offsety * boarders2_c + roundy - boarders2_cl;
          x = offsetx * boarders2_c + roundx - offsetx/offsety * boarders2_cl;
        }
      }
    }
    
    return new PVector(weight * x, weight * y);
   }

  PVector blurzoom(PVector p, float weight) {
    float z = 1.0 + blurzoom_length * random(0,1);
    float x = weight * ((p.x - blurzoom_x) * z + blurzoom_x);   
    float y = weight * ((p.y - blurzoom_y) * z + blurzoom_y);
    return new PVector(x,y);
  }

  PVector blocky(PVector p, float weight) {
    float r = weight / ((cos(p.x) + cos(p.y)) / blocky_mp + 1.0);
    float tmp = sq(p.y) + sq(p.x) + 1.0;
    float x2 = 2.0 * p.x;
    float y2 = 2.0 * p.y;
    float xmax = 0.5 * (sqrt(tmp + x2) + sqrt(tmp - x2));
    float ymax = 0.5 * (sqrt(tmp + y2) + sqrt(tmp - y2));
    float a = p.x / xmax;
    float b = safesqrt(1.0 - sq(a));
    float x = blocky_weight * r*atan2(a,b)*blocky_x / HALF_PI;
    a = p.y / ymax;
    b = safesqrt(1.0 - sq(a));
    float y = blocky_weight * r * atan2(a,b)*blocky_y / HALF_PI;
    
    return new PVector(3.0*x,3.0*y);
  }

  PVector bilinear(PVector p, float weight) {
    return new PVector(weight * p.y, weight * p.x);
  }

  PVector barycentroid(PVector p, float weight) {
    float barycentroid_dot02 = barycentroid_a * p.x + barycentroid_b * p.y;
    float barycentroid_dot12 = barycentroid_c * p.x + barycentroid_d * p.y;
    
    float u = (barycentroid_dot11 * barycentroid_dot02 - barycentroid_dot01 * barycentroid_dot12) * barycentroid_invdenom;
    float v = (barycentroid_dot00 * barycentroid_dot12 - barycentroid_dot01 * barycentroid_dot02) * barycentroid_invdenom;
    
    float um = sqrt(sq(u) + sq(p.x)) * sgn(u);
    float vm = sqrt(sq(v) + sq(p.y)) * sgn(v);
    
    return new PVector(weight * um, weight * vm);
  }

  PVector bwraps7(PVector p, float weight) {
    if(abs(bwraps7_cellsize) < 1e-10) 
      return new PVector(weight * p.x, weight * p.y);
     
    float cx = (floor(p.x / bwraps7_cellsize) + 0.5) * bwraps7_cellsize;
    float cy = (floor(p.y / bwraps7_cellsize) + 0.5) * bwraps7_cellsize;
    float lx = p.x - cx;
    float ly = p.y - cy;
    if( (sq(lx) + sq(ly)) > bwraps7_r2)
        return new PVector(weight * p.x, weight * p.y);
    
    lx *= bwraps7_g2;
    ly *= bwraps7_g2;
    float r = bwraps7_rfactor / ((sq(lx) + sq(ly))/ 4.0 + 1.0);
    lx *= r;
    ly *= r;
    
    r = (sq(lx) + sq(ly)) / bwraps7_r2;
    float theta = bwraps7_inner_twist * (1.0 - r) + bwraps7_outer_twist * r;
    float s = sin(theta);
    float c = cos(theta);
    
    float x = cx + c * lx + s * ly;
    float y = cy - s * lx + c * ly;
    
    return new PVector(weight * x, weight * y);
  }

  PVector btransform(PVector p, float weight) {
    float tau = 0.5 * (log(sq(p.x+1.0) + sq(p.y)) - log(sq(p.x - 1.0) + sq(p.y))) / btransform_power + btransform_move;
    float sigma = PI - atan2(p.y, p.x+1.0) - atan2(p.y, 1.0 - p.x) + btransform_rotate;
    sigma = sigma / btransform_power + TWO_PI / btransform_power * floor(random(0,1) * btransform_power);
    if(p.x >= 0.0)
      tau += btransform_split;
     else
      tau -= btransform_split;
    float temp = cosh(tau) - cos(sigma);  
    return new PVector(weight * sinh(tau) / temp, weight * sin(sigma) / temp);
  }

  PVector bswirl(PVector p, float weight) {
    float tau = 0.5 * (log(sq(p.x+1.0) + sq(p.y)) - log(sq(p.x - 1.0) + sq(p.y)));
    float sigma = PI - atan2(p.y, p.x+1.0) - atan2(p.y, 1.0 - p.x);
    sigma = sigma + tau * bswirl_out + bswirl_in / tau;
    float temp = cosh(tau) - cos(sigma);  
    return new PVector(weight * sinh(tau) / temp, weight * sin(sigma) / temp);
  }

  PVector bmod(PVector p, float weight) {
    float tau = 0.5 * (log(sq(p.x+1.0) + sq(p.y)) - log(sq(p.x - 1.0) + sq(p.y)));
    float sigma = PI - atan2(p.y, p.x+1.0) - atan2(p.y, 1.0 - p.x);
    if(tau < bmod_radius && -tau < bmod_radius)
      tau = (tau + bmod_radius + bmod_distance * bmod_radius) % (2.0 * bmod_radius) - bmod_radius;
    float temp = cosh(tau) - cos(sigma);  
    return new PVector(weight * sinh(tau) / temp, weight * sin(sigma) / temp);
  }

  PVector bcollide(PVector p, float weight) {
    float tau = 0.5 * (log(sq(p.x+1.0) + sq(p.y)) - log(sq(p.x - 1.0) + sq(p.y)));
    float sigma = PI - atan2(p.y, p.x+1.0) - atan2(p.y, 1.0 - p.x);
    int alt = (int)(sigma * bcollide_bcn_pi);
    if(alt % 2 == 0)
      sigma = alt * bcollide_pi_bcn + (sigma + bcollide_bca_bcn) % bcollide_pi_bcn;
     else
      sigma = alt * bcollide_pi_bcn + (sigma - bcollide_bca_bcn) % bcollide_pi_bcn;
    float temp = cosh(tau) - cos(sigma);  
    return new PVector(weight * sinh(tau) / temp, weight * sin(sigma) / temp);
  }


  PVector vlog(PVector p, float weight) {
    return new PVector(weight * 0.5 * log(sq(p.x)+sq(p.y)), weight * atan2(p.y,p.x));
  }

  PVector vsin(PVector p, float weight) {
    return new PVector(weight * sin(p.x) * cosh(p.y), weight * cos(p.x) * sinh(p.y));
  }
  
  PVector vcos(PVector p, float weight) {
    return new PVector(weight * cos(p.x) * cosh(p.y), -weight * sin(p.x) * sinh(p.y));
  } 

  PVector vtan(PVector p, float weight) {
    float d = weight / (1.0e-10 + cos(2.0*p.x) + cosh(2.0*p.y));
    return new PVector(d * sin(2.0 * p.x), d * sinh(2.0 * p.y));
  }
 
  PVector sec(PVector p, float weight) {
    float d = weight * 2.0 / (1.0e-10 + cos(2.0*p.x) + cosh(2.0*p.y));
    return new PVector(d * cos(p.x) * cosh(p.y), d * sin(p.x) * sinh(p.y));
  }

  PVector csc(PVector p, float weight) {
    float d = weight * 2.0 / (1.0e-10 + cosh(2.0*p.y) - cos(2.0*p.x));
    return new PVector(d * sin(p.x) * cosh(p.y), -d * cos(p.x) * sinh(p.y));
  }

   PVector cot(PVector p, float weight) {
    float d = weight / (1.0e-10 + cosh(2.0*p.y) - cos(2.0 * p.x));
    return new PVector(d * sin(2.0 * p.x), -d * sinh(2.0 * p.y));
  }  
  
  PVector vsinh(PVector p, float weight) {
    return new PVector(weight * sinh(p.x) * cos(p.y), weight * cosh(p.x) * sin(p.y));
  }
  
  PVector vcosh(PVector p, float weight) {
    return new PVector(weight * cosh(p.x) * cos(p.y), weight * sinh(p.x) * sin(p.y));
  } 

  PVector vtanh(PVector p, float weight) {
    float d = weight / (1.0e-10 + cos(2.0*p.y) + cosh(2.0*p.x));
    return new PVector(d * sinh(2.0 * p.x), d * sin(2.0 * p.y));
  }
  
  PVector sech(PVector p, float weight) {
    float d = weight * 2.0 / (1.0e-10 + cos(2.0*p.y) + cosh(2.0*p.x));
    return new PVector(d * cos(p.y) * cosh(p.x), -d * sin(p.y) * sinh(p.x));
  }

  PVector csch(PVector p, float weight) {
    float d = weight * 2.0 / (1.0e-10 + cosh(2.0*p.x) - cos(2.0*p.y));
    return new PVector(d * sinh(p.x) * cos(p.y), -d * cosh(p.x) * sin(p.y));
  }

   PVector coth(PVector p, float weight) {
    float d = weight / (1.0e-10 + cosh(2.0*p.x) - cos(2.0 * p.y));
    return new PVector(d * sinh(2.0 * p.x), d * sin(2.0 * p.y));
  } 

  PVector waves2(PVector p, float weight) {
    float x = weight * (p.x + waves2_scalex * sin(p.y * waves2_freqx));
    float y = weight * (p.y + waves2_scaley * sin(p.x * waves2_freqy));
    return new PVector(x,y);
  }
  
  PVector auger(PVector p, float weight) {
    float s = sin(auger_freq * p.x);
    float t = sin(auger_freq * p.y);
    float dy = p.y + auger_weight * (auger_scale * s * 0.5 + abs(p.y) * s);
    float dx = p.x + auger_weight * (auger_scale * t * 0.5 + abs(p.x) * t);
    float x = weight * (p.x + auger_sym * (dx - p.x));
    return new PVector(x,weight * dy);
  }

  PVector flux(PVector p, float weight) {
    float xpw = p.x + flux_weight;
    float xmw = p.x - flux_weight;
    float avgr = weight * (2+flux_spread) * sqrt(sqrt(sq(p.y) + sq(xpw)) / (1.0e-10+sqrt(sq(p.y) + sq(xmw))));
    float avga = (atan2(p.y,xmw) - atan2(p.y,xpw))*0.5;
    
    return new PVector(avgr * cos(avga)-(2+flux_spread), avgr * sin(avga));
  }

  PVector mobius(PVector p, float weight) {
    float re_u = mobius_re_a * p.x - mobius_im_a * p.y + mobius_re_b;
    float im_u = mobius_re_a * p.y + mobius_im_a * p.x + mobius_re_b;
    float re_v = mobius_re_c * p.x - mobius_im_c * p.y + mobius_re_d;
    float im_v = mobius_re_c * p.y + mobius_im_c * p.x + mobius_re_d;
    
    float d = (sq(re_v) + sq(im_v)) + 1.0e-10;
    float rad_v = weight / d;
    float x = rad_v * (re_u * re_v + im_u * im_v);
    float y = rad_v * (im_u * re_v - re_u * im_v);
    return new PVector(x,y);
  }

  PVector whorl(PVector p, float weight) {
    float r = p.mag();
    float a;
    if(r<whorl_weight)
      a = atan2(p.y,p.x) + whorl_inside / (whorl_weight - r);
     else
      a = atan2(p.y,p.x) + whorl_outside / (whorl_weight - r);
    return new PVector(weight * r * cos(a), weight * r * sin(a));  
  }

  PVector wedge(PVector p, float weight) {
    float r = p.mag();
    float a = atan2(p.y,p.x)+wedge_swirl * r;
    float c = floor((wedge_count * a + PI) / PI * 0.5);
    float comp_fac = 1.0 - wedge_angle * wedge_count / PI * 0.5;
    a = a * comp_fac + c * wedge_angle;
    r = weight * (r+wedge_hole);
    return new PVector(r * cos(a), r * sin(a));
  }

  PVector wedgesph(PVector p, float weight) {
    float r = 1.0 / (p.mag()+1.0e-10);
    float a = atan2(p.y,p.x)+wedgesph_swirl * r;
    float c = floor((wedge_count * a + PI) /PI * 0.5);
    float comp_fac = 1.0 - wedge_angle * wedge_count / PI * 0.5;
    a = a * comp_fac + c * wedge_angle;
    r = weight * (r+wedge_hole);
    return new PVector(r * cos(a), r * sin(a));
  }
  
  PVector stripes(PVector p, float weight) {
    float roundx = floor(p.x+0.5);
    float offsetx = p.x-roundx;
    float x = weight * (offsetx * (1.0-stripes_space) + roundx);
    float y = weight * (p.y + sq(offsetx) * stripes_warp);
    return new PVector(x,y); 
  }
  
  PVector split(PVector p, float weight) {
    float x,y;
    if(cos(p.x*split_xsize * PI) >= 0)
      y = weight * p.y;
     else
      y = -weight * p.y;
    if(cos(p.y*split_ysize * PI) >= 0)
      x = weight * p.x;
     else
      x = -weight * p.x;
    return new PVector(x,y);  
  }  

  PVector splits(PVector p, float weight) {
    float x,y;
    if(p.x>= 0)
      x = weight * (p.x + splits_x);
     else
      x = weight * (p.x - splits_x);
    if(p.y>= 0)
      y = weight * (p.y + splits_y);
     else
      y = weight * (p.y - splits_y);
    return new PVector(x,y);  
  }
  
  PVector separation(PVector p, float weight) {
    float x,y;
    if(p.x>0)
      x = weight * (sqrt(sq(p.x)+separation_x2) - p.x*separation_xinside);
     else
      x = -weight * (sqrt(sq(p.x)+separation_x2) + p.x*separation_xinside);
    if(p.y>0)
      y = weight * (sqrt(sq(p.y)+separation_y2) - p.y*separation_yinside);
     else
      y = -weight * (sqrt(sq(p.y)+separation_y2) + p.y*separation_yinside);  
     return new PVector(x,y); 
  }
  
  PVector popcorn2(PVector p, float weight) {
    float x = weight * (p.x + popcorn2_x * sin(tan(p.y * popcorn2_c)));
    float y = weight * (p.y + popcorn2_y * sin(tan(p.x * popcorn2_c)));
    return new PVector(x,y);
  }
  
  PVector oscilloscope(PVector p, float weight) {
    float t;
    if(oscilloscope_damping < 0.1)
      t = oscilloscope_amplitude * cos(oscilloscope_frequency * p.x) + oscilloscope_separation;
     else
      t = oscilloscope_amplitude * exp(-abs(p.x) * oscilloscope_damping) * cos(oscilloscope_frequency * p.x) + oscilloscope_separation;
     
     if(abs(p.y) <= t)
       return new PVector(weight*p.x, weight*-p.y);
     else
       return new PVector(weight*p.x, weight*p.y); 
  }
  
  PVector modulus(PVector p, float weight) {
    float x,y;
    if(p.x > modulus_x) {
      x = weight * (-modulus_x + (p.x+modulus_x) % (2 * modulus_x));
    } else if (p.x < -modulus_x) {
      x = weight * (modulus_x - (modulus_x - p.x) % (2 * modulus_x));
    } else x = weight * p.x;
    
    if(p.y > modulus_y) {
      y = weight * (-modulus_y + (p.y+modulus_y) % (2 * modulus_y));
    } else if (p.y < -modulus_y) {
      y = weight * (modulus_y - (modulus_y - p.y) % (2 * modulus_y));
    } else y = weight * p.y;
    
    return new PVector(x,y);
  }
  
  PVector lazysuzan(PVector p, float weight) {
    float xx = p.x - lazysuzan_x;
    float yy = p.y - lazysuzan_y;
    float rr = sqrt(sq(xx)+sq(yy));
    
    if(rr < lazysuzan_weight) {
      float a = atan2(yy,xx) + lazysuzan_spin + lazysuzan_twist * (lazysuzan_weight - rr);
      rr = weight * rr;
      return new PVector(rr * cos(a) + lazysuzan_x, rr * sin(a) - lazysuzan_y);
    } else {
      rr = weight * (1.0 + lazysuzan_space / rr);
      return new PVector(rr * xx + lazysuzan_x, rr * yy - lazysuzan_y);
    }
  }
  
  PVector escher(PVector p, float weight) {
    float a = atan2(p.y, p.x);
    float lnr = 0.5 * log(p.magSq());
    float m = weight * exp(escher_vc * lnr - escher_vd * a);
    float n = escher_vc * a + escher_vd * lnr;
    return new PVector(m * cos(n), m * sin(n));
  }
  
  PVector edisc(PVector p, float weight) {
    float tmp = sq(p.x)+sq(p.y)+1.0;
    float tmp2 = p.x + p.x;
    float xmax = (sqrt(tmp + tmp2) + sqrt(tmp - tmp2)) * 0.5;
    float a1 = log(xmax + sqrt(xmax -1.0));
    float a2 = -acos(p.x / xmax);
    float w = weight / 4;
    float snv = p.y > 0.0 ? sin(a1) : -sin(a1);
    return new PVector( w * cosh(a2) * cos(a1), w * sinh(a2) * snv);
  }
  
  PVector elliptic(PVector p, float weight) {
    float tmp = sq(p.x)+sq(p.y)+1.0;
    float tmp2 = p.x + p.x;
    float xmax = (sqrt(tmp + tmp2) + sqrt(tmp - tmp2)) * 0.5;
    float a = p.x / xmax;
    float b = safesqrt(1.0 - sq(a));
    float x = weight * elliptic_v * atan2(a,b);
    float y = weight * elliptic_v * (random(0,1)<0.5?-1:1) * log(xmax + safesqrt(xmax-1.0));
    return new PVector(x,y);
  }
  
  PVector curve(PVector p, float weight) {
    float x = weight * (p.x + curve_xamp * exp(-p.y*p.y / curve_xlength2));
    float y = weight * (p.y + curve_yamp * exp(-p.x*p.x / curve_ylength2));
    return new PVector(x,y);
  }
  
  PVector lines(PVector p, float weight) {
    float r;
    if(lines_squared==1) r=0.5*sq(randomGaussian());
      else r=0.25*randomGaussian();
    float y = lines_scale * (floor(p.y/lines_scale) - 0.5 + r);
    return new PVector(weight * p.x, weight * y);      
  }

  PVector flower(PVector p, float weight) {
    float d = p.mag() + 1.0e-10;
    float r = weight * xmax * (random(0,1) - flower_holes) * cos(flower_petals * atan2(p.y,p.x)) / d;
    return new PVector(r * p.x, r * p.y);      
  }
  
  PVector spherical(PVector p, float weight) {
    float r = weight / (sq(p.x)+sq(p.y) + 1.0e-10);
    return new PVector(r * p.x, r * p.y);      
  }
  
  PVector horseshoe(PVector p, float weight) {
    float r = weight / (1.25 * (p.mag() + 1.0e-10));
    float x = r * ((p.x - p.y) * (p.x + p.y));
    float y = r * 2.0 * p.x * p.y;
    return new PVector(x,y);
  }
  
  PVector polar(PVector p, float weight) {
    float r = p.mag();
    float theta = atan2(p.x,p.y);
    float x = theta / PI;
    float y = r - 2.0;
    return new PVector(weight * 1.5 * x, weight * 1.5 * y);
  }

  PVector spiral(PVector p, float weight) {
    float r = p.mag() + 1.0e-10;
    float theta = atan2(p.x,p.y);
    float x = weight * 2.0 * (cos(theta) + sin(r)) / r;
    float y = weight * 2.0 * (sin(theta) - cos(r)) / r;
    return new PVector(x,y);
  }
  
  PVector hyperbolic(PVector p, float weight) {
    float r = p.mag() + 1.0e-10;
    float theta = atan2(p.x,p.y);
    float x = weight * sin(theta) / r;
    float y = weight * cos(theta) * r;
    return new PVector(x,y);
  }

  PVector diamond(PVector p, float weight) {
    float r = p.mag();
    float theta = atan2(p.x,p.y);
    float x = weight * 3.0 * sin(theta) * cos(r);
    float y = weight * 3.0 * cos(theta) * sin(r);
    return new PVector(x,y);
  }

  PVector ex(PVector p, float weight) {
    float r = p.mag();
    float theta = atan2(p.x,p.y);
    float xsin = sin(theta + r);
    float ycos = cos(theta - r);
    float x = weight * 0.7 * r * xsin * xsin * xsin;
    float y = weight * 0.7 * r * ycos * ycos * ycos;
    return new PVector(x+y,x-y);
  }
  
  PVector julia(PVector p, float weight) {
    float r = weight * 1.75 * sqrt(p.mag());
    float theta = 0.5 * atan2(p.x,p.y) + (int)(2.0 * random(0,1)) * PI;
    float x = r * cos(theta);
    float y = r * sin(theta);
    return new PVector(x,y);
  }
  
  PVector handkerchief(PVector p, float weight) {
    float r = 0.85*p.mag();
    float theta = atan2(p.x,p.y);
    float x = weight * r * sin(theta + r);
    float y = weight * r * cos(theta - r);
    return new PVector(x,y);
  }
  
  PVector disc(PVector p, float weight) {
    float r = PI*p.mag();
    float theta = 3.0 * weight * atan2(p.x,p.y) / PI;
    float x = theta * sin(r);
    float y = theta * cos(r);
    return new PVector(x,y);
  }
  
  PVector exponential(PVector p, float weight) {
    float r = PI * p.y;
    float sinr = sin(r);
    float cosr = cos(r);
    float d = weight * exp(p.x - 1);      
    return new PVector(d * cosr, d * sinr);  
  }
  
  PVector swirl(PVector p, float weight) {
    float r2 = sq(p.x)+sq(p.y);
    float sinr = sin(r2);
    float cosr = cos(r2);      
    float newX = 0.8 * (sinr * p.x - cosr * p.y);
    float newY = 0.8 * (cosr * p.y + sinr * p.y); 
    return new PVector(weight * newX,weight * newY);
  }

  PVector heart(PVector p, float weight) {
    float r = p.mag();
    float theta = atan2(p.y,p.x);
    float sinr = sin(r * theta);
    float cosr = cos(r * theta);
    return new PVector(weight * r * sinr, -r * weight * cosr); 
  }
  
  PVector power(PVector p, float weight) {
    float theta = atan2(p.y,p.x);
    float sinr = sin(theta);
    float cosr = cos(theta);
    float pow = weight * pow(p.mag(),sinr);
    return new PVector(pow * cosr, pow * sinr); 
  }
  
  PVector eyefish(PVector p, float weight) {
    float r = weight * 4.0  / (p.mag() + 1.0) ;
    return new PVector(r * p.x, r * p.y);  
  }
  
  PVector fisheye(PVector p, float weight) {
    float r = weight * 4.0  / (p.mag() + 1.0) ;
    return new PVector(r * p.y, r * p.x);  
  }

  PVector bubble(PVector p, float weight) {
    float r = weight * 12.0  / (p.x*p.x+p.y*p.y + 4.0) ;
    return new PVector(r * p.x, r * p.y);  
  }

  PVector square(PVector p, float weight) {
    return new PVector(weight * 6.0 * (random(0,1)-0.5), weight * 6.0 * (random(0,1)-0.5));  
  }

  PVector cylinder(PVector p, float weight) {      
    return new PVector(weight*3.0*sin(p.x), weight*p.y);  
  }

  PVector waves(PVector p, float weight) {
    float x = p.x + waves_b * sin(p.y * (1.0 / (waves_c * waves_c) ));
    float y = p.y + waves_e * sin(p.x * (1.0 / (waves_f * waves_f) ));
    return new PVector(weight * x, weight * y);  
  }
 
  PVector popcorn(PVector p, float weight) {
    float x = p.x + popcorn_c * sin(tan(3.0 * p.y));
    float y = p.y + popcorn_f * sin(tan(3.0 * p.x));
    return new PVector(weight * 0.85 * x, weight * 0.85 * y);  
  }
  
  PVector sinusoidal(PVector p, float weight) {
    return new PVector(weight * 3.0 * sin(p.x),3.0 * sin(p.y));
  }
  
  PVector butterfly(PVector p, float weight) {
    float y2 = 2.0 * p.y;
    float r = weight * 1.3029400317411197908970256609023 * sqrt(abs(p.y * p.x) / (1.0e-10 + sq(p.x) + sq(y2)));
    return new PVector(r * p.x,r * y2); 
  }
  
  PVector cosine(PVector p, float weight) {
    float pix = p.x * PI;
    float x = weight * 0.8 * cos(pix) * cosh(p.y);
    float y = -weight * 0.8 * sin(pix) * sinh(p.y); 
    return new PVector(x,y); 
  }
  
  PVector rings(PVector p, float weight) {
    float r = p.mag();
    float theta = atan2(p.x,p.y);
    float r2 = weight * ( (r + rings_c2)%(2.0*rings_c2) + r * (1.0 - rings_c2) );
    float x = r2 * cos(theta);
    float y = r2 * sin(theta); 
    return new PVector(x,y); 
  }
  
  PVector fan(PVector p, float weight) {
    float r = weight * 0.8* p.mag();
    float theta = atan2(p.x,p.y);
    float ang;
    if( abs((theta + fan_f) % fan_cc) > fan_c2)
       ang = theta - fan_c2;
      else
       ang = theta + fan_c2;
    float x = r * cos(ang);
    float y = r * sin(ang); 
    return new PVector(x,y); 
  }
  
  PVector blob(PVector p, float weight) {
    float theta = atan2(p.x,p.y);
    float r = 0.86 * p.mag();
    r = weight * r * (blob_low + blob_bdiff * 0.5 + 0.5 * sin(blob_waves * theta));
    return new PVector(r * sin(theta), r * cos(theta));
  }
  
  PVector pdj(PVector p, float weight) {
    return new PVector( weight * 1.5 * (sin(pdj_a * p.y) - cos(pdj_b * p.x)),
                        weight * 1.5 * (sin(pdj_c * p.x) - cos(pdj_d * p.y)));
  }
  
  PVector bent(PVector p, float weight) {
    float nx = p.x;
    float ny = p.y;
    if(nx < 0) nx = nx + nx;
    if(ny < 0) ny = ny * 0.5;
    return new PVector(weight * nx, weight * ny);
  }
  
  PVector fan2(PVector p, float weight) {
    float r = weight * 0.8 * p.mag();
    float theta = atan2(p.x,p.y);
    float t = theta + fan2_y - floor((theta + fan2_y) / fan2_dx) * fan2_dx;
    float ang;
    if(t > fan2_dx2)
      ang = theta - fan2_dx2;
     else
      ang = theta + fan2_dx2;
    return new PVector(r * sin(ang), r * cos(ang));
  }
  
  PVector rings2(PVector p, float weight) {
    float r = p.mag();
    float theta = atan2(p.x,p.y);
    float d = weight*(r - 2.0 * rings2_val2 * floor( (r+rings2_val2)/(2.0 * rings2_val2)) + r * (1.0 - rings2_val2) );
    return new PVector(d*sin(theta),d*cos(theta));
  }  
    
  PVector perspective(PVector p, float weight) {
    float t = 1.0 / ((perspective_dist - p.y * perspective_vsin) + 1.0e-10);
    float x = weight * perspective_dist * p.x * t;
    float y = weight * perspective_vfcos * p.y * t;
    return new PVector(x,y);
  }    
    
  PVector vnoise(PVector p, float weight) {
    float theta = random(0,1) * TWO_PI;
    float d = weight * random(0,1);
    return new PVector(d*p.x*sin(theta),d*p.y*cos(theta));
  }  
    
  PVector julian(PVector p, float weight) {
    float a = (atan2(p.y,p.x) + TWO_PI * floor(julian_abspower * random(0,1)))/julian_power;
    float r = weight * 2.0 * pow(sq(p.x)+sq(p.y),julian_cpower);
    return new PVector(r*cos(a),r*sin(a));
  }
  
  PVector juliascope(PVector p, float weight) {
    int rnd = (int)(juliascope_abspower * random(0,1));
    float a;
    if(rnd % 2 == 0)
      a = (2 * PI * rnd +atan2(p.y,p.x))/juliascope_power;
     else
      a = (2 * PI * rnd -atan2(p.y,p.x))/juliascope_power;
    float r = weight * 2.0 * pow(sq(p.x)+sq(p.y),juliascope_cpower);
    return new PVector(r*cos(a),r*sin(a));
  }
  
  PVector blur(PVector p, float weight) {
    float a = TWO_PI * random(0,1);
    float r = weight * 3.0 * random(0,1);
    return new PVector(r*cos(a),r*sin(a));
  }
  
  PVector gaussian(PVector p, float weight) {
    float a = TWO_PI * random(0,1);
    float r = weight * 3.0 * (random(0,1) + random(0,1) + random(0,1) + random(0,1) - 2.0);
    return new PVector(r*cos(a),r*sin(a));
  }
  
  PVector realgaussian(PVector p, float weight) {
    float a = TWO_PI * random(0,1);
    float r = weight * 3.0 * randomGaussian();
    return new PVector(r*cos(a),r*sin(a));
  }
  
  PVector radialblur(PVector p, float weight) {
    float rndG = random(0,1) + random(0,1) + random(0,1) + random(0,1) - 2.0;
    float a = atan2(p.y,p.x) + radialblur_spinvar * rndG;
    float r = p.mag();
    float rz = radialblur_zoomvar * rndG - 1.0;
    float x = r * cos(a) + rz * p.x;
    float y = r * sin(a) + rz * p.y;
    return new PVector(weight * x, weight * y);
  }
  
  PVector pie(PVector p, float weight) {
    int sl = (int)(random(0,1) * pie_slices + 0.5);
    float a = pie_rotation + TWO_PI * (sl + random(0,1) * pie_thickness)/pie_slices;
    float r = weight * 3.0 * random(0,1);
    return new PVector(r * cos(a),r * sin(a));
  }
  
  PVector ngon(PVector p, float weight) {
    float rfactor = pow(sq(p.x)+sq(p.y),ngon_pow);
    float theta = atan2(p.y,p.x);
    float phi = theta - (ngon_b * floor(theta/ngon_b));
    if(phi > ngon_b/2.0) phi -= ngon_b;
    
    float amp = 2.0 * weight * (ngon_corners * (1.0 / (cos(phi) + 1.0e-10) -1.0) + ngon_circle);
    amp /= (rfactor + 1e-10);
    
    return new PVector(p.x * amp,p.y * amp);
  }

  PVector curl(PVector p, float weight) {
    float re = 1 + curl_c1 * p.x + curl_c2 * (sq(p.x)-sq(p.y));
    float im = curl_c1 * p.y + curl_c2 * 2 * p.x * p.y;
    float r = weight / (re * re + im * im);
    
    return new PVector(r * (p.x * re + p.y * im),r * (p.y * re - p.x * im));
  }

  PVector wedgejulia(PVector p, float weight) {
    float r = weight * pow(sq(p.x)+sq(p.y),wedgejulia_cn);
    int t_rnd = (int) ((wedgejulia_rN) * random(0,1));
    float a = (atan2(p.y,p.x) + TWO_PI * t_rnd) / wedgejulia_power;
    float c = floor((wedgejulia_count * a + PI) * (1/PI) * 0.5);
    a = a * wedgejulia_cf + c * wedgejulia_angle;
    
    return new PVector(r * cos(a), r * sin(a));
  }
   
  PVector circus(PVector p, float weight) {
    float r = p.mag();
    if(r<1.0)
      r *= circus_size;
     else
      r /= circus_size;
    
    float theta = atan2(p.y,p.x);
    
    return new PVector(weight * r * cos(theta), weight * r * sin(theta));
  }  
 
  PVector rectangles(PVector p, float weight) {
    float x = weight * ((2 * floor(p.x/rectangles_x) + 1)* rectangles_x - p.x);
    float y = weight * ((2 * floor(p.y/rectangles_y) + 1)* rectangles_y - p.y);
    
    return new PVector(x,y);
  }
 
  PVector arch(PVector p, float weight) {
   float a = PI * random(0,1) * arch_weight;
   float sa = sin(a);
   float ca = cos(a);
   return new PVector(weight * sa, weight * sq(sa)/ca);
  }  
    
  PVector tangent(PVector p, float weight) {
    return new PVector(weight * sin(p.x) / (cos(p.y)+1.0e-10), weight * tan(p.y));
  }  

  PVector rays(PVector p, float weight) {
    float a = PI * random(0,1) * rays_weight;
    float r = tan(a) * rays_weight / (p.magSq() + 1.0e-10);
    
    return new PVector(weight * r * cos(p.x), weight * r * sin(p.y));
  }  
 
  PVector blade(PVector p, float weight) {
    float a = random(0,1) * blade_weight * p.mag();
    float sa = sin(a);
    float ca = cos(a);
    
    return new PVector(weight * 0.8 * p.x * (ca + sa), weight * 0.8 * p.x * (ca - sa));
  }  
  
  PVector secant(PVector p, float weight) {
    float a = secant_weight * p.mag();
    float ca = cos(a);
    float icr = 1.0 / (ca + 1.0e-10);
    float y;
    if(ca < 0)
      y = icr + 1.0;
     else
      y = icr - 1.0;
    
    return new PVector(weight * 0.8 * p.x, weight * 0.8* y);
  }  
    
  PVector twintrian(PVector p, float weight) {
    float a = random(0,1) * twintrian_weight * p.mag();
    float sa = sin(a);
    float cla = cos(a) + log(sq(sa));
    if(cla<-30) cla = -30;
    return new PVector(weight * 0.8 * p.x * cla, weight * 0.8 * p.x * (cla - sa * PI));
  }    
  
   PVector cross(PVector p, float weight) {
    float r = sqrt(1.0 / (sq(sq(p.x)-sq(p.y)))+1.0e-10);
    return new PVector(weight * 0.8 * p.x * r,weight * 0.8 * p.y * r);
  }  
   
  PVector disc2(PVector p, float weight) {
    float t = disc2_timespi * (p.x+p.y);
    float r = weight * atan2(p.x,p.y) / PI;
    float x = 0.8 * r * (sin(t) + disc2_cosadd);
    float y = 0.8 * r * (cos(t) + disc2_sinadd);
    return new PVector(x,y);
  }  
 
  PVector supershape(PVector p, float weight) {
    float theta = supershape_pm_4 * atan2(p.y,p.x) + QUARTER_PI;
    float t1 = pow(abs(cos(theta)),supershape_n2);
    float t2 = pow(abs(sin(theta)),supershape_n3);
    float r = weight * ((supershape_rnd * random(0,1) + (1.0 - supershape_rnd) * p.mag()) - supershape_holes) * pow(t1+t2,supershape_pneg1_n1) / p.mag();
    return new PVector( r * p.x, r * p.y);
  }
   
  PVector conic(PVector p, float weight) {
    float r = weight * (random(0,1) - conic_holes) * conic_eccentricity / (1.0 + conic_eccentricity * (p.x / p.mag())) / p.mag();
    return new PVector( r * p.x, r * p.y);
  }  
    
  PVector parabola(PVector p, float weight) {
    float r = sin(p.mag()); 
    return new PVector( weight * parabola_height * sq(r) * random(0,1), weight * parabola_width * cos(p.mag()) * random(0,1) );
  }      
 
  PVector bent2(PVector p, float weight) {
    float x = p.x;
    float y = p.y;
    if(p.x < 0)
      x = p.x * bent2_x;
    if(p.y < 0)
      y = p.y * bent2_y;
    return new PVector( weight * x, weight * y );
  } 
  
  PVector boarders(PVector p, float weight) {
    float roundx = round(p.x);
    float roundy = round(p.y);
    float offsetx = p.x - roundx;
    float offsety = p.y - roundy;

    float x = offsetx * 0.5 + roundx;
    float y = offsety * 0.5 + roundy;
    
    if(random(0,1)<0.75) {
      if(abs(offsetx) >= abs(offsety)) {
        
       if(offsetx >= 0) {
         x += 0.25;
         y += 0.25 * offsety / offsetx; 
       } else {
         x -= 0.25;
         y -= 0.25 * offsety / offsetx; 
       }
        
      } else {
        
        if(offsety >= 0) {
         x += offsetx / offsety * 0.25;
         y += 0.25;
       } else {
         x -= offsetx / offsety * 0.25;
         y -= 0.25; 
       }
        
      }
    }
    return new PVector( weight * x, weight * y );
  } 
   
  PVector bipolar(PVector p, float weight) {
    float r2 = sq(p.x) + sq(p.y);
    float t = r2 + 1.0;
    float x2 = p.x + p.x;
    float y = 0.5 * atan2(p.y+p.y,r2-1.0) + bipolar_ps;
    
    if(y > HALF_PI) 
      y = -HALF_PI + (y + HALF_PI) % PI;
    else 
       if(y < -HALF_PI)
        y = HALF_PI - (HALF_PI - y) % PI; 
    
    float f = t + x2;
    float g = t - x2;
    
    if( (g==0) || (f/g <= 0)) return new PVector(p.x,p.y);
    
    return new PVector( weight * 0.25 * HALF_PI * log(f/g),
                        weight * HALF_PI * y);
  }  

  PVector cell(PVector p, float weight) {
    float x = floor(p.x/cell_size);
    float y = floor(p.y/cell_size);
    
    float dx = p.x - x * cell_size;
    float dy = p.y - y * cell_size;
   
    
    if (y >= 0) {
      if (x >= 0) {
        y *= 2;
        x *= 2;
      }
      else {
        y *= 2;
        x = -(2 * x + 1);
      }
    }
    else {
      if (x >= 0) {
        y = -(2 * y + 1);
        x *= 2;
      }
      else {
        y = -(2 * y + 1);
        x = -(2 * x + 1);
      }
    }
    
    return new PVector(weight * (dx + x * cell_size-cell_size),
                       -weight * (dy + y * cell_size-cell_size));  
  }  
  
  PVector cpow(PVector p,float weight) {
    float a = atan2(p.y,p.x);
    float lnr = 0.5 * log(sq(p.x)+sq(p.y));
    float ang = cpow_vc * a + cpow_vd * lnr + cpow_va * floor(cpow_power * random(0,1));
    float m = weight * exp(cpow_vc * lnr - cpow_vd * a);
    return new PVector(m * cos(ang), m * sin(ang));
  }
  
  PVector fold(PVector p, float weight) {
    return new PVector(weight* (p.x % 3.0) ,weight*(p.y % 3.0));
  }  
    
  PVector foci(PVector p, float weight) {
    float expx = exp(p.x) * 0.5;
    float expnx = 0.25 / expx;
    float tmp = expx + expnx - cos(p.y) + 1.0e-10;
    float r = weight / tmp;
    return new PVector(r * (expx - expnx), r * sin(p.y));
  }  

  PVector loonie(PVector p, float weight) {
    float r2 = sq(p.x)+sq(p.y);
    float w2 = loonie_weight * loonie_weight;
    
    if( (r2 < w2) && r2 != 0) {
      float r = weight * sqrt(w2/r2 -1.0);
      return new PVector(r*p.x,r*p.y);
    } else 
      return new PVector(p.x,p.y);
  }  
  
  PVector polar2(PVector p, float weight) {
    float x = weight * 3/PI * atan2(p.x,p.y);
    float y = weight * 1.5/PI * log(sq(p.x)+sq(p.y));
    return new PVector(x,y);
  }

  PVector scry(PVector p, float weight) {
    float r2 = sq(p.x)*sq(p.y);
    float r = 3.0 / (p.mag() * (r2 + 1.0/scry_weight));
    float x = weight * r * p.x;
    float y = weight * r * p.y;
    return new PVector(x,y);
  }  
  
  PVector vexp(PVector p, float weight) {
    float r = weight * exp(p.x);
    return new PVector(r * cos(p.y),r * sin(p.y));
  }
    
  PVector rotate(PVector p, float angle) {
    float ca = cos(angle);
    float sa = sin(angle);
    return new PVector(ca * p.x - sa * p.y, sa * p.x + ca * p.y);
  }
  
  void draw(PVector p) {
    float i = map(p.x,xmin,xmax,screenl,screenr);
    float j = map(p.y,ymin,ymax,screenl,screenr);
    ellipse(i,j,1,1);
    //ellipse(i,j,0.8,0.8);
  }
  
}


final float cosh(float x) {
  return 0.5 * (exp(x) + exp(-x));
}

final float sinh(float x) {
  return 0.5 * (exp(x) - exp(-x));
}

final float tanh(float x) {
  return sinh(x)/cosh(x);
}

final float safesqrt(float x) {
  return (x<1e-10) ? 0.0 : sqrt(x);
}

final float sgn(float a) {
  if(a == 0.0) return 0.0;
  return a > 0.0 ? 1.0 : -1.0;
}

final float modulate(float amp, float freq, float x) {
   return amp * cos(x * freq * TWO_PI);
 }


final int bytemix (int a, int b) {
    return ((a & 0x5A5A) ^ (b & 0xA5A5));
}

final int bytexim (int a, int b) { // variation...
    return ((a & 0xAAAA) ^ (b & 0x5555));
}

final int byteshf (int a, int b) {
    return ((a << 8) ^ (b >> 8) ) & 0xFFFF;
}

final int bytezhf (int a, int b) { // variation...
    return ((a << 6) ^ (b >> 6)) & 0xFFFF;
}

final int byteprimes (int a, int b) { // variation...
    return ((a * 857 - 4) & 0xFF00 ^ (-b * 977 + 8) & 0x00FF ) ;
}

final float acosh(float a) {
  return log(a + sqrt(a-1) * sqrt(a+1));
}

final float random01() {
  return random(0.0,1.0)<0.5?1.0:0.0;
}

final float M_SQRT5 = 2.2360679774997898;
final float M_PHI = 1.61803398874989484820;
final float FFIVE = 1.0 / M_SQRT5;
final float FNATLOG = log(M_PHI);
final float M_SQRT2 = sqrt(2.0);

final float HSQRT2 = sqrt(2.0) / 2.0;

public static class Jacobi_elliptic_result {
    public float sn, cn, dn;

    public void clear() {
      sn = cn = dn = 0.0;
    }
}

public void Jacobi_elliptic(float uu, float emmc, Jacobi_elliptic_result res) {
    // Code is taken from IROIRO++ library,
    // released under CC share-alike license.

    res.clear();

    // less accurate for faster rendering (still very precise)
    final float CA = 0.0003; // (The accuracy is the square of CA.)

    float a, b, c = 0.0, d = 0.0, em[] = new float[13], en[] = new float[13];
    int bo;
    int l = 0;
    int ii;
    int i;
    // LOGICAL bo

    // main
    float emc = emmc;
    float u = uu;

    if (emc != 0.0) {
      bo = 0;
      if (emc < 0.0)
        bo = 1;

      if (bo != 0) {
        d = 1.0 - emc;
        emc = -emc / d;
        d = sqrt(d);
        u = d * u;
      }
      a = 1.0;
      res.dn = 1.0;

       for(i=0; i<13; i++){// original
      //for (i = 0; i < 8; i++) {
        l = i;
        em[i] = a;
        emc = sqrt(emc);
        en[i] = emc;
        c = 0.5 * (a + emc);
        if (abs(a - emc) <= CA * a)
          break;
        emc = a * emc;
        a = c;
      }

      u = c * u;
      res.sn = sin(u);
      res.cn = cos(u);

      if (res.sn != 0.0) {

        a = res.cn / res.sn;
        c = a * c;
        for (ii = l; ii >= 0; --ii) {
          b = em[ii];
          a = c * a;
          c = res.dn * c;
          res.dn = (en[ii] + a) / (b + a);
          a = c / b;
        }

        a = 1.0 / sqrt(c * c + 1.0);
        if (res.sn < 0.0)
          (res.sn) = -a;
        else
          res.sn = a;
        res.cn = c * (res.sn);
      }
      if (bo != 0) {
        a = res.dn;
        res.dn = res.cn;
        res.cn = a;
        res.sn = (res.sn) / d;
      }
    }
    else {
      res.cn = 1.0 / cosh(u);
      res.dn = res.cn;
      (res.sn) = tanh(u);
    }
  }


//VORONOI 

final static short VORONOI_MAXPOINTS = 25;

float vratio(PVector P, PVector Q, PVector U) {
  PVector tmp = new PVector(P.x, P.y);
  tmp.sub(Q);
  if (tmp.mag() == 0.0) return 1.0;
  PVector tmp2 = new PVector(U.x, U.y);
  tmp2.sub(Q);
  return 2.0 * (tmp2.dot(tmp)) / tmp.magSq();
}

int closest( PVector[] P, int n, PVector U) {
  float d2;
  float d2min = 1.0e10;
  int j=0;
  for (int i=0; i<n; i++) {
    PVector tmp = new PVector(P[i].x, P[i].y);
    tmp.sub(U);
    d2 = tmp.magSq();
    if (d2 < d2min) { 
      d2min = d2; 
      j=i;
    }
  }
  return j;
}

float voronoi( PVector[] P, int n, int q, PVector U) {
  float ratio;
  float ratiomax = -1.0e10;
  for (int i=0; i<n; i++)
    if (i!=q) {
      ratio = vratio(P[i], P[q], U);
      if (ratio > ratiomax) ratiomax = ratio;
    }
  return ratiomax;
}

class Hexes {
  static final float a_hex = 1.0 / 3.0;
  static final float b_hex = 1.7320508075688772935 / 3.0;
  static final float c_hex = -1.0 / 3.0;
  static final float d_hex = 1.7320508075688772935 / 3.0;
  static final float a_cart = 1.5;
  static final float b_cart = -1.5;
  static final float c_cart = 1.7320508075688772935 / 2.0;
  static final float d_cart = 1.7320508075688772935 / 2.0;
  
  final PVector[] cell_choice= { 
    new PVector(-1, -1), 
    new PVector(-1, 0), 
    new PVector(-1, 1), 
    new PVector(0, -1), 
    new PVector(0, 0), 
    new PVector(0, 1), 
    new PVector(1, -1), 
    new PVector(1, 0), 
    new PVector(1, 1)
  };
  
  float cellsize, power, rotate, scale;
  float rotSin, rotCos;
  
  Hexes(float cs, float p, float r, float s) {
    cellsize = cs;
    power = p;
    rotate = r;
    scale = s;
    rotSin = sin(rotate * TWO_PI);
    rotCos = cos(rotate * TWO_PI);
  }
  
  PVector cell_centre(int x, int y, float s) {
    float xx = (a_cart * x + b_cart * y) * s;
    float yy = (c_cart * x + d_cart * y) * s;
    return new PVector(xx,yy);
  }
  
  PVector transform(PVector p, float weight) {
    PVector[] P = new PVector[VORONOI_MAXPOINTS];
    PVector U = p.get();
    
    int Hx = (int)floor((a_hex * U.x + b_hex * U.y) / cellsize);
    int Hy = (int)floor((c_hex * U.x + d_hex * U.y) / cellsize);
    
    int i=0;
    for(int di =-1;di<2;di++) {
      for(int dj =-1;dj<2;dj++) {
        P[i] = cell_centre(Hx+di, Hy+dj, cellsize);
        i++;
      }
    }
    
    int q = closest(P,9,U);
    
    Hx += cell_choice[q].x;
    Hy += cell_choice[q].y;
    
    P[0] = cell_centre(Hx,Hy,cellsize);
    P[1] = cell_centre(Hx,Hy+1,cellsize);
    P[2] = cell_centre(Hx+1,Hy+1,cellsize);
    P[3] = cell_centre(Hx+1,Hy,cellsize);
    P[4] = cell_centre(Hx,Hy-1,cellsize);
    P[5] = cell_centre(Hx-1,Hy-1,cellsize);
    P[6] = cell_centre(Hx-1,Hy,cellsize);
    
    float L1 = voronoi(P,7,0,U);
    PVector Do = U.get();
    Do.sub(P[0]);
    
    float trgL = pow(L1+ 1.0e-10, power) * scale;
    
    PVector V = new PVector(Do.x * rotCos + Do.y * rotSin, -Do.x * rotSin + Do.y * rotCos);
    U = V.get();
    U.add(P[0]);
  
    float L2 = voronoi(P,7,0,U);
  
    float L = (L1 > L2) ? L1:L2;
    float R;
    if(L < 0.5) {
      R = trgL/L1;
    } else {
      if(L>0.8) {
        R = trgL / L2;
      } else {
        R = ((trgL / L1) * (0.8 - L) + (trgL / L2) * (L - 0.5)) / 0.3; 
      }
    }
  
    V.mult(R);
    V.add(P[0]);
    
    V.mult(weight);
    return V;
  }
}

class Crackle {
  final static int CACHE_NUM = 10;
  final static int CACHE_WIDTH = 21;
  
  PVector[] points = new PVector[VORONOI_MAXPOINTS];
  ArrayList<ArrayList<PVector>> c = new ArrayList<ArrayList<PVector>>();

  final PVector[] offset= { 
    new PVector(-1, -1), 
    new PVector(-1, 0), 
    new PVector(-1, 1), 
    new PVector(0, -1), 
    new PVector(0, 0), 
    new PVector(0, 1), 
    new PVector(1, -1), 
    new PVector(1, 0), 
    new PVector(1, 1)
  };
  
  float z, s, d, power, scale;

  Crackle(float zz, float ccellsize, float ddistort, float ppower, float sscale) {
    super();
    z = zz;
    s = ccellsize/2.0;
    power = ppower;
    scale = sscale;
    d = ddistort;
    
    for (int x=-CACHE_NUM; x<=CACHE_NUM; x++) {
      ArrayList<PVector> pv = new ArrayList<PVector>();
      for (int y=-CACHE_NUM; y<=CACHE_NUM; y++) {
        PVector v = position(x, y);
        pv.add(v);
      }
      c.add(pv);
    }
  }
  
  PVector position(int x, int y) {
    PVector E = new PVector(2.5, 2.5, 2.5);
    PVector F = new PVector(30.2, -12.1, 19.8);
    PVector v = new PVector(x, y, z);
    E.add(v);
    F.add(E);
    float xx = (x + d * noise(E.x, E.y, E.z)) * s;
    float yy = (y + d * noise(F.x, F.y, F.z)) * s;
    return new PVector(xx, yy);
  }

  PVector cached_position(int x, int y) {
    if (abs(x) <= CACHE_NUM && abs(y) <= CACHE_NUM) {
      return c.get(x+CACHE_NUM).get(y+CACHE_NUM);
    } else {
      return position(x, y);
    }
  }
  
  PVector transform(PVector p, float weight) {
    float blurr = p.mag();
    float theta = atan2(p.x,p.y);
    PVector U = new PVector(blurr * sin(theta), blurr * cos(theta));
    int xcv = (int)floor(U.x/s);
    int ycv = (int)floor(U.y/s);
    int i=0;
    for (int di=-1; di<2; di++)
      for (int dj=-1; dj<2; dj++) {
        PVector v = cached_position( xcv+di, ycv+dj);
        points[i] = v;
        i++;
      }

    int q = closest(points, 9, U);
    xcv += offset[q].x;
    ycv += offset[q].y;

    i=0;
    for (int di=-1; di<2; di++)
      for (int dj=-1; dj<2; dj++) {
        PVector v = cached_position( xcv+di, ycv+dj);
        points[i] = v;
        i++;
      }

    float L = voronoi(points, 9, 4, U);

    U.sub(points[4]);

    float R = (pow(L+1.0e-10, power) * scale) / (L + 1.0e-10);

    U.mult(R);
    U.add(points[4]);
    U.mult(weight);
    
    return U;
  }
}

private static HashMap<String, ArrayList<PVector>> dlawf_cache = new HashMap<String, ArrayList<PVector>>();

class DLAWF {
  int seed = 667776;
  int maxiter = 4000;
  int buffersize = 800;
  float scale = 4.0;
  
  DLAWF(float sseed, float mmaxiter, float bbuffersize, float sscale) {
    seed = (int)sseed;
    maxiter = (int)mmaxiter;
    buffersize = (int)bbuffersize;
    scale = sscale;
  } 
  
  String makeKey() {
    return buffersize + "_" + maxiter + "_" + seed;
  }
 
  PVector transform(PVector p, float weight) {
    PVector point = getRandomPoint();
    point.mult(weight);
    return point;
  } 
  

  PVector getRandomPoint() {
    ArrayList<PVector> points = getPoints();
    if(points.size() > 0) {
      PVector v = points.get((int)(random(0,1) * points.size()));
      return new PVector(v.x,v.y);
    } else return new PVector(0,0);
  }
  
  ArrayList<PVector> getPoints() {
    String key = makeKey();
    ArrayList<PVector> res = dlawf_cache.get(key);
    if(res == null) {
      short[][] points = calculate();
      res = new ArrayList<PVector>();
      for (int i = 0; i < points.length; i++) {
        for (int j = 0; j < points[i].length; j++) {
          if (points[i][j] != 0) {
            PVector point = new PVector();
            point.x = (((float) (float(i) - buffersize / 2.0)) / (float) buffersize )* scale;
            point.y = (((float) (float(j) - buffersize / 2.0)) / (float) buffersize )* scale;
            res.add(point);
          }
        }
      }
      dlawf_cache.put(key, res);
    }
    return res;
  }
  
  short[][] calculate() {
    int centre = buffersize / 2;
    int size2 = buffersize - 2;
    short q[][] = new short[buffersize][buffersize];
    randomSeed(seed);
    q[centre][centre] = 1;
    float r1 = 3.0;
    float r2 = 3.0 * r1;
    for (int i = 0; i < maxiter; i++) {
      float phi = TWO_PI * random(0,1);
      float ri = r1 * cos(phi);
      float rj = r1 * sin(phi);
      int ci = centre + (int) (ri + 0.5);
      int cj = centre + (int) (rj + 0.5);
      short qt = 0;
      while (qt == 0) {
        float rr = random(0,1);
        rr += rr;
        rr += rr;
        int rd = (int) rr;
        switch (rd) {
          case 0:
            ci++;
            break;
          case 1:
            cj--;
            break;
          case 2:
            ci--;
            break;
          default:
            cj++;
        }
        if ((ci < 1) || (ci > size2) || (cj < 1) || (cj > size2)) {
          qt = 1;
          i--;
        }
        else {
          int sum = q[ci - 1][cj] + q[ci + 1][cj] + q[ci][cj - 1] + q[ci][cj + 1];
          if (sum != 0) {
            q[ci][cj] = qt = 1;
            float r3 = (float) (ci - centre);
            float r4 = (float) (cj - centre);
            r3 *= r3;
            r4 *= r4;
            r3 += r4;
            r3 = sqrt(r3);
            if (r3 > r1) {
              r1 = r3;
              r2 = 2.1 * r1;
            }
          }
          else {
            float r3 = (float) (ci - centre);
            float r4 = (float) (cj - centre);
            r3 *= r3;
            r4 *= r4;
            r3 += r4;
            r3 = sqrt(r3);
            if (r3 > r2) {
              qt = 1;
              i--;
            }
          }
        }
      }
    }
    return q;
  }
  
}
