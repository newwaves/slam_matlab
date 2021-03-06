function [graph, initial, error] = add_edge_to_graph(vro_result, vro_pose_std,...
                                    graph, initial)
%
% David Z, 3/4/2015 
% add the result of vro into the graph structure 
%
import gtsam.*
error = 0;
n = size(vro_result,1); 
if n == 1 %% the first node
    %% add the original point
    % h_global = get_global_transformation_single('smart_cane');     
    % note: this function compute the rotation matrix that transform the first
    % camera coordinate align with the ground coordinate, makes the first
    % pose X-o-Z parallel with the ground plane, 
    %%%            y   z 
    %              |  /
    %              | /
    %       x -----|/     
    %      This is the coordinate of the SR4000 (z forward, y upward)
    % However, we do not need it currently, just use the [0,0,0,0,0,0] as
    % the first pose  
    rx=0;  ry=0;   rz=0;  tx=0;  ty=0;  tz=0;
    h_global = [euler_to_rot(rz, rx, ry) [tx ty tz]'; 0 0 0 1];
    rot = h_global(1:3,1:3);
    R = gtsam.Rot3(rot);
    t = gtsam.Point3(0, 0, 0);
    origin= gtsam.Pose3(R,t);
    initial.insert(0,origin);
    graph.add(NonlinearEqualityPose3(0, initial.at(0)));
end
%% get the result of current vro result, edge i1->i2
vt = vro_result(n,:); 
i1 = vt(1) - 1; 
i2 = vt(2) - 1;

%% construct the transformation information
t = gtsam.Point3(vt(6), vt(7), vt(8));
R = gtsam.Rot3.Ypr(vt(5), vt(3), vt(4));
dpose = gtsam.Pose3(R,t);
pose_std = vro_pose_std(n,3:end)';  %[ry rx rz tx ty tz]
pose_std =[pose_std(4:6); pose_std(2); pose_std(1); pose_std(3)];

%% add into graph 
pose_noise_model = noiseModel.Diagonal.Sigmas(pose_std);
graph.add(BetweenFactorPose3(i1, i2, dpose, pose_noise_model));
if i2>i1
    initial.insert(i2,initial.at(i1).compose(dpose));
else
    initial.insert(i1,initial.at(i2).compose(dpose.inverse));
end

end