%
% David Z, Jan 22th, 2015
% global variables 
%

global g_ws_dir;        %% the root module dir, ./GraphSLAM ./Localization etc.
global g_data_dir;      %% the root of the data dir 
global g_data_prefix;   %% the prefix of the data files, e.g. 'd1' 'Data2' 'bb2mb'
global g_data_suffix;   %% the suffix of the data files, e.g. 'dat' 'bdat'
global g_camera_type;   %% load method differs according to different camera type

g_ws_dir = 'D:/work/SLAM/soonhac/';
% g_ws_dir = 'D:/work/soonhac';


% g_data_dir = 'D:/work/SLAM/soonhac/workstation_8.10.2014';
% g_data_dir = 'D:/work/SLAM/data2';
% g_data_dir = 'D:/work/data/l2o';
% g_data_dir = 'D:/work/data/Creative/data1';

% g_data_dir = 'D:/work/SLAM/soonhac/exp2_etas523_hallway_exp3';
% g_data_dir = 'D:/work/SLAM/soonhac/workstation_8.10.2014';
% g_data_dir = 'D:/work/data/SLAM/SR4000/workstation_8.10.2014';

% g_data_dir = 'D:/work/data/SLAM/Creative/dataset_5';
% g_data_dir = 'D:/work/data/Creative/data1';
% g_data_dir = 'D:/work/SLAM/pose_estimation/dataset_1';
% g_data_dir = 'D:/co_worker/pose_estimation/dataset_1';
% g_data_dir = 'D:/work/SLAM/pose_estimation/realsense';
% g_data_dir = 'D:/work/data/realsense/captured_data_EIT_5th_floor';

g_data_dir = 'C:/Users/fuyin/Desktop/work/code/github/slam_matlab/slam_matlab/VRO/Translation';

%% total number of frames 
global g_total_frames g_start_frame
g_start_frame = 1;
g_total_frames = 1600; 

% g_data_prefix = 'x';
% g_data_prefix = 'd1';
% g_data_prefix = 'f';
g_data_prefix = 'frm';
% g_data_prefix = 'Data2';
% g_data_prefix = 'bb2mb';
% g_data_prefix = 'l2o';

% !! notice, the data 'bdat' is binary file while 'dat' is not, 
% so call different function to read these two kinds of file in
% line 43,45 and 129, 131 in
% localization_sift_ransac_limit_cov_fast_fast_dist2_nobpc_binary
% or just call localization_sift_ransac_limit_cov_fast_fast_dist2_nobpc 
% wait!, these two have implemented different functions and flows, what'
% the mess! so, now I just change the load_sr_data method in 43, 45, 129,
% 131 in the lo***binary.m
% g_data_suffix = 'bdat';
g_data_suffix = 'dat'; 

% currently, smart_cane: SR, creative 
% g_camera_type = 'smart_cane';  % this is also the data_name
% g_camera_type = 'creative';
g_camera_type = 'vro_test'; % for vro test

global g_filter_type % filter the input camera data 
g_filter_type = 'gaussian';

global g_sift_threshold % sift detector threshold 
g_sift_threshold = 0 ; % not use any threshold in sift detection

%% display trajectory area [xmin xmax] ~ [ymin ymax]
global g_display g_dis_x_min g_dis_x_max g_dis_y_min g_dis_y_max 
g_display = false; %true;
g_dis_x_min = -3; %-10; % -7 -15
g_dis_x_max = 3; % 10;  % 15  5
g_dis_y_min = -5; %-5;
g_dis_y_max = 5 ;%15; 

%% weather to delete previous files or use middle result
% : features, matched points ... 
global g_delete_previous_data 
g_delete_previous_data = false; 

%% ransac parameters 
global g_ransac_iteration_limit g_minimum_ransac_num
g_ransac_iteration_limit = 500; % 0 200
g_minimum_ransac_num = 12; % minimum feature as input to ransac

%% depth filter parameter 
global g_depth_filter_max % max depth value for a camera frame
g_depth_filter_max = 5;  % 10, or 5 in different camera model

%% weather to compute the computational time 
global g_measure_ct 
g_measure_ct = false; 

%% video parameter 
global g_video_name g_record_video
% g_video_name = 'results/david_z.avi';
g_record_video = false;

%% middle data dir: feature, pose_std, matched_pointss
global g_feature_dir g_matched_dir g_pose_std_dir 
g_feature_dir = 'visual_feature_zh';
g_matched_dir = 'matched_points_zh';
g_pose_std_dir = 'pose_std_zh';


%% vro test src & tar data path 
global g_src_data_path g_tar_data_path g_vo_data_dir
g_vo_data_dir = g_data_dir;
% g_tar_data_path = strcat(g_vo_data_dir, strcat('/', 'image_1')); 
% g_src_data_path = strcat(g_vo_data_dir, strcat('/', 'image_2'));
g_tar_data_path = strcat(g_vo_data_dir, strcat('/', 'Y1')); 
g_src_data_path = strcat(g_vo_data_dir, strcat('/', 'Y4'));

global g_save_vro_middle_result 
g_save_vro_middle_result = false; % weather to save the middle result of vro

global g_save_feature_for_debug
g_save_feature_for_debug = false; % save the feature info for debugging my vo in sr_slam 

global g_data_height 
g_data_height = 144; % 480; % 144

%% for slam small movement 
global g_minimal_rotation g_minimal_translation 
g_minimal_rotation = 5/180*pi;
g_minimal_translation = 0.05; 


