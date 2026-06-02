function update_trajectory_size(model_name, n_rows)
% Updates the trajectory_matrix size in the waypoint manager data dictionary
% Called automatically by the model InitFcn before each simulation.
    sf_obj = sfroot();
    charts = sf_obj.find('-isa', 'Stateflow.EMChart');
    for c = 1:length(charts)
        if contains(charts(c).Path, 'Subsystem1/MATLAB Function')
            data = charts(c).find('-isa', 'Stateflow.Data');
            for d = 1:length(data)
                if strcmp(data(d).Name, 'trajectory_matrix')
                    new_size = sprintf('[%d, 10]', n_rows);
                    if ~strcmp(data(d).Props.Array.Size, new_size)
                        data(d).Props.Array.Size = new_size;
                        fprintf('trajectory_matrix size updated to [%d, 10]\n', n_rows);
                    end
                end
            end
        end
    end
end
